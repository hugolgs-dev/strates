# Strates: Kemal → Amber V2 rewrite

## Context

`strates__old/` is a working Crystal snippet-sharing app ("a Ellie for Crystal") built on Kemal 1.11: ~250 lines of Crystal, 5 routes, raw SQLite SQL, no ORM, no auth, no tests. A snippet ("strate") is immutable — saving an edit inserts a *new* row recording its ancestor in `forked_from`, so history accumulates in layers (French *strates* = strata).

Two goals, in order:

1. **Evaluate Amber V2 vs Kemal** by rebuilding the same app on the framework's supported path (Grant, Micrate, Schema API, asset_pipeline, ECR).
2. **Fix the defects** carried in the old codebase rather than porting them. The old code has a confirmed XSS, a silently-corrupted constant, an error-swallowing rescue, a permanently-poisonable cache, and an unpaginated full-table scan on the homepage.

Target is **production**, not just a POC. That raises the bar on the third-party dependency (carc.in), request size caps, and the SQLite operational story.

Scaffold state: `amber new` already ran (Amber CLI 2.0.5, framework `2.0.0-beta.4`, Crystal 1.21.0). It generated a **MySQL** app; decision below is to move it to SQLite.

---

## Decisions taken

| Decision | Choice |
|---|---|
| Database | SQLite (replaces the generated MySQL wiring) |
| CodeMirror delivery | esbuild bundle → self-hosted, fingerprinted. No CDN. |
| Scope | Feature parity + fix the known defects. `Run` stays inert. |
| Old data | Not migrated. Fresh `db/seeds.cr`. |

### On SQLite in production

For this workload it is a sound choice, with hard constraints you are accepting:

- **Reads dominate overwhelmingly.** Writes are one INSERT per snippet creation/fork. There are no UPDATEs at all — the data model is append-only. This is close to the ideal SQLite profile.
- **WAL mode is required**, so readers never block the writer. Set it in the connection URL (`?journal_mode=wal&busy_timeout=5000`), as the old app already did.
- **Single host only.** SQLite cannot be shared across application servers. Horizontal scaling means migrating to Postgres. Grant makes that a driver + migration-dialect change, not a rewrite, but plan for it if traffic justifies it.
- **Backups are yours to arrange.** Use `sqlite3 db/strates.db ".backup"` or Litestream for continuous replication to object storage. A file on one disk is a single point of failure.
- Amber's docs state the V2 release smoke test runs on SQLite — it is the best-tested driver in this beta.

### On operating an unauthenticated public writer

Out of scope for this rewrite, but flagged because production changes the stakes: anonymous `POST` with no rate limit is an abuse vector. The plan caps request body size (see the schema), which closes the trivial disk-fill. Rate limiting and abuse reporting are follow-up work, not addressed here.

---

## 1. Move the scaffold to SQLite

Three files, then regenerate the lockfile.

**`shard.yml`** — replace the `mysql` dependency:

```yaml
dependencies:
  amber:
    github: amberframework/amber
    version: 2.0.0-beta.4
  grant:
    github: crimson-knight/grant
    commit: 2665a978b43ac608c68cde9243821f8f8f053372
  asset_pipeline:
    github: amberframework/asset_pipeline
    version: ~> 0.37.0
  sqlite3:
    github: crystal-lang/crystal-sqlite3
    version: ~> 0.23.0
```

**`config/database.cr`** — the adapter class is `Grant::Adapter::Sqlite` (verified at `lib/grant/src/adapter/sqlite.cr:40`):

```crystal
require "amber"
require "grant"
require "grant/adapter/sqlite"

Grant::Connections << Grant::Adapter::Sqlite.new(
  name: "primary",
  url: ENV["DATABASE_URL"]? || Amber.settings.database_url
)
```

**`config/environments/{development,test,production}.yml`** — set `database.url`, keeping WAL:

```yaml
database:
  url: "sqlite3:./db/strates_development.db?journal_mode=wal&busy_timeout=5000"
```

Note `.amber.yml` still says `database: mysql`; update it to `sqlite` so future generators emit SQLite-flavored migrations.

Then `shards update`. Grant enforces SQLite ≥ 3.24.0 at connection time (`lib/grant/src/grant/sqlite_version_check.cr:10`) — verify with `sqlite3 --version`.

**Verify:** `amber database migrate` creates the file; `amber database status` lists it.

---

## 2. Model — `src/models/snippet.cr`

Generate the migration scaffold with `amber generate model Snippet ...`, then hand-edit. The model:

```crystal
class Snippet < Grant::Base
  connection primary
  table snippets

  column id : Int64, primary: true
  column slug : String
  column name : String
  column content : String
  column crystal_version : String
  column forked_from : Int64?

  timestamps

  scope :recent, -> { order(created_at: :desc) }
end
```

Three improvements over the old schema, all free:

- `timestamps` gives real `Time` columns instead of RFC3339 `TEXT` (`strates__old/src/models/snippet.cr:40`), so ordering and comparison are typed.
- `updated_at` arrives for free and is honest — rows are never updated, so it always equals `created_at`, which documents the append-only design.
- The old `revisions` table (`strates__old/src/config/schema.cr:20-37`) is **not** carried over. It has zero rows and zero code references — an abandoned design superseded by `forked_from`.

### Slug generation

Fixes two defects: the alphabet was rebuilt per call (three range expansions + 62 heap-allocated one-char strings, inside a retry loop — `strates__old/src/models/snippet.cr:4`), and the rescue swallowed *every* SQLite error (`:50-51`), turning a disk-full or `SQLITE_BUSY` into a bogus "could not generate a unique slug".

```crystal
SLUG_CHARS  = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".chars
SLUG_LENGTH =  8

def self.generate_slug : String
  String.build(SLUG_LENGTH) do |io|
    SLUG_LENGTH.times { io << SLUG_CHARS.sample(Random::Secure) }
  end
end
```

Retry must be **collision-scoped** — re-raise anything else:

```crystal
rescue ex : SQLite3::Exception
  raise ex unless ex.message.try(&.includes?("UNIQUE constraint failed: snippets.slug"))
  # else: fall through and retry
end
```

62^8 ≈ 2.18 × 10^14, so a collision is effectively unreachable; the retry is belt-and-braces and the DB unique index is the real guarantee.

### Kill the create/fork duplication

`create` and `fork` in the old model (`:39-54` and `:56-74`) are near-copies — same timestamp, same retry loop, same INSERT columns, same rescue, same duplicated error literal. Collapse to one private helper that owns the retry and takes a block, with `create_snippet` and `fork_snippet` as thin callers. Fork becomes an ordinary Grant insert copying the parent's attributes rather than a raw `INSERT…SELECT`.

### Fix `DEFAULT_CONTENT`

`strates__old/src/models/snippet.cr:29-35` uses an **unquoted** heredoc, so `#{name}` interpolates at class-body scope and the constant's real value is `"Hello, Strates::Snippet!"`. Use `<<-'CRYSTAL'` to suppress interpolation. (Every current caller passes explicit content, so this is latent, not live — fix it anyway or delete the constant.)

### Migration — `db/migrations/<ts>_create_snippets.sql`

```sql
-- +micrate Up
CREATE TABLE snippets (
  id              INTEGER PRIMARY KEY,
  slug            TEXT NOT NULL UNIQUE,
  name            TEXT NOT NULL,
  content         TEXT NOT NULL,
  crystal_version TEXT NOT NULL,
  forked_from     INTEGER REFERENCES snippets(id),
  created_at      TIMESTAMP NOT NULL,
  updated_at      TIMESTAMP NOT NULL
);
CREATE INDEX idx_snippets_created_at ON snippets(created_at DESC);
CREATE INDEX idx_snippets_forked_from ON snippets(forked_from);

-- +micrate Down
DROP TABLE snippets;
```

The `created_at` index is the fix for the homepage sort — the old app had none and sorted the whole table on every load.

This replaces the old boot-time `CREATE TABLE IF NOT EXISTS` approach entirely (`strates__old/src/config/schema.cr`), which could never reconcile drift and had already diverged from the live database.

---

## 3. Crystal versions — `src/models/crystal_versions.cr`

The old `Versions` module (`strates__old/src/models/versions.cr`) has four production-relevant problems:

1. `@@cache ||= fetch` memoizes the **fallback** permanently — one carc.in outage at boot pins the version dropdown to a single entry until process restart (`:9`, `:24`).
2. `HTTP::Client.get` has **no timeout** — the first page load blocks on a third party indefinitely (`:17`).
3. A bare `rescue` hides network *and* parse errors alike (`:23`).
4. `@@cache ||=` is an unsynchronized check-then-assign across Amber's per-request fibers, and `fetch` yields on I/O — concurrent cold requests each fire their own HTTP call.

Replace with a mutex-guarded, TTL-refreshed, keep-last-good cache:

```crystal
module CrystalVersions
  FALLBACK = ["1.20.3"]
  TTL      = 1.hour

  @@mutex      = Mutex.new
  @@versions   = FALLBACK
  @@fetched_at : Time? = nil
end
```

Rules: seed with `FALLBACK` so nothing ever blocks on first paint; refresh when stale; **on failure keep the previous list and log** — never overwrite good data with the fallback; give `HTTP::Client` explicit `connect_timeout` and `read_timeout`.

**Accept this consequence explicitly:** version validation on writes depends on the cached list. If carc.in is unreachable *and* the cache never warmed, only `1.20.3` validates. Keep-last-good makes that a cold-start-only window rather than a permanent state.

---

## 4. Request validation — `src/schemas/snippet_input_schema.cr`

The old routes duplicate param extraction and both validations byte-for-byte across `POST /strates` and `POST /:slug/save` (`strates__old/src/routes/strates.cr:21-23` vs `:37-39`, complete with a stray `# ← add` dev marker at `:43`). One Schema API definition serves both:

```crystal
class SnippetInputSchema < Amber::Schema::Definition
  content_type "application/json"

  field :name, String, required: true, max_length: 200,
    normalize: ->(s : String) { s.strip }
  field :content, String, required: true, max_length: 100_000
  field :crystal_version, String, required: true

  validates_to SnippetInput, SnippetInputError
end
```

`crystal_version` cannot be a static enum — the valid set is dynamic. Use an instance-method validator delegating to `CrystalVersions.valid?`.

`max_length: 100_000` on `content` closes the unbounded-`TEXT`-with-no-auth disk-fill vector. Pick the real number against how large a plausible Crystal snippet is.

This also replaces `env.params.json`, which raised on malformed bodies and produced an uncaught 500 with a stack-trace page instead of a 400.

---

## 5. Controller — `src/controllers/snippets_controller.cr`

One controller, five actions. **Critical V2 semantic difference from Kemal:** `halt!` marks the context but *does not* interrupt control flow — later expressions still run. Every early exit must be an explicit `return`. This is the single most likely place to port a Kemal habit into a bug:

```crystal
def show
  snippet = Snippet.find_by(slug: params["slug"])
  return set_response(body: "Snippet not found", status_code: 404, content_type: "text/plain") if snippet.nil?

  respond_with do
    html { render("show.ecr") }
    json { snippet.to_json }
  end
end
```

`respond_with` is a genuine gain over Kemal — the JSON representation of a snippet comes free with no second action.

- `index` — `Snippet.recent.limit(PER_PAGE).offset(...)`, plus optional `name LIKE` search
- `show` — as above
- `create` — `SnippetInputSchema.validate(request)`, `Success`/`Failure` case
- `save` — resolve parent by slug → 404 or insert with `forked_from`
- `fork` — copy parent → redirect

`create` and `save` differ only in `forked_from`. Extract a private `persist(parent_id : Int64?)`; both actions become three lines.

### Pagination and search

The old homepage query (`strates__old/src/models/snippet.cr:10-15`) returns the **entire table** on every hit, unpaginated, sorted without an index, through a leading-wildcard `LIKE` that guarantees a full scan — and the `?1 = '' OR ...` shape defeats any index even when no search is active.

- Add `LIMIT`/`OFFSET` (`PER_PAGE = 25`).
- **Split the two paths**: no query → `Snippet.recent.limit(...)`, which now uses `idx_snippets_created_at`. With a query → the `LIKE` scan, but bounded by `LIMIT`.
- Leading-wildcard `LIKE` is still a scan. At a few thousand rows this is fine; SQLite **FTS5** is the correct fix if the table grows. Note it, don't build it now.

---

## 6. Routes — `config/routes.cr`

```crystal
routes :web do
  get  "/", SnippetsController, :index
  post "/:slug/fork", SnippetsController, :fork, {"slug" => /[a-zA-Z0-9]{8}/}
  get  "/:slug", SnippetsController, :show, {"slug" => /[a-zA-Z0-9]{8}/}
end

routes :api do
  post "/strates", SnippetsController, :create
  post "/:slug/save", SnippetsController, :save, {"slug" => /[a-zA-Z0-9]{8}/}
end
```

Two deliberate choices:

**Segment constraints.** The old `get "/:slug"` was a bare single-segment catch-all, so every unknown path (`/favicon.ico`, `/robots.txt`) returned the body `"Snippet not found"`. Constraining to exactly 8 alphanumerics makes non-slug paths fall through to the static pipeline and a real 404.

**CSRF pipeline split — this will block you on the first run if ignored.** The generated `:web` pipeline plugs `Amber::Pipe::CSRF`. The JSON `fetch()` calls carry no CSRF token, so they will be rejected. The `:api` pipeline (already generated, currently commented out) has no CSRF pipe. Since these endpoints are unauthenticated and session-less, CSRF protection buys nothing there — the attack it prevents requires ambient authority the app doesn't grant.

`POST /:slug/fork` stays on `:web` because it is a real HTML `<form method="post">`; add the `csrf_tag` helper inside that form.

---

## 7. Assets — esbuild → asset_pipeline

Amber's asset_pipeline **fingerprints and copies; it does not bundle**. CodeMirror 6 is ESM split across many small packages, so esbuild stays. Two stages, in order:

```
frontend/editor.js                              ← npm source (moved out of src/, now Crystal-only)
   │  npx esbuild --bundle --format=esm
   ▼
app/assets/javascript/vendor/editor.js          ← authored-tree input
   │  amber assets build
   ▼
public/assets/javascript/vendor/editor-<digest>.js
```

Nested logical paths are preserved by the compiler, so `javascript/vendor/editor.js` stays a distinct manifest entry.

**Two changes to `frontend/editor.js`:**

1. `export function mountEditor(...)` instead of assigning `window.mountEditor` (`strates__old/src/frontend/editor.js:8`). Import maps make the global unnecessary and it's avoidable global state.
2. Keep `StreamLanguage.define(ruby)` — Crystal has no CodeMirror 6 grammar and Ruby's is a good approximation.

**`package.json`:**

```json
"build:js": "esbuild frontend/editor.js --bundle --format=esm --outfile=app/assets/javascript/vendor/editor.js --minify"
```

**Gitignore `app/assets/javascript/vendor/editor.js`.** It is a 401KB build artifact; the old repo committed it and shipped a commit literally titled *"forgot to minify editor.js"*. Build it in deploy instead. Consequence: a fresh clone must run `npm ci && npm run build:js` **before** `amber assets build`, or the manifest lookup fails hard (the resolver is strict by design). Document this in the README.

**`amber watch` rebuilds Crystal assets but not the npm step.** Either run esbuild's `--watch` in a second terminal, or add the npm command to the `watch.run.build_commands` list in `.amber.yml`.

**Stylesheets** → `app/assets/stylesheets/`: merge `custom.css` + `codemirror.css` into `app.css`; keep `oat.min.css` vendored as its own logical entry. Drop the hand-written `/assets/...` paths — `stylesheet_link_tag` resolves through the manifest.

**Layout** (`src/views/layouts/application.ecr`) — extend the *existing* `javascript_importmap_tag`, never render a second map:

```ecr
<%= javascript_importmap_tag(
  {"app" => "javascript/app.js", "editor" => "javascript/vendor/editor.js"},
  preload: ["javascript/app.js"]
) %>
```

Do **not** preload `editor` — it's 401KB and the homepage only needs it if the user opens the New Strate dialog. Keep the old code's lazy mount (`strates__old/src/views/strates/list.ecr:80-86`), which was already right.

---

## 8. Views — `src/views/snippets/{index,show}.ecr`

Port the markup, fixing three things.

### The XSS (`strates__old/src/views/strates/strate.ecr:36-37`)

```erb
const view = mountEditor(document.querySelector(".code"),
                        <%= snippet[:content].to_json %>);
```

`to_json` escapes for JSON, **not for HTML script context**. Any snippet containing `</script>` terminates the block early and the remainder parses as HTML. Content is fully attacker-controlled through `POST /strates` and there is no auth. (The `name` field is correctly escaped at `:4` and in `list.ecr:66` — this one path was missed.)

Fix by removing the script context entirely — pass the document through a data attribute:

```ecr
<div class="code" data-doc="<%= HTML.escape(snippet.content) %>"></div>
```

```js
mountEditor(el, el.dataset.doc);
```

`dataset` returns the exact original string, and there is no parser context to escape out of.

### The invisible empty state (`strates__old/src/views/strates/list.ecr:50-51`)

A `<tr>` emitted outside any `<table>`. Browsers discard it, so "No snippets yet." renders as literally nothing. Move it inside the table or make it a plain `<p>`.

### Link hygiene

`target="_blank"` without `rel="noopener noreferrer"` at `strate.ecr:11` and `list.ecr:5-6`.

Also carried over as-is: the native `<dialog>` + invoker commands (`commandfor`, `command="show-modal"`, `closedby="any"`). These are Baseline-2025 with no fallback — fine if you've accepted that browser floor, worth a conscious decision now that this is production.

Layout partials (`header.ecr`, `footer.ecr`) move to `src/views/layouts/`. `src/views/index.ecr` in the old tree contains literally `<>` and is referenced nowhere — dropped.

---

## 9. Seeds — `db/seeds.cr`

```crystal
require "../config/*"
require "../src/models/**"
```

A handful of demo snippets exercising: a plain snippet, a fork chain (`forked_from` set), and a long snippet near the size cap. Keep it idempotent — guard on `Snippet.find_by(slug:)`.

---

## 10. Specs

The old suite was **broken by construction**: `spec/spec_helper.cr:2` required `src/strates.cr`, which calls `Kemal.run` at require time, so `crystal spec` booted an HTTP server against the real dev DB and hung forever. The only test asserted `false.should be_true`.

The generated Amber `spec/spec_helper.cr` already avoids this — it requires `config/*` and the source trees but never `Amber::Server.start`. Build on it:

- `spec/models/snippet_spec.cr` — slug uniqueness/shape, fork copies parent attributes and sets `forked_from`, content-size boundary
- `spec/schemas/snippet_input_schema_spec.cr` — required fields, `name` normalization/strip, over-length rejection, unknown `crystal_version` rejection
- `spec/requests/snippets_spec.cr` — `GET /` 200; `GET /<unknown>` 404; `POST /strates` valid → slug, invalid → 400; `POST /:slug/save` sets `forked_from`; `GET /:slug` with `Accept: application/json` returns JSON

Point `config/environments/test.yml` at a **separate** SQLite file and run `AMBER_ENV=test amber database migrate` before the suite.

---

## Execution order

1. SQLite swap (§1) → `shards update` → `amber database migrate`
2. Model + migration (§2) → model specs green
3. `CrystalVersions` (§3)
4. Schema (§4) → schema specs green
5. Controller + routes (§5, §6) — **CSRF pipeline split before first browser test**
6. Assets (§7) — `npm run build:js` before `amber assets build`
7. Views (§8)
8. Seeds (§9), request specs (§10)

---

## Verification

**Build and schema**
```bash
shards update
amber database migrate && amber database status
AMBER_ENV=test amber database migrate
```

**Assets** — order matters; the second command fails loudly if the first was skipped:
```bash
npm ci && npm run build:js
amber assets build
amber assets check
```
Then in the browser: View Source shows exactly one import map before the module entry point; every local mapped value is a fingerprinted `/assets/` URL; no module-resolution or CSP errors; `editor` is *not* preloaded on the homepage.

**Tests**
```bash
crystal spec        # must terminate — the old suite never did
amber routes        # confirm the table, especially the constrained :slug routes
```

**End to end** (`amber watch`, then):
```bash
curl -H 'Accept: application/json' http://127.0.0.1:3000/<slug>
curl -X POST http://127.0.0.1:3000/strates \
  -H 'Content-Type: application/json' \
  -d '{"name":"t","content":"puts 1","crystal_version":"1.20.3"}'
curl -X POST http://127.0.0.1:3000/strates \
  -H 'Content-Type: application/json' -d '{"name":"","content":""}'   # expect 400, not 500
curl -i http://127.0.0.1:3000/not-a-slug                              # expect 404, not "Snippet not found"
```

**XSS regression — do this one by hand.** Create a snippet whose content is:
```
</script><img src=x onerror=alert(1)>
```
Open its page. The editor must display that text verbatim; no alert, no broken markup, no injected element in the DOM inspector.

**Defect checklist** — confirm each old bug is gone: interpolated `DEFAULT_CONTENT`; script-context XSS; blanket `rescue SQLite3::Exception`; permanently-poisoned version cache; unpaginated homepage; invisible empty state; hanging spec suite.
