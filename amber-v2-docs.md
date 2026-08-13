# Amber Framework 2.0 Web Beta documentation

Canonical documentation bundle for https://amberframework.org/docs/v2.
Prefer V2-authored pages when an inherited maintenance reference conflicts with a V2 page.


---

## Amber 2.0 Beta

Canonical page: https://amberframework.org/docs/v2

# Amber 2.0 Beta

Amber `2.0.0-beta.4` is available for evaluation. This is a prerelease: expect
breaking changes and do not treat it as a production-support promise.

The release-gated first-run path is a server-rendered ECR web application
created by the standalone Amber CLI. It includes routing, controllers, typed
configuration, sessions, Grant ORM, Micrate migrations, SQLite, fingerprinted
static assets, tests, and a development watcher without requiring a database
server.

**Run from: a parent directory where `my_app/` can be created. Commands after
`cd my_app` run from the generated application root.**

```bash
brew install amberframework/amber_cli/amber_cli
amber new my_app
cd my_app
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
crystal spec
amber watch
```

Web is the default application type. `amber new my_app --type web` is the
explicit equivalent. Native generation is a separate preview surface.

Start with [Installation](getting-started/installation/) for the platform
matrix, checksums, and troubleshooting, then follow the
[web-app walkthrough](getting-started/). The
[web template reference](guides/web-template/) explains every generated layer
and its release boundary.

## What is in the framework beta

- MVC controllers and ECR views
- routing, pipelines, constraints, and named routes
- typed request schemas and validation
- memory-backed jobs, sessions, and WebSocket pub/sub
- mailer APIs
- typed YAML configuration with environment-variable overrides
- Grant ORM with SQLite by default and PostgreSQL/MySQL options
- Micrate-powered migrations and database maintenance commands
- database-backed model and HTML CRUD scaffold generators
- deterministic CSS, JavaScript, image, font, and file fingerprinting
- manifest-aware ECR helpers, SRI, compression, and immutable asset caching
- standalone CLI and diagnostics LSP

## What is preview

Generated authentication and API resources, Gemma file attachments, and
native-app generation have useful code and documentation, but they are not part
of the beta web-app release gate. Preview pages are labeled so new users do not
mistake them for the supported path.

See [Beta support](beta-support/) for the exact platform and generator matrix.

## Migrating

Amber V2 removes Kilt and Slang, adopts typed configuration, and extracts the
CLI from the framework repository. The new CLI template selects its driver and
Grant explicitly; the framework shard itself remains independent of an ORM.
Existing apps should follow the [migration guide](migration-guide/) and pin the
beta instead of a moving development branch.

## Help

- [Discord](https://discord.gg/vwvP5zakSn)
- [Framework issues](https://github.com/amberframework/amber/issues)
- [CLI issues](https://github.com/amberframework/amber_cli/issues)
- [Homebrew issues](https://github.com/amberframework/homebrew-amber_cli/issues)


---

## Beta Support

Canonical page: https://amberframework.org/docs/v2/beta-support

# Amber V2 Beta Support

**Status checked August 12, 2026.** Amber Framework `2.0.0-beta.4` and Amber
CLI `2.0.5` are the coordinated database-backed web beta. Amber `1.5.0`
remains the stable framework line.

“Beta” describes the V2 framework release, not an expectation that ordinary
web applications will be repeatedly rewritten. The supported path includes
routing, controllers, ECR, typed configuration, request schemas, Grant ORM,
Micrate migrations, SQLite, WebSockets, jobs, mailer, local CSS, and
browser-native modules. The release gate includes fingerprinted CSS,
JavaScript, images, fonts, SRI, caching, and compression. Generated
authentication, generated API resources, Gemma attachments, and native
applications keep separate preview boundaries.

## What each platform signal means

- **Web compile** means CI built Amber CLI, generated the database-backed web
  app, installed dependencies, generated the Pet scaffold, applied its test
  migration, ran specs, and compiled the application.
- **Install artifact** means the current CLI release publishes a ready-to-use
  archive or Homebrew package for that target.
- **Release-gated** means the supported installation, generation, dependency,
  migration, spec, build, launch, HTML form, create, update, and static-asset
  sequence must pass before release.

One signal does not silently imply the others.

## Platform matrix

| Platform | Database-backed web compile | CLI 2.0.5 install artifact | Beta release gate |
|---|---|---|---|
| Apple Silicon macOS | Verified | Homebrew and `darwin-arm64` archive | Yes |
| x86-64 Linux | Verified | Homebrew or `linux-x86_64` archive | Yes |
| ARM64 Linux | Verified on GitHub-hosted ARM64 Linux | `linux-arm64` archive | Yes |
| Windows x86-64 | Verified in GitHub Actions | None | No |
| Intel macOS | Not currently verified | None | No |

The [Amber CLI asset pull request](https://github.com/amberframework/amber_cli/pull/37)
is the current platform evidence stream. Windows installs the SQLite native library,
builds the CLI, generates the same Grant application, applies the test
migration, runs its specs, and compiles the executable. It remains outside the
release gate only because CLI `2.0.5` does not publish a Windows archive.

## Application and generator matrix

| Command or surface | Status |
|---|---|
| `amber new APP --type web` | Supported; ECR, Grant, and SQLite default |
| homepage, fingerprinted CSS/JS/images/fonts, SRI, caching, compression | Release-gated |
| `amber assets build` and `amber assets check` | Supported and release-gated |
| `amber generate model` | Supported; Grant model, spec, and migration |
| `amber generate scaffold` | Supported; model, schema, HTML CRUD, ECR views, specs, route, migration |
| `amber generate migration` | Supported; Micrate Up/Down SQL |
| `amber database` | Supported; create, drop, migrate, status, version, rollback, redo, seed |
| controller, schema, job, mailer, channel generators | Supported |
| `amber generate api` and `amber generate auth` | Preview |
| `amber new APP --type native` | Preview |
| Grant guides | Supported default web model layer |
| Asset Pipeline guides | Supported web path |
| Gemma guides | Preview ecosystem material |

“Preview” means code can be evaluated, but it is not part of the web release
gate and may require additional design or production review. Preview does not
mean that the entire framework or a generated web application is unstable.

## Persistence contract

A generated web application contains:

- Grant pinned to the reviewed V2 commit;
- exactly one selected driver: SQLite, PostgreSQL, or MySQL;
- `config/database.cr` registering the `primary` connection;
- separate development, test, and production database URLs;
- Micrate inside the compiled CLI rather than as a second app command;
- model and scaffold generators that write reversible SQL under
  `db/migrations/`.

The release smoke test uses SQLite and exercises a real create and update
through the generated ECR forms. This proves the default integration, not every
query, database feature, or production topology. PostgreSQL and MySQL users
must test against the server versions they deploy.

## Versions

- Amber V2 framework beta: `2.0.0-beta.4` — published August 12, 2026
- Amber CLI: `2.0.5` — published August 12, 2026
- Asset Pipeline: `0.37.0` — published August 12, 2026
- Grant: reviewed commit pinned by Amber CLI `2.0.5`
- Micrate: `0.16.0-beta.1`, embedded and pinned by Amber CLI `2.0.5`
- Amber stable framework: `1.5.0` — published August 1, 2026
- Crystal: `>= 1.20.0, < 2.0`

Generated applications pin the framework prerelease exactly. Do not replace it
with `v2-dev`, `master`, or a personal Amber fork when following the supported
path. See the human-readable [release notes](/releases), the
[Pet Tracker](guides/pet-tracker/) acceptance journey, and the
[V1-to-V2 migration guide](migration-guide/) for the smallest safe upgrade.


---

## Getting Started

Canonical page: https://amberframework.org/docs/v2/getting-started

# Build Your First Amber V2 Web App

Complete [Installation](installation/) first. This walkthrough stays inside the
release-gated web path: Grant, Micrate, and SQLite are included; no database
server, Node.js process, or preview generator is required.

## Where the examples go

Start in a parent directory where `my_app/` can be created. After `cd my_app`,
all commands run from the application root beside `shard.yml`. File examples
name paths relative to that root; generated output is labeled explicitly.

## Create the project

```bash
amber new my_app --type web
cd my_app
```

Dependencies install automatically. If you used `--no-deps`, run `shards
install` now.

The generated project uses ECR, typed environment YAML, Grant, SQLite, and
static routes. Its `shard.yml` pins Amber `2.0.0-beta.4` from
`amberframework/amber` and the reviewed Grant V2 commit.

## Prove the clean scaffold works

```bash
amber assets check
crystal spec
crystal build src/my_app.cr -o bin/my_app
amber watch
```

Open <http://127.0.0.1:3000>, view its source, and follow the fingerprinted
stylesheet URL. This catches a manifest or static-route failure that a
homepage-only status check would miss.

## Understand the generated files

```text
my_app/
├── .amber.yml
├── shard.yml
├── config/
│   ├── application.cr
│   ├── database.cr
│   ├── routes.cr
│   ├── environments/
│   └── initializers/
├── app/assets/
│   ├── stylesheets/app.css
│   ├── javascript/app.js
│   ├── images/amber-crystal.svg
│   ├── images/favicon.svg
│   ├── fonts/.gitkeep
│   └── files/.gitkeep
├── public/assets/                    # generated; ignored by Git
│   ├── manifest.json
│   └── ...fingerprinted files...
├── spec/controllers/home_controller_spec.cr
└── src/
    ├── my_app.cr
    ├── controllers/
    └── views/
        ├── home/index.ecr
        └── layouts/application.ecr
```

For the complete file-by-file contract, including the intentionally empty
extension directories, read the [V2 web template guide](../guides/web-template/).

`.amber.yml` records CLI metadata. `config/environments/*.yml` uses nested V2
sections such as `server`, `database`, `session`, and `logging`. Environment
variables override values, for example:

```bash
AMBER_SERVER_PORT=8080 amber watch
```

## Understand the asset boundary

CLI `2.0.5` keeps authored browser files here:

```text
app/assets/
├── stylesheets/app.css
├── javascript/app.js
├── images/amber-crystal.svg
├── images/favicon.svg
├── fonts/.keep
└── files/.keep
```

It generates fingerprinted files and `manifest.json` under the gitignored
`public/assets/` directory. The commands are:

```bash
amber assets build
amber assets check
```

They must both pass before the application compiles or deploys. `amber watch`
will rebuild when a file under `app/assets/` changes. ECR uses logical paths
such as `stylesheet_link_tag("stylesheets/app.css")` and
`image_tag("images/amber-crystal.svg", alt: "")`; CSS uses real relative paths
to images and fonts. The manifest supplies the fingerprinted browser URL.

Read the [Asset Pipeline guide](../guides/assets/) before adding fonts,
responsive image variants, local JavaScript modules, or an earlier Sass or
TypeScript build stage. It shows the exact source and output path for each.

## Add a page

Generate a controller with ECR views:

```bash
amber generate controller Posts index show
```

The generator leaves request specs pending until routes exist. Add routes to
the generated `routes :web` block:

```crystal
get "/posts", PostsController, :index
get "/posts/:id", PostsController, :show
```

Then enable the matching request specs and run:

```bash
crystal tool format
crystal spec
```

## Add a typed request schema

```bash
amber generate schema Post title:string:required body:text
```

The Schema API is built into Amber core. See [Schema API](../guides/schema-api/)
for validation and controller integration.

## Add a persisted resource

Generate the Grant model, request schema, controller, ECR views, request and
model specs, Micrate migration, and resource route together:

```bash
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
AMBER_ENV=test amber database migrate
crystal spec
```

Open <http://127.0.0.1:3000/pets/new>. The complete file map and create/update
journey are in [Build a Pet Tracker](../guides/pet-tracker/).

## Know the beta boundary

Model, scaffold, and migration generators are part of the supported web path.
Generated API resources and authentication remain preview, and native
generation has a separate platform matrix. Read [Beta support](../beta-support/)
before using those surfaces.


---

## Amber CLI

Canonical page: https://amberframework.org/docs/v2/cli

# Amber CLI

Amber CLI `2.0.5` is the standalone project generator, development watcher,
generator suite, database tool, and diagnostics LSP for Amber V2.

```bash
brew install amberframework/amber_cli/amber_cli
amber --version
```

The fully qualified command follows Homebrew's tap-trust model. The formula is
`amber_cli`; the executable is `amber`.

## Supported quick start

**Run from: a parent directory where `my_app/` can be created. Commands after
`cd my_app` run from the generated application root.**

```bash
amber new my_app --type web
cd my_app
shards install
amber assets check
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
crystal spec
amber watch
```

## Commands

| Command | Beta status | Purpose |
|---|---|---|
| [`new`](new/) | Supported for web | Create web or preview native apps |
| [`generate`](generate/) | Mixed | Generate core or preview components |
| [`watch`](watch/) | Supported | Rebuild and restart the app |
| `routes` | Supported | List configured routes |
| `pipelines` | Supported | Inspect pipelines |
| `database` | Supported | Migrate, inspect, roll back, redo, and seed the generated database |
| `assets` | Supported | Build or verify the fingerprinted asset manifest |
| `setup:lsp` | Available | Configure the bundled diagnostics LSP |

Use `amber --help` and `amber COMMAND --help` for the installed version's exact
syntax.

## Asset commands

Run these from an Amber CLI `2.0.5` application root:

```bash
amber assets build
amber assets check
```

`build` fingerprints `app/assets/` into `public/assets/` and writes the manifest.
`check` verifies the manifest, emitted bytes, digests, SRI metadata, MIME types,
and precompressed files without changing them. `amber new` performs the first
build, and `amber watch` rebuilds assets before recompiling the application when
authored files change.


---

## Guides

Canonical page: https://amberframework.org/docs/v2/guides

# Guides

V2 keeps framework concepts that still apply—controllers, requests, responses,
sessions, routing, cookies, testing, and other stable APIs. An unchanged page
has no badge. **New** and **Updated** badges identify material written or
revised for V2.

Pages built around removed components are excluded rather than inherited.
Granite and Jennifer point to Grant replacements; legacy bundled-CLI commands
remain retired; assets and the standalone Amber CLI use their V2 guides.

## How to apply an example

Every code-bearing V2 guide now provides one of two placement contracts:

- a walkthrough labels each block with the exact **File**, **Files**, or
  **Run from** location and says whether to create, edit, replace, or inspect it;
- an API reference begins with **Where the examples go**, mapping declarations,
  usage fragments, configuration, views, and generated output to their normal
  application directories.

Paths are relative to the application root—the directory containing
`shard.yml`—unless a guide says otherwise. Treat `public/` as browser-served
application files only when the guide labels them as source; never hand-edit a
directory labeled as generated output.

## Supported beta core

- [Build a Pet Tracker](pet-tracker/) — the canonical first app, from routes to HTML, JSON, CSS, and browser-native JavaScript
- [Web template](web-template/) — exact output of Amber CLI 2.0.5
- [Asset Pipeline](assets/) — CSS, JavaScript, images, fonts, SRI, and immutable caching
- [Grant](models/grant/) — the default relational model layer
- [Migrations](models/grant/migrations/) — authored Micrate SQL and safe release workflow
- [Schema API](schema-api/) — typed request parsing and validation
- [WebSockets and live pages](websockets/) — server-rendered documents with channel-driven ES module updates
- [Background jobs](background-jobs/) — queues, retries, delayed work, work stealing, and capacity boundaries
- [Adapters](adapters/) — framework adapter concepts and extension points

## Preview ecosystem material

- [Native application template](native-preview/) — macOS, iOS, and Android preview
- [Gemma](uploads/) — separate attachment project

Preview pages describe work that can be evaluated, but they are not part of the
clean web-template compile guarantee. The Asset Pipeline is part of that
guarantee; add native and attachment projects deliberately.

## Use the docs with an assistant

[AI assistants](ai-assistants/) explains how to give ChatGPT, Claude, or Gemini
the current V2 source set. It also provides a single Markdown knowledge bundle
and a tested Custom GPT instruction contract. The assistant should cite these
pages, preserve exact file locations, and name beta boundaries rather than
silently filling gaps from older Amber versions.

## Maintaining a V1 application

Amber 1.4.1 documentation remains available from the version selector. Choose
that version when maintaining an existing V1 application. V2 uses badges only
where a page is new or materially updated and uses replacement links where the
path changed.


---

## Deployment

Canonical page: https://amberframework.org/docs/v2/deployment

# Deployment

Deploy Amber V2 as a compiled Crystal executable. The beta does not publish a
verified one-click recipe for Heroku, Dokku, DigitalOcean, or another hosting
vendor. Those V1 pages depended on old Crystal versions, Webpack or Node asset
builds, bundled database commands, Redis defaults, and retired buildpacks, so
they are not carried into V2.

The portable deployment contract is:

1. install production shard dependencies;
2. build and verify application-authored assets;
3. run the test suite;
4. compile the application target in release mode;
5. package the binary, configuration, and public files as one release;
6. provide production configuration through environment variables; and
7. run the binary behind a TLS-terminating reverse proxy or managed ingress.

```bash
shards install --production
amber assets build
amber assets check
crystal spec
shards build my_app --release
```

An existing application upgraded without CLI `2.0.5` can run
`crystal run scripts/build_assets.cr` and its verification wrapper as documented
in [Asset Pipeline](../guides/assets/). Never start the web process to generate
assets and never rely on a first request to populate `public/`.

The generated target writes `bin/my_app`. Build on the same operating-system
and CPU family used by the runtime unless you have deliberately configured a
cross-compilation toolchain.

## Asset release artifact

A manifest-enabled release contains, at minimum:

```text
bin/my_app
config/
public/robots.txt
public/assets/manifest.json
public/assets/...fingerprinted files...
```

The compiler also writes deterministic `.gz` companions for compressible
files. A compatible Amber static handler can select them for clients accepting
gzip while preserving the original content type and `Vary: Accept-Encoding`.
If a reverse proxy handles compression instead, test that the two layers do not
produce conflicting encodings.

Deploy the entire release to a new directory and verify it before shifting
traffic. Fingerprinted URLs can use
`Cache-Control: public, max-age=31536000, immutable`; HTML, the manifest, and
unfingerprinted paths must revalidate. Keep the prior complete release available
for rollback while its HTML may still be cached.

**File: `config/environments/production.yml` — use the typed top-level static
section for the fallback policy on unfingerprinted files.**

```yaml
static:
  headers:
    Cache-Control: "no-cache"
```

Do not put this under the legacy `pipes:` shape in a V2 configuration file.
Amber's static handler overrides the fallback with one-year immutable caching
when the requested filename contains a content fingerprint.

Runtime uploads are not in this artifact. Put them on a persistent mounted
volume or in object storage, with independent backup and access controls. Never
run user-controlled files through the authored-asset compiler.

## Required runtime configuration

```bash
export AMBER_ENV=production
export AMBER_SERVER_HOST=0.0.0.0
export AMBER_SERVER_PORT=3000
export AMBER_SERVER_SECRET_KEY_BASE="replace-with-a-long-random-secret"
./bin/my_app
```

Set `DATABASE_URL` to the production database selected by the application. The
default V2 web template includes Grant and SQLite; PostgreSQL and MySQL apps
include their selected driver instead. Never commit the production secret or
database credentials or inject them into a container image.

Run migrations as an explicit release step before starting code that requires
the new schema:

```bash
AMBER_ENV=production DATABASE_URL="..." amber database migrate
```

## Platform checklist

- Route external HTTPS traffic through a reverse proxy or managed ingress.
- Forward to the port in `AMBER_SERVER_PORT`; do not run the process as root to
  bind directly to ports 80 or 443.
- Preserve termination signals so the process can shut down cleanly.
- Capture standard output and standard error with the platform log service.
- Restart failed processes with the platform supervisor.
- Back up and prove restore before applying production migrations.
- Start the application with the release directory read-only; only explicit
  runtime-data locations should be writable.
- Request one fingerprinted CSS, JavaScript, image, font, and binary URL and
  verify its bytes, MIME type, compression, and cache headers before shifting
  traffic.

Continue with [Manual binary deployment](manual-deploy/) for a concrete Linux
service example.


---

## Examples

Canonical page: https://amberframework.org/docs/v2/examples

# Examples

{% page-ref page="amber-auth.md" %}

{% page-ref page="crystal-debug.md" %}

{% page-ref page="json-api-full-crud.md" %}

{% page-ref page="minimal-configuration.md" %}


---

## Cookbook

Canonical page: https://amberframework.org/docs/v2/cookbook

# Cookbook

This Amber Cookbook is inspired by original [Kemal Cookbook](http://kemalcr.com/cookbook/hello_world/) by [@sdogruyol](https://github.com/sdogruyol)

{% page-ref page="from-scratch.md" %}

{% page-ref page="hello-world.md" %}

{% page-ref page="cors.md" %}

{% page-ref page="file-download.md" %}

{% page-ref page="file-upload.md" %}

{% page-ref page="authenticate.md" %}

{% page-ref page="json-api.md" %}

{% page-ref page="json-mapping.md" %}

{% page-ref page="websocket-chat.md" %}


---

## Migration Guide

Canonical page: https://amberframework.org/docs/v2/migration-guide

# Migration Guide: Amber 1.x to 2.0

Start with the smallest possible upgrade. For many Amber 1.x applications that
already use ECR and do not depend on Amber's old bundled integrations, the
first—and sometimes only—application change is the Amber version in
`shard.yml`. V2 is mostly additive framework work, not an invitation to rewrite
your product.

The standalone Amber CLI is independent from this runtime upgrade. Install or
update it when you want V2 generators; an existing application can change its
framework shard without being regenerated.

> Amber `2.0.0-beta.4` release-gates the framework core and the new ECR web
> template with Grant, Micrate, and SQLite. Existing applications do not have
> to replace a working ORM to adopt the framework beta. Gemma, Asset Pipeline,
> generated auth/API resources, and native output remain separate previews.

## Try the direct upgrade first

**File: `shard.yml` — change the existing `amber` dependency version.**

```yaml
dependencies:
  amber:
    github: amberframework/amber
    version: 2.0.0-beta.4
```

Keep the rest of the application's dependencies unchanged for this first pass.

**Run from: the application root, beside `shard.yml`.**

```bash
shards update amber
crystal spec
shards build
```

If those commands pass, launch the application through its normal development
command and smoke-test the routes it actually serves. You do not need to adopt
the Schema API, replace an ORM, remove working front-end tooling, or regenerate
the project merely because V2 offers newer options.

## When the direct upgrade needs a follow-up

The migration remains bounded, but it is not literally one line for every
application. Check the matching row only when the application uses that feature:

| Existing application uses | Follow-up |
|---|---|
| ECR views and public static files | Usually no view-system migration |
| Slang or another Kilt renderer | Convert those templates to ECR |
| Amber's bundled Redis assumptions | Select and verify explicit session and pub/sub adapters |
| Database drivers that arrived through Amber | Declare the application's driver directly |
| Old `YAML.mapping` configuration types | Move those types to `YAML::Serializable` |
| Framework-internal require paths | Replace them with the public Amber entry point or current API |
| A working Webpack or other asset build | Keep it during the framework upgrade; migrate it separately if useful |

This inventory is why the guide contains more than a version edit. It is a map
for the exceptions, not evidence that an ordinary Amber application must be
rebuilt.

## What changes in V2

| Application boundary | Amber 1.x starting point | Amber 2.0 path |
|---|---|---|
| Views | ECR, Slang, or Kilt | ECR for new and generated V2 views |
| JavaScript and CSS | Commonly Webpack-managed | The released manifest fingerprints browser-ready CSS, JS, images, and fonts without a bundler |
| Persistence | Commonly Granite or Jennifer | Existing apps may keep their working ORM; new CLI apps use Grant and a selected driver |
| Sessions | Redis-oriented configuration | Built-in memory adapter or an explicitly registered external adapter |
| WebSocket pub/sub | Redis-oriented configuration | Built-in in-process adapter or an explicitly registered external adapter |
| Request validation | Controller-specific parsing | Optional typed Schema API |
| File attachments | Application-specific integration | No bundled attachment library; Gemma is an ecosystem preview |

## Before changing dependencies in a production application

Create a migration branch and capture a working baseline:

1. Record the Crystal, Amber, ORM, database-driver, Redis, and asset-tool versions.
2. Run the existing specs and build the application binary.
3. Smoke-test the routes, session behavior, background work, WebSockets, and
   static assets the application actually uses.
4. Back up the database and prove the restore procedure before changing an ORM
   or running a schema migration.
5. List every Slang/Kilt template, Webpack entry point, Redis integration, and
   framework-generated file that will need an explicit decision.

Do not begin by deleting the old asset, persistence, or session configuration.
Keep the last working path available until its replacement has passed the same
checks.

## 1. Restore the framework baseline

After the direct upgrade commands above, resolve any compile errors against the
[V2 routing](../guides/routing/),
[controllers](../guides/controllers/), [views](../guides/views/), and
[configuration](../getting-started/) guides. Keep persistence and asset-tool
changes out of this step whenever possible.

## 2. Move generated and legacy views to ECR

Amber V2 removes Kilt and Slang from the supported framework path. Convert one
view boundary at a time, preserve its rendered HTML contract, and run the
request or feature specs that exercise it. New V2 generators emit ECR.

The [Views guide](../guides/views/) documents layouts, partials, helpers, and
escaping behavior for the V2 path.

## 3. Make sessions and pub/sub explicit

Amber V2 includes in-memory session and pub/sub adapters. They keep a clean
application independent of Redis, but their state is local to one process.

Applications that require shared state across processes or hosts must register
and test an external implementation. Redis is not a built-in adapter guarantee;
it is one backend an application can integrate through the adapter interfaces.

Use the [Redis-to-adapters guide](redis-to-adapters/) to inventory the existing
behavior, then verify expiration, logout, session rotation, broadcasts, and
multi-process delivery before switching production traffic.

## 4. Keep an existing persistence migration separate

Amber CLI `2.0.5` installs Grant and SQLite in a newly generated web
application. That default does not require an existing Granite or Jennifer
application to change ORM during the framework upgrade. Keep its current
persistence layer for the first pass, then verify compatibility against the
application's Crystal version, shard versions, and real queries.

If you choose to move to Grant, treat that as a second migration with its own
branch, database backup, restore proof, schema diff, representative reads and
writes, and rollback plan. Do not mix two ORMs unless ownership of connections,
transactions, migrations, and models is explicit. Review the
[model-layer boundary](../guides/models/) and
[Granite-to-Grant guide](granite-to-grant/) first.

## 5. Preserve working assets before replacing tooling

Released CLI `2.0.5` compiles browser-ready files from `app/assets/` into a
fingerprinted `public/assets/` manifest without requiring Node.js or a bundler.
That does not require an existing application to remove a working Webpack
pipeline during the framework upgrade.

If you adopt native ESM and the build-time Asset Pipeline contract, treat it as
its own migration. Compare the complete manifest; rewritten local
CSS and JavaScript dependencies; image, font, and binary bytes and MIME types;
import behavior; cache headers; read-only runtime; and atomic production
deployment before retiring the previous build. The
[Webpack-to-ESM guide](webpack-to-esm/) and [Asset Pipeline guides](../guides/assets/)
describe that independently reviewable migration; existing asset tooling may
remain in place while the framework dependency changes.

## 6. Adopt optional V2 features after the baseline passes

Schema API, jobs, mailers, adapters, and expanded testing helpers can be adopted
independently. Add one application boundary, write or update its specs, and
restore the complete build before moving to the next.

## Verification gates

Use observed behavior instead of an estimated migration timeline:

| Gate | Evidence to keep |
|---|---|
| Framework | Dependency resolution, complete specs, and a compiled application binary |
| HTTP | Representative request specs for routes, pipelines, parameters, redirects, and errors |
| Sessions | Login/logout, expiration, rotation, cookie settings, and multi-process behavior where required |
| WebSockets | Subscription, broadcast, reconnect, and cross-process delivery where required |
| Assets | One build manifest; strict CSS, JavaScript, image, font, and binary lookups; rewritten dependency URLs; MIME/cache/compression responses; read-only runtime; and browser smoke tests |
| Persistence | Database backup/restore proof, migrations, transactions, and representative reads and writes |
| Deployment | A staging build produced through the same commands and configuration used in production |

A migration boundary is complete when its previous behavior is reproduced or an
intentional change is documented and tested—not when a predetermined number of
days has elapsed.

## Getting help

When reporting a migration problem, include the smallest failing example plus
the Crystal version, Amber version, previous Amber version, relevant shard
versions, exact command, and complete output.

- Review the [Amber V2 release notes](https://github.com/amberframework/amber/releases).
- Ask in the [Amber Discord](https://discord.gg/vwvP5zakSn).
- Report framework behavior in the [Amber issue tracker](https://github.com/amberframework/amber/issues).
- Report CLI and generator behavior in the [Amber CLI issue tracker](https://github.com/amberframework/amber_cli/issues).


---

## Troubleshooting

Canonical page: https://amberframework.org/docs/v2/troubleshooting

# Troubleshooting

This is a place to share common problems and solutions to them.

## Can't build my amber project

Sometimes, you are trying to build an amber project in a new machine and crystal doesn't have all dependencies required by default. Then, ensure to install all development packages for `openssl` `git`, `yaml`, `libevent`, and `sqlite3`, `postgresql`, or `mysql`.

{% hint style="info" %}
Also see [Installation Guide](guides/installation.md)
{% endhint %}

## Can't connect to database

Sometimes, you're trying to run your amber project and you get an database connection error. Then, ensure your database is running and the `database_url` is well specified on `config/environments/{your-enviroment-file}.yml`, or on `DATABASE_URL` environment variable. Also remember to run `bin/amber db drop create migrate` , before executing your project.

{% hint style="info" %}
Also see [Creating the Database](guides/create-new-app.md#creating-the-database)
{% endhint %}

## Can't update dependencies

On new [crystal 0.25.0 release](https://crystal-lang.org/2018/06/15/crystal-0.25.0-released.html), the `shards` command has a global cache issue, already reported [here](https://github.com/crystal-lang/shards/issues/211) and fixed on next version. Until crystal 0.25.1 is released, you can fix your dependencies by removing global shards cache and shards files.

```text
rm -rf ~/.cache/shards
rm -rf shard.lock
rm -rf lib
```

## Something else doesn't work

Ask around on the [Amber Discord](https://discord.gg/vwvP5zakSn), or [create an issue](https://github.com/amberframework/amber/issues).

If you figure it out, edit this document as a courtesy to the next person having the same problem.


---

## In Production

Canonical page: https://amberframework.org/docs/v2/in-production

# In Production

Amber is still changing and growing rapidly. Here we list the brave folks who have started to use it in production nonetheless, building and strengthening our community. Are you using Amber in production at your company or project? Please add yourself in alphabetical order to the list under the corresponding industry!

This page has been inspired by [Crystal in production](https://github.com/crystal-lang/crystal/wiki/Used-in-production) and [Kemal Users](https://github.com/kemalcr/kemal/wiki/Kemal-Users).

## Embedded Programming 

* [Nikola Motor Company](https://nikolamotor.com) - Electric Semi Trucks and UTV's
* [Interface of Truck](https://www.youtube.com/watch?v=u4mnYkH8ntc) Interface in Video is written in Crystal

## SaaS products

* [Tovi](https://tovi.io/) - Data Analysis Software

## Blockchain

* [Saturn Network](https://saturn.network/) - Decentralized Cryptocurrency Exchange

## Hosting

* [Universal Layer](https://ulayer.net/) - Privacy and security conscious hosting provider

## Open Source Projects using Amber

Many developers around the world are trying Amber everyday, you can find a lot of projects on open source repositories like Github. [Almost 100 projects are using Amber right now!](http://shards.info/repos/amberframework/amber/dependents).

Also you can use [Wappalyzer](https://www.wappalyzer.com/technologies/amber) to detect webapps using Amber. Here are some of them:

* [Nocturne Project](https://nocturne.crnbrdrck.xyz/)- Village Builder web application \([source code](https://github.com/TheNocturneProject/Nocturne)\)
* [Amber Framework](https://amberframework.org/) - Main website for Amber \([source code](https://github.com/amberframework/amberframework.org)\)
* [Amber Latest ](https://amber-latest-app-example.herokuapp.com/)- App built with amber latest branch to test new features \([source code](https://github.com/faustinoaq/amber-latest-app-example)\)
* [Ambrockets](https://ambrockets.herokuapp.com/) - A simple WebSockets example \([source code](https://github.com/faustinoaq/ambrockets)\)
* [Triathlets](http://triathlets.krylov-alexey.ru/) - Web app for Vladivostok's triathlets \([source code](https://github.com/forsaken1/triathlets)\)
* [Crystal \[ANN\]](https://crystal-ann.com/) - Web site to announce new Crystal projects \([source code](https://github.com/crystal-community/crystal-ann)\)
* [Bird app](https://crystal-bird-app.herokuapp.com/) - Where birds are neat \([source code](https://github.com/bradford-hamilton/crystal-bird-app)\)


---

## Contributing

Canonical page: https://amberframework.org/docs/v2/contributing

# Contributing

First thank you for taking the time to contribute and making our community great!

Amber is an open source project and we love to receive contributions from our community — you! The following is a set of guidelines for contributing to Amber, which are hosted in the Amber Crystal on GitHub.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests. These are just guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Table of contents

[What should I know before I get started?](contributing.md#what-should-i-know-before-i-get-started)

* [Code of Conduct](code-of-conduct.md)
* [Ground Rules](contributing.md#ground-rules)

[How Can I Contribute?](contributing.md#how-can-i-contribute)

* [Reporting Bugs](contributing.md#how-to-report-a-bug)
* [Suggesting Enhancements](contributing.md#how-to-suggest-a-feature-or-enhancement)
* [Your First Contribution](contributing.md#your-first-contribution)
* [Pull Requests](contributing.md#pull-requests)

[Style Guides](contributing.md#styles-guides)

* [Coding Style Guides](contributing.md#coding-style-guides)
* [Documenting code](contributing.md#documenting-code)
* [Spec Style Guides](contributing.md#spec-guides)

## What should I know before I get started?

### Ground Rules

Be a law abiding contributor!

This project adheres to the Contributor Covenant [CODE OF CONDUCT](code-of-conduct.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to our [Discord](https://discord.gg/vwvP5zakSn).

## How Can I Contribute

### How to report a bug

This section guides you through submitting a bug report for Amber. Following these guidelines helps maintainers and the community understand your report, reproduce the behavior, and find related reports.

**Before Submitting A Bug Report**

Before creating bug reports, please check this list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible. Fill out the required template, the information it asks for helps us resolve issues faster.

**How Do I Submit A \(Good\) Bug Report?**

Bugs are tracked as [GitHub issues](https://github.com/amberframework/amber/issues). After you've determined the cause of the bug, create an issue and provide the following information by filling in the template.

**A good bug report**

* Contains the information needed to reproduce and fix problems
* Is an efficient form of communication for both bug reporter and bug receiver
* Is resolved as fast as possible
* Is sent to the person in charge
* Establishes a common ground of collaboration

Explain the problem and include additional details to help maintainers reproduce the problem:

* Use a clear and descriptive title for the issue to identify the problem.
* Describe the exact steps which reproduce the problem in as many details as possible. For example, start by explaining how you started Amber, e.g. which command exactly you used in the terminal, or how you started A,ber otherwise. When listing steps, don't just say what you did, but explain how you did it. For example, if you moved the cursor to the end of a line, explain if you used the mouse, or a keyboard shortcut or an Amber command, and if so which one?
* Provide specific examples to demonstrate the steps. Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples. If you're providing snippets in the issue, use Markdown code blocks.
* Describe the behavior you observed after following the steps and point out what exactly is the problem with that behavior.
* Explain which behavior you expected to see instead and why.
* Include screenshots and animated GIFs which show you following the described steps and clearly demonstrate the problem. If you use the keyboard while following the steps, record the GIF with the Keybinding Resolver shown. You can use this tool to record GIFs on macOS and Windows, and this tool or this tool on Linux.
* If the problem is related to performance, include a CPU profile capture and a screenshot with your report.
* If the problem wasn't triggered by a specific action, describe what you were doing before the problem happened and share more information using the guidelines below.

### How to suggest a feature or enhancement

This section guides you through submitting an enhancement suggestion for Amber, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion and find related suggestions.

Before creating enhancement suggestions, please check this list as you might find out that you don't need to create one. When you are creating an enhancement suggestion, please include as many details as possible. Fill in the template, including the steps that you imagine you would take if the feature you're requesting existed.

**Before Submitting An Enhancement Suggestion**

* Check if there's already a shard which provides that enhancement.
* Perform a cursory search to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.

**How Do I Submit A \(Good\) Enhancement Suggestion?**

Enhancement suggestions are tracked as GitHub issues. After you've determined which repository your enhancement suggestion is related to, create an issue on that repository and provide the following information:

* Use a clear and descriptive title for the issue to identify the suggestion.
* Provide a step-by-step description of the suggested enhancement in as many details as possible.
* Provide specific examples to demonstrate the steps. Include copy/pasteable snippets which you use in those examples, as Markdown code blocks.
* Describe the current behavior and explain which behavior you expected to see instead and why.
* Include screenshots and animated GIFs which help you demonstrate the steps or point out the part of Amber which the suggestion is related to. You can use this tool to record GIFs on macOS and Windows, and this tool or this tool on Linux.
* Explain why this enhancement would be useful to most Amber users and isn't something that can or should be implemented as a community package.
* List some other text editors or applications where this enhancement exists.
* Specify which version of Amber you're using. You can get the exact version by running Amber -v in your terminal, or by starting Amber and running the Application: About command from the Command Palette.
* Specify the name and version of the OS you're using.

### Your First Contribution

Unsure where to begin contributing to Amber? You can start by looking through these beginner and help-wanted issues:

Beginner issues - issues which should only require a few lines of code, and a test or two. Help wanted issues - issues which should be a bit more involved than beginner issues. Both issue lists are sorted by total number of comments. While not perfect, number of comments is a reasonable proxy for impact a given change will have.

### Pull Requests

* Fill in the required template
* Document new code based on the [Documenting Code](https://crystal-lang.org/docs/conventions/documenting_code.html) docs
* Include thoughtfully-worded, well-structured
* End files with a newline
* Format your code with`crystal tool format`
* Specs Styleguide

## Styles Guides

### Coding Style Guides

* [Style Guide](https://crystal-lang.org/docs/conventions/coding_style.html)

### Documenting code

* [Documenting Code](https://crystal-lang.org/docs/conventions/documenting_code.html)

### Spec Guides

* Include thoughtfully-worded, well-structured Crystal specs in the`./spec`folder.
* Treat`describe`as a noun or situation.
* Teat`it`as a statement about state or how an operation changes state.


---

## Code of Conduct

Canonical page: https://amberframework.org/docs/v2/code-of-conduct

# Code of Conduct

## Our Pledge

In the interest of fostering an open and welcoming environment, we as contributors and maintainers pledge to making participation in our project and our community a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

## Our Standards

Examples of behavior that contributes to creating a positive environment include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a professional setting

## Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable behavior and are expected to take appropriate and fair corrective action in response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct, or to ban temporarily or permanently any contributor for other behaviors that they deem inappropriate, threatening, offensive, or harmful.

## Scope

This Code of Conduct applies both within project spaces and in public spaces when an individual is representing the project or its community. Examples of representing a project or community include using an official project e-mail address, posting via an official social media account, or acting as an appointed representative at an online or offline event. Representation of a project may be further defined and clarified by project maintainers.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by contacting the project team at [Dru Jensen](mailto://drujensen@gmail.com) or [Elias Perez](mailto://eliasjpr@gmail.com) or [Isaac Sloan](mailto://isaac@isaacsloan.com). All complaints will be reviewed and investigated and will result in a response that is deemed necessary and appropriate to the circumstances. The project team is obligated to maintain confidentiality with regard to the reporter of an incident. Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good faith may face temporary or permanent repercussions as determined by other members of the project's leadership.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant](http://contributor-covenant.org/) at [version 1.4](http://contributor-covenant.org/version/1/4)


---

## amber new

Canonical page: https://amberframework.org/docs/v2/cli/new

# `amber new`

**Run from: any directory; `NAME` controls where the project is created.**

```bash
amber new NAME [options]
```

## Options

| Option | Default | Meaning |
|---|---|---|
| `--type web|native` | `web` | Web is supported; native is preview |
| `-d`, `--database pg|mysql|sqlite` | `sqlite` | Selects the driver, connection, and environment URLs |
| `-t`, `--template ecr` | `ecr` | Amber V2 supports ECR only |
| `--no-deps` | off | Skip automatic `shards install` |
| `-y`, `--assume-yes` | off | Disable interactive prompts |

`NAME` may be a simple name, relative path, absolute path, or `.`. For a path,
the final component becomes the project name. Paths containing spaces are
rejected.

```bash
amber new my_app
amber new my_app --type web
amber new projects/admin --type web -d sqlite
amber new /tmp/amber_smoke --type web --no-deps
amber new . --type web
```

The first two commands generate the same web application. Omitting `--type`
is the recommended first run; the explicit form is useful in automation.

## Web template contract

The generated web app contains:

- `amberframework/amber` pinned to `2.0.0-beta.4`
- Grant pinned to the reviewed V2 commit
- SQLite by default, or the selected PostgreSQL/MySQL driver
- `config/database.cr` and typed per-environment database URLs
- Micrate-powered database commands in the compiled CLI
- Crystal `>= 1.20.0, < 2.0`
- ECR layout and homepage
- authored CSS, JavaScript, images, fonts, and files under `app/assets/`
- fingerprinted output and a strict manifest under ignored `public/assets/`
- manifest-aware ECR helpers and `amber assets build|check`
- typed development, test, and production YAML
- web, API, and static pipelines plus routes
- homepage request spec and `bin/` build directory
- no attachment shard, personal Amber fork, moving framework branch, or
  unselected database driver

The database option installs a complete persistence choice. SQLite is the
zero-server first run; PostgreSQL and MySQL require their matching server.

The generator builds the initial manifest before it finishes, including with
`--no-deps`. Authored files belong in source control; generated
`public/assets/` output does not. See the [web template
guide](../guides/web-template/) for the exact file map and ownership boundary.

## After generation

**Run from: the generated application root after `cd my_app`.**

```bash
cd my_app
# Needed only when --no-deps was used:
shards install
amber assets check
crystal spec
crystal build src/my_app.cr -o bin/my_app
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
amber watch
```

Verify `/`, then follow the fingerprinted CSS, JavaScript, image, and font URLs
rendered into the HTML and compiled CSS. Those URLs come from
`public/assets/manifest.json`; a request to an old raw `/css` or `/js` path is
not an asset-manifest verification.

`--type native` remains available for contributors and early adopters, but it
is not part of the Amber V2 beta install/build guarantee. Read the [native
preview guide](../guides/native-preview/) before evaluating it.


---

## amber generate

Canonical page: https://amberframework.org/docs/v2/cli/generate

# `amber generate`

**Run from: the generated application root beside `shard.yml`.**

```bash
amber generate TYPE NAME [fields or actions]
```

| Type | Status | Output |
|---|---|---|
| `controller` | Supported | Controller, ECR views, pending route specs |
| `schema` | Supported | Built-in Schema API definition |
| `job` | Supported | Built-in job class |
| `mailer` | Supported | Built-in mailer class |
| `channel` | Supported | WebSocket channel |
| `migration` | Supported | Reversible Micrate SQL migration |
| `model` | Supported | Grant-backed model, spec, and migration |
| `scaffold` | Supported | Grant model, schema, HTML CRUD, ECR views, specs, route, and migration |
| `api` | Preview | Persistence-backed model and controller |
| `auth` | Preview | Requires a compatible persistence/auth stack |

**Run from: the same application root — examples for the core web app.**

```bash
amber generate controller Posts index show
amber generate schema Post title:string:required body:text
amber generate job PublishPost --queue=default --max-retries=3
amber generate mailer Digest --actions=weekly
amber generate channel Updates --topics=posts
amber generate migration CreatePosts
```

Controller routes are intentionally not guessed. Add them to `config/routes.cr`,
then enable the generated pending request specs. Amber V2 generator output is
always ECR, even if a migrated `.amber.yml` still contains a legacy Slang value.

Generated API resources and authentication remain preview and may require
additional application integration. Model, scaffold, and migration generators
use the Grant, selected database driver, and Micrate tooling included in the
supported database-backed web template.


---

## amber watch

Canonical page: https://amberframework.org/docs/v2/cli/watch

# `amber watch`

**Run from: the generated application root beside `shard.yml`.**

```bash
amber watch
```

The default V2 watch configuration rebuilds when Crystal source, environment
YAML, ECR views, or authored assets change. It builds assets first, creates
`bin/`, builds the app target, runs it, and restarts after matching files
change.

```yaml
watch:
  run:
    build_commands:
      - mkdir -p bin
      - crystal build ./src/my_app.cr -o bin/my_app
    run_commands:
      - bin/my_app
    include:
      - ./config/**/*.cr
      - ./config/environments/*.yml
      - ./src/**/*.cr
      - ./src/**/*.ecr
      - ./app/assets/**/*
```

Use environment variables normally:

```bash
AMBER_SERVER_PORT=8080 amber watch
```

Stop the watcher with `Ctrl-C`. If a rebuild fails, run the printed build
command directly to get the complete compiler error.

## Asset-aware watch cycle

CLI `2.0.5` runs the same build-time compiler as `amber assets build` before
application compilation. A deleted asset, missing CSS image/font reference,
missing local JavaScript dependency, or invalid manifest entry therefore stops
the rebuild instead of becoming a browser 404.


---

## Hello World

Canonical page: https://amberframework.org/docs/v2/cookbook/hello-world

# Hello World

This recipe will help you to setup a `Hello World!` response in your `/hello` path.

{% hint style="warning" %}
First you need an amber project generated with [Amber CLI](../guides/create-new-app.md) or [from scratch](from-scratch.md).
{% endhint %}

First create a `src/controllers/hello_controller.cr` file and add this:

{% code-tabs %}
{% code-tabs-item title="src/controllers/hello\_controller.cr" %}
```crystal
class HelloController < ApplicationController
  def hello
    "Hello Amber!"
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Then add a new route in your `config/routes.cr` file:

```crystal
Amber::Server.configure do |app|
  pipeline :web do
    # pipelines...
  end

  routes :web do
    # other routes,,,
    get "/hello", HelloController, :hello
  end
end
```


---

## CORS

Canonical page: https://amberframework.org/docs/v2/cookbook/cors

# CORS

This recipe will help you to setup a [Cross-Origin Resource Sharing](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) pipe in your application.

{% hint style="warning" %}
First you need an amber project generated with [Amber CLI](../guides/create-new-app.md) or [from scratch](from-scratch.md).
{% endhint %}

{% code-tabs %}
{% code-tabs-item title="config/application.cr" %}
```crystal
Amber::Server.configure do
  pipeline :api do
    plug Pipe::CORS.new
  end
  
  routes :api do
    # your routes here...
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Also see [pipelines](../guides/routing/pipelines.md).


---

## Cookies

Canonical page: https://amberframework.org/docs/v2/cookbook/cookies

# Cookies

This recipe will help you to setup a cookie in your application.

{% hint style="warning" %}
First you need an amber project generated with [Amber CLI](../guides/create-new-app.md) or [from scratch](from-scratch.md).
{% endhint %}

{% code-tabs %}
{% code-tabs-item title="src/controllers/some\_controller.cr" %}
```crystal
class SomeController < ApplicationController
  def set_cookie
    cookies[:example] = {
      value: "a yummy cookie with amber color",
      http_only: true,
      secure: true
    }
    "Your example cookie has been cooked successfully!"
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Then in your routes file:

{% code-tabs %}
{% code-tabs-item title="config/routes.cr" %}
```crystal
Amber::Server.configure do |app|
  pipeline :web do
    # pipelines...
  end

  routes :web do
    # other routes,,,
    get "/set_cookie", SomeController, :set_cookie
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Also see more detailed information about this in[ Cookies Guide](../guides/controllers/cookies.md).


---

## Authenticate

Canonical page: https://amberframework.org/docs/v2/cookbook/authenticate

# Authenticate

This recipe will help you to setup an authentication pipe in your application:

{% hint style="warning" %}
First you need an amber project generated with [Amber CLI](../guides/create-new-app.md) or [from scratch](from-scratch.md).
{% endhint %}

{% code-tabs %}
{% code-tabs-item title="src/pipes/authenticate.cr" %}
```crystal
class Authenticate < Amber::Pipe::Base
  PUBLIC_PATHS = ["/"]

  def call(context)
    some_id = context.session["some_id"]? # setup by some controller
    if some_id || public_path?(context.request.path)
      call_next(context)
    else
      context.flash[:warning] = "Please Sign In"
      context.response.headers.add "Location", "/"
      context.response.status_code = 302
    end
  end

  private def public_path?(path)
    PUBLIC_PATHS.includes?(path)

    # Different strategies can be used to determine if a path is public
    # Example, if /admin/* paths are the only private paths
    # return false if path.starts_with?("/admin")
    #
    # Example, if only a few private paths exist
    # return false if ["/secret", "/super/secret"].includes?(path)
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Then in your routes file:

{% code-tabs %}
{% code-tabs-item title="config/routes.cr" %}
```crystal
Amber::Server.configure do |app|
  pipeline :web do
    # other pipes...
    plug Authenticate.new
  end

  routes :web do
    # some routes,,,
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

To have a full authentication experience some extra controllers, views and models are still required, please see [Amber Auth Example](../examples/amber-auth.md).

Also see [pipelines](../guides/routing/pipelines.md).


---

## JSON Mapping

Canonical page: https://amberframework.org/docs/v2/cookbook/json-mapping

# JSON Mapping

This recipe will help you to setup a basic JSON Mapping in your application.

{% hint style="warning" %}
First you need an amber project generated with [Amber CLI](../guides/create-new-app.md) or [from scratch](from-scratch.md).
{% endhint %}

JSON requests are automatically parsed into the `params` macro when the `accept` header is present and with `application/json` &#x20;

You can use this in combination with the [`respond_with`](../guides/controllers/respond-with.md) helper. Here you don't need to setup `content_type`, however, the requested path requires a `.json` extension, by example `/json_mapping.json`

```crystal
class SomeController < ApplicationController
  def json_mapping
    return "empty body" if params["some_json_key_from_your_request"]
    user = User.from_json request.body.to_s
    user.username += "mapped!"
    response_with do
      json user.to_json
    end
  end
end
```

Also see [Response With](../guides/controllers/respond-with.md) and [Response & Request](../guides/controllers/request-and-response-objects.md).


---

## Manual Binary Deployment

Canonical page: https://amberframework.org/docs/v2/deployment/manual-deploy

# Manual Binary Deployment

This example keeps compilation and runtime responsibilities explicit. Adjust
paths, the service user, and the target name for your application.

## Build the release artifact

Amber CLI `2.0.5` builds and checks application assets after installing shards
and before compiling the binary. These are build-time commands; the running web
process only reads the finished manifest and files.

```bash
shards install --production
amber assets build
amber assets check
crystal spec
shards build my_app --release
file bin/my_app
```

For an existing app using the explicit migration wrapper, replace the two
`amber assets` lines with `crystal run scripts/build_assets.cr` and its manifest
verification. Neither path may start the HTTP process or make a warm-up request
to create release files.

Copy `bin/my_app`, `config/`, and the built `public/` artifact to one new release
directory. If your application reads other files at runtime, include them
deliberately. Do not copy development secrets or a local database.

User uploads are runtime data, not release assets. Keep them on a persistent
mounted volume or in object storage and leave them out of the directory replaced
by each deployment. Back up local uploads independently. The application release
may be read-only after its authored assets have been built.

For a manifest-enabled application, confirm the release contains both
`public/assets/manifest.json` and every fingerprinted file it names. Include the
deterministic `.gz` companions. Do not copy only files that changed; a release
directory is a complete unit.

**File: `config/environments/production.yml` — configure only the fallback for
unfingerprinted files; Amber applies immutable caching to fingerprinted names.**

```yaml
static:
  headers:
    Cache-Control: "no-cache"
```

## Configure the process

Store secrets in the host or deployment platform's secret manager. A minimal
environment is:

```bash
AMBER_ENV=production
AMBER_SERVER_HOST=0.0.0.0
AMBER_SERVER_PORT=3000
AMBER_SERVER_SECRET_KEY_BASE=replace-with-a-long-random-secret
```

`AMBER_SERVER_PORT` overrides `server.port` from
`config/environments/production.yml`. Add `DATABASE_URL` only when the
application has a configured database adapter.

## Example systemd unit

```ini
[Unit]
Description=my_app Amber service
After=network.target

[Service]
Type=simple
User=my_app
Group=my_app
WorkingDirectory=/srv/my_app
EnvironmentFile=/etc/my_app.env
ExecStart=/srv/my_app/bin/my_app
Restart=on-failure
RestartSec=3
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
```

The environment file should be readable only by the service administrator and
service account. Terminate TLS in a reverse proxy or managed ingress and proxy
to `127.0.0.1:3000` when the proxy runs on the same host.

## Verify before shifting traffic

```bash
curl --fail --show-error http://127.0.0.1:3000/
```

Confirm the expected page, logs, restart behavior, and any persistence or file
storage dependencies before sending production traffic. Keep each binary,
configuration, generated asset manifest, and generated public assets together
as one immutable release. Roll back by switching traffic to the complete prior
release; never combine an older manifest with newer asset files.

For a manifest-enabled release, inspect the rendered HTML, copy one CSS,
JavaScript, image, font, and binary URL, and request each directly. Verify:

- the response body matches the built file;
- CSS and local JavaScript dependencies point at existing fingerprinted URLs;
- `Content-Type` matches the manifest, including `font/woff2`, `image/avif`,
  `application/wasm`, and other deployed formats;
- fingerprinted URLs return
  `Cache-Control: public, max-age=31536000, immutable`;
- HTML and `manifest.json` do not receive immutable caching;
- gzip clients receive valid compressed bytes with the original media type and
  `Vary: Accept-Encoding`; and
- conditional requests and byte ranges still work.

Keep the prior release directory until its HTML can no longer send clients to
its asset URLs. A database rollback is a separate decision: do not reverse a
non-backward-compatible migration merely because the binary or assets roll back.


---

## Minimal Configuration

Canonical page: https://amberframework.org/docs/v2/examples/minimal-configuration

# Minimal Configuration

Amber can be run from a single file for minimal configuration setups if the user prefers this for smaller applications.

```crystal
require "amber"

class HelloController < Amber::Controller::Base
  def index
    "hello world"
  end
end

Amber::Server.configure do |app|
  pipeline :api do
  end

  routes :api do
    get "/", HelloController, :index
  end
end

Amber::Server.start
```


---

## Installation

Canonical page: https://amberframework.org/docs/v2/getting-started/installation

# Install Amber V2 Beta

The supported onboarding path uses the standalone Amber CLI. The framework is
an exact shard dependency generated into each application.

## Supported systems

- Apple Silicon macOS — release-gated; Homebrew and `darwin-arm64` archive
- x86-64 Linux — release-gated; Homebrew and `linux-x86_64` archive
- ARM64 Linux — release-gated; `linux-arm64` archive
- Windows x86-64 — generated database-backed app compile-verified in CI; no CLI
  release archive yet

Intel macOS is not currently verified. Windows is not a release gate until it
has a supported installation artifact, but its CI job installs SQLite, builds
the CLI, generates the web app, applies its development and test migrations,
runs the generated specs, and compiles the application. Follow [Beta Support](../beta-support/)
rather than treating a successful Crystal installation as the complete support
claim.

## Prerequisites

Install Crystal 1.20 or newer, but earlier than 2.0, using the
[official Crystal instructions](https://crystal-lang.org/install/). You also
need Git, `shards`, and SQLite development headers because the default web app
compiles the SQLite driver.

For a new application, use the latest stable Crystal release that satisfies
that range.

On Debian or Ubuntu Linux:

```bash
sudo apt-get update
sudo apt-get install -y libsqlite3-dev
```

Then verify the toolchain:

```bash
crystal --version
shards --version
git --version
```

SQLite needs no running database server. Choose PostgreSQL or MySQL only when
the application needs one of those servers.

## Homebrew on macOS or Linux

The tap and formula use an underscore. Install the official formula with its
fully qualified name, then verify the `amber` executable:

```bash
brew install amberframework/amber_cli/amber_cli
amber --version
```

The formula is `amber_cli`; the installed executable is `amber`. Expect Amber
CLI `2.0.5` or newer.

## Direct archive

Choose `darwin-arm64`, `linux-x86_64`, or `linux-arm64` for the current host.

```bash
version=v2.0.5
platform=darwin-arm64
asset="amber_cli-${platform}.tar.gz"

curl -fLO "https://github.com/amberframework/amber_cli/releases/download/${version}/${asset}"
curl -fLO "https://github.com/amberframework/amber_cli/releases/download/${version}/${asset}.sha256"
shasum -a 256 -c "${asset}.sha256"
tar -xzf "${asset}"
install -m 0755 amber amber-lsp /usr/local/bin/
amber --version
```

On Linux, set `platform` to the matching value and use `sha256sum -c`. Prefix
only the `install` command with `sudo` when `/usr/local/bin` is not writable.
Never run a differently named architecture archive through emulation and call
that native support.

## Verify a database-backed application

**Run from: a parent directory where `amber_beta_smoke/` can be created.**

```bash
amber new amber_beta_smoke --type web
cd amber_beta_smoke
amber assets check
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
AMBER_ENV=test amber database migrate
crystal spec
crystal build src/amber_beta_smoke.cr -o bin/amber_beta_smoke
amber watch
```

Open <http://127.0.0.1:3000/>, then create a record at
<http://127.0.0.1:3000/pets/new>. The generated `shard.yml` pins Amber
`2.0.0-beta.4`, includes Grant and only the selected database driver, and does
not use a personal Amber fork or a moving framework branch.

From another terminal:

```bash
curl --fail http://127.0.0.1:3000/
curl --fail http://127.0.0.1:3000/pets/new
```

View the homepage source and follow its fingerprinted `/assets/...` stylesheet
URL. Confirm the stylesheet and JavaScript module tags include
`integrity="sha256-..."`; a raw `/css/app.css` request is not the V2 asset
contract.

## Manual framework dependency

For an existing Crystal application that only needs the runtime upgrade:

```yaml
dependencies:
  amber:
    github: amberframework/amber
    version: 2.0.0-beta.4

crystal: ">= 1.20.0, < 2.0"
```

Do not replace an existing application's working persistence stack merely to
upgrade the framework. Read the [V1-to-V2 migration guide](../migration-guide/)
and keep the first upgrade bounded.

## Update or remove

```bash
brew update
brew upgrade amberframework/amber_cli/amber_cli
# or
brew uninstall amberframework/amber_cli/amber_cli
brew untap amberframework/amber_cli
```

## Troubleshooting

If the wrong executable runs, inspect every match:

```bash
type -a amber
amber --version
```

Remove or rename an old Amber V1 executable, or put Homebrew earlier in `PATH`.
On macOS, the beta binary must not require `openssl@1.1`; include
`otool -L "$(command -v amber)"` in an install issue.

For generated-app failures, include the operating system and architecture,
`crystal --version`, `amber --version`, the exact command, and complete output.
Framework behavior belongs in the Amber issue tracker; CLI, generator,
migration-command, and install behavior belongs in Amber CLI.


---

## Build a Pet Tracker

Canonical page: https://amberframework.org/docs/v2/guides/pet-tracker

# Build a Pet Tracker

This is the canonical first Amber V2 application. It uses the same supported
path as the release test:

- SQLite and Grant for real persisted records;
- a reversible Micrate migration;
- typed request validation;
- generated create, read, update, and delete routes;
- ECR pages and a shared form partial;
- one `respond_with` action that serves HTML or JSON;
- local CSS and browser-native JavaScript;
- request specs and a compiled application binary.

## 1. Generate the application

**Run from: the parent directory where `pet_tracker/` should be created.**

```bash
amber new pet_tracker --type web
cd pet_tracker
```

The default is SQLite. `shard.yml` contains Amber, Grant, and
`crystal-sqlite3`; `config/database.cr` registers Grant's `primary` connection;
and the environment YAML files point development and test at separate database
files under `db/`.

## 2. Generate the complete Pet resource

**Run from: the `pet_tracker/` application root beside `shard.yml`.**

```bash
amber generate scaffold Pet name:string:required species:string:required adopted:bool
```

**Generated output: files created by the scaffold plus the updated route file.**

```text
src/models/pet.cr
src/schemas/pet_schema.cr
src/controllers/pet_controller.cr
src/views/pet/index.ecr
src/views/pet/show.ecr
src/views/pet/new.ecr
src/views/pet/edit.ecr
src/views/pet/_form.ecr
spec/models/pet_spec.cr
spec/controllers/pet_controller_spec.cr
db/migrations/<timestamp>_create_pets.sql
config/routes.cr
```

The generator adds `resources "/pets", PetController` inside the existing
`routes :web` block. That one declaration owns the index, show, new, create,
edit, update, and destroy routes.

## 3. Inspect the model and request boundary

**File: `src/models/pet.cr` — generated Grant model.**

```crystal
class Pet < Grant::Base
  connection primary
  table pets

  column id : Int64, primary: true
  column name : String
  column species : String
  column adopted : Bool?

  timestamps
end
```

`name` and `species` are required because their generator arguments ended in
`:required`. `adopted` is nullable while a new form is being built and receives
a database default when omitted.

**File: `src/schemas/pet_schema.cr` — generated request validation.**

```crystal
class PetSchema < Amber::Schema::Definition
  field :name, String, required: true
  field :species, String, required: true
  field :adopted, Bool
end
```

The schema validates browser input before the controller assigns values to the
Grant model. Database constraints remain in the migration; request validation
does not replace them.

## 4. Inspect and apply the migration

**File: `db/migrations/<timestamp>_create_pets.sql` — generated reversible SQL.**

```sql
-- +micrate Up
CREATE TABLE IF NOT EXISTS pets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  species VARCHAR(255) NOT NULL,
  adopted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- +micrate Down
DROP TABLE IF EXISTS pets;
```

**Run from: the application root.**

```bash
amber database migrate
AMBER_ENV=test amber database migrate
amber database status
```

The first command writes `db/pet_tracker_development.db`; the second writes the
isolated test database. Micrate records applied versions in each database, so
running `migrate` again is safe.

## 5. Understand the generated form

**File: `src/views/pet/_form.ecr` — shared by new and edit pages.**

The generated partial chooses the correct action, includes the CSRF token, and
uses method override for an edit:

**File: `src/views/pet/_form.ecr` — generated shared form excerpt.**

```ecr
<form action="<%= @pet.persisted? ? "/pets/#{@pet.id}" : "/pets" %>" method="POST">
  <%= csrf_tag %>
  <% if @pet.persisted? %>
    <%= hidden_field("_method", "PATCH") %>
  <% end %>

  <%= label("name") %>
  <%= text_field("name", value: @pet.name?) %>

  <%= label("species") %>
  <%= text_field("species", value: @pet.species?) %>

  <%= checkbox("adopted", checked: @pet.adopted? || false, value: "true") %>
  <%= label("adopted") %>

  <%= submit_button("Save") %>
</form>
```

The question-mark readers are deliberate: a new model has not received its
required values yet, so the form must be able to read `nil` without raising.
The controller uses the non-null schema result before saving.

## 6. Serve HTML and JSON from one action

The generated controller renders HTML. Add a JSON representation to the index
without moving rendering logic into the model.

**File: `src/controllers/pet_controller.cr` — replace only the generated
`index` method. Leave `show`, `new`, `create`, `edit`, `update`, and `destroy`
as generated.**

```crystal
def index
  @pets = Pet.all.to_a

  respond_with do
    html { render("index.ecr") }
    json { @pets.to_json }
  end
end
```

The action loads records once. The `html` branch renders
`src/views/pet/index.ecr`; the `json` branch serializes the same Grant records.
The request `Accept` header chooses the representation. Read
[Respond With](../controllers/respond-with/) for negotiation and error cases.

## 7. Give the index the Amber visual language

**File: `src/views/pet/index.ecr` — replace the generated table with this
complete view.**

```ecr
<main class="pet-shell">
  <header class="pet-hero">
    <p class="pet-eyebrow">Pet Tracker · Amber V2</p>
    <h1>Small records.<br><em>Good homes.</em></h1>
    <p>Track the animals moving through the foster network.</p>
    <a class="pet-action" href="/pets/new">Add a pet</a>
  </header>

  <nav class="pet-filters" aria-label="Filter pets">
    <button type="button" data-pet-filter="all" aria-pressed="true">All pets</button>
    <button type="button" data-pet-filter="waiting" aria-pressed="false">Looking for a home</button>
    <button type="button" data-pet-filter="adopted" aria-pressed="false">Adopted</button>
  </nav>

  <section class="pet-grid" aria-label="Pets">
    <% @pets.each do |pet| %>
      <% status = (pet.adopted? || false) ? "adopted" : "waiting" %>
      <article class="pet-card" data-pet-status="<%= status %>">
        <span class="pet-kind"><%= HTML.escape(pet.species) %></span>
        <h2><a href="/pets/<%= pet.id %>"><%= HTML.escape(pet.name) %></a></h2>
        <span class="pet-status"><%= status == "adopted" ? "Adopted" : "Looking for a home" %></span>
        <a href="/pets/<%= pet.id %>/edit">Edit record</a>
      </article>
    <% end %>
  </section>
</main>
```

**File: `app/assets/stylesheets/app.css` — append this component layer after the generated
starter styles.**

```css
.pet-shell {
  width: min(1120px, calc(100% - 40px));
  margin-inline: auto;
  padding-block: clamp(72px, 10vw, 132px);
}

.pet-hero { max-width: 780px; }
.pet-eyebrow,
.pet-kind,
.pet-status {
  color: var(--amber-accent-deep);
  font-size: .72rem;
  font-weight: 850;
  letter-spacing: .12em;
  text-transform: uppercase;
}

.pet-hero h1 {
  margin: 0;
  font-family: ui-serif, Georgia, serif;
  font-size: clamp(4rem, 9vw, 7.5rem);
  letter-spacing: -.055em;
  line-height: .88;
}

.pet-hero h1 em { color: var(--amber-accent); }
.pet-action { display: inline-flex; margin-top: 20px; font-weight: 850; }
.pet-filters { display: flex; flex-wrap: wrap; gap: 8px; margin-block: 40px 22px; }
.pet-filters button {
  padding: 9px 13px;
  border: 1px solid var(--amber-line);
  border-radius: 999px;
  background: #fffdf9;
  color: var(--amber-muted);
  font: inherit;
  font-size: .76rem;
  font-weight: 800;
  cursor: pointer;
}

.pet-filters button[aria-pressed="true"] { border-color: var(--amber-accent); background: var(--amber-accent); color: white; }
.pet-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 16px; }
.pet-card {
  min-height: 250px;
  padding: 28px;
  border: 1px solid var(--amber-line);
  border-radius: 20px;
  background: rgba(255, 253, 249, .82);
  box-shadow: var(--amber-shadow);
}

.pet-card[hidden] { display: none; }
.pet-card h2 { margin: 54px 0 18px; font-family: ui-serif, Georgia, serif; font-size: 2.4rem; }
.pet-card h2 a { text-decoration: none; }
.pet-status { display: flex; margin-bottom: 24px; }

@media (max-width: 780px) {
  .pet-grid { grid-template-columns: 1fr; }
  .pet-card { min-height: 0; }
}
```

This reuses the generated application's warm paper, amber accents, compact
labels, editorial scale, and card geometry. It does not copy the framework
website's character art or require an external design library.

## 8. Add browser-native filtering

**File: `app/assets/javascript/app.js` — replace the starter module with this behavior.**

```javascript
document.querySelectorAll("[data-pet-filter]").forEach((button) => {
  button.addEventListener("click", () => {
    const filter = button.dataset.petFilter;

    document.querySelectorAll("[data-pet-filter]").forEach((candidate) => {
      candidate.setAttribute("aria-pressed", String(candidate === button));
    });

    document.querySelectorAll("[data-pet-status]").forEach((card) => {
      card.hidden = filter !== "all" && card.dataset.petStatus !== filter;
    });
  });
});
```

The generated import map already loads this file as the `app` module. Filtering
is progressive enhancement: the records and links remain usable without
JavaScript.

## 9. Test HTML, JSON, and persistence

**File: `spec/controllers/pet_controller_spec.cr` — add this example inside
the generated `describe PetController` block.**

```crystal
describe "GET /pets as JSON" do
  it "returns the persisted collection" do
    headers = HTTP::Headers{"Accept" => "application/json"}
    response = get("/pets", headers: headers)

    assert_response_success(response)
    response.headers["Content-Type"].should contain("application/json")
    response.body.should eq("[]")
  end
end
```

**Run from: the application root.**

```bash
AMBER_ENV=test amber database migrate
amber assets build
amber assets check
crystal spec
crystal build src/pet_tracker.cr -o bin/pet_tracker
amber watch
```

Open <http://127.0.0.1:3000/pets/new>, create a Pet, open its detail page, edit
it, and return to the filtered index. Then request the second representation:

**Run from: another terminal while `amber watch` is running.**

```bash
curl -H 'Accept: application/json' http://127.0.0.1:3000/pets
```

Amber CLI's release test automates this same database path: generate the Pet
scaffold, migrate development and test, run the generated specs, build and boot
the application, create a Pet through the ECR form, edit it through
`_method=PATCH`, and read the updated record back.

## Where to go next

- [Web Template](../web-template/) explains every generated baseline file.
- [Grant models](../models/grant/) covers queries, validations, associations,
  callbacks, transactions, and security.
- [Migrations](../models/grant/migrations/) covers authored Micrate changes and
  release-safe database workflows.
- [Views](../views/) expands the controller, ECR, partial, and layout boundary.
- [Import Maps](../assets/import-maps/) shows how to split local browser code.
- [Beta Support](../../beta-support/) separates the supported web path from
  authentication, API-resource, Gemma, and native previews.


---

## Web Template

Canonical page: https://amberframework.org/docs/v2/guides/web-template

# Amber V2 Web Template

Amber CLI `2.0.5` generates a complete server-rendered web application with
ECR, Grant ORM, Micrate migrations, and SQLite. The first database-backed
feature needs no database server, Node.js process, or front-end package manager.
The same template includes the released build-time asset manifest, so its
homepage exercises the frontend contract documented for production apps.

**Run from: the parent directory where `my_app/` should be created.**

```bash
amber new my_app --type web
cd my_app
```

Web, ECR, and SQLite are the defaults, so `amber new my_app` is equivalent. Use
`-d pg` or `-d mysql` when the application should start with a server database.

## Where the examples go

Commands on this page run from the generated application root unless a closer
label says otherwise. Every code or tree example names its source file,
generated output, or reference role. Replace `my_app` with the actual generated
target name when a command includes it.

## Generated project

**Generated output: the top-level structure under `my_app/`.**

```text
my_app/
├── .amber.yml
├── .gitignore
├── README.md
├── shard.yml
├── config/
│   ├── application.cr
│   ├── assets.cr
│   ├── database.cr
│   ├── routes.cr
│   └── environments/
│       ├── development.yml
│       ├── production.yml
│       └── test.yml
├── db/
│   ├── migrations/
│   └── seeds.cr
├── app/assets/                                  # authored; source control
│   ├── stylesheets/app.css
│   ├── javascript/app.js
│   ├── images/amber-crystal.svg
│   ├── images/favicon.svg
│   ├── fonts/.gitkeep
│   └── files/.gitkeep
├── public/
│   ├── assets/                                  # generated; gitignored
│   │   ├── manifest.json
│   │   └── ...fingerprinted files...
│   └── robots.txt
├── spec/
│   ├── spec_helper.cr
│   ├── controllers/home_controller_spec.cr
│   └── channels, jobs, mailers, models, requests, schemas/
└── src/
    ├── my_app.cr
    ├── controllers/
    │   ├── application_controller.cr
    │   └── home_controller.cr
    ├── views/
    │   ├── home/index.ecr
    │   └── layouts/application.ecr
    └── channels, jobs, mailers, models, schemas, sockets/
```

The empty extension directories give generators stable destinations. The
generated `README.md` names those destinations again while a developer is
working inside the project.

## Exact dependency contract

**File: `shard.yml` — generated dependency manifest.**

```yaml
crystal: ">= 1.20.0, < 2.0"

dependencies:
  amber:
    github: amberframework/amber
    version: 2.0.0-beta.4
  grant:
    github: crimson-knight/grant
    commit: 2665a978b43ac608c68cde9243821f8f8f053372
  asset_pipeline:
    github: amberframework/asset_pipeline
    version: 0.37.0
  sqlite3:
    github: crystal-lang/crystal-sqlite3
    version: ~> 0.23.0
```

The exact Grant commit is intentional while its V2 release is finalized. Amber
and Grant changes are not pulled from moving branches during application
generation.

The CLI embeds its web scaffold in the executable. `amber new` does not fetch a
template manifest, so updating the CLI changes future projects but never
silently rewrites an existing application.

## Database connection

**File: `config/database.cr` — generated SQLite registration.**

```crystal
require "amber"
require "grant"
require "grant/adapter/sqlite"

Grant::Connections << Grant::Adapter::Sqlite.new(
  name: "primary",
  url: ENV["DATABASE_URL"]? || Amber.settings.database_url
)
```

Every generated Grant model declares `connection primary`. `DATABASE_URL`
overrides the environment YAML, which makes production configuration explicit
without putting credentials in source control.

**File: `config/environments/development.yml` — generated development values.**

```yaml
name: my_app

server:
  host: 127.0.0.1
  port: 3000
  secret_key_base: "generated-development-secret"

database:
  url: "sqlite3:./db/my_app_development.db"

session:
  key: "my_app.session"
  store: "signed_cookie"
  adapter: "memory"
  expires: 0

logging:
  severity: "debug"
  colorize: true
```

`config/environments/test.yml` uses `db/my_app_test.db`. Production leaves the
URL empty so deployment must provide `DATABASE_URL`.

## Generate the first persisted resource

**Run from: the application root beside `shard.yml`.**

```bash
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
AMBER_ENV=test amber database migrate
crystal spec
```

The scaffold command writes:

| Concern | Exact destination |
|---|---|
| Grant model | `src/models/pet.cr` |
| Request schema | `src/schemas/pet_schema.cr` |
| HTML CRUD controller | `src/controllers/pet_controller.cr` |
| Index, show, new, edit, and shared form ECR | `src/views/pet/` |
| Reversible Micrate SQL | `db/migrations/*_create_pets.sql` |
| Model and request specs | `spec/models/pet_spec.cr`, `spec/controllers/pet_controller_spec.cr` |
| Resource routes | `config/routes.cr` |

The generated migration contains `-- +micrate Up` and `-- +micrate Down`
sections. `amber database migrate` applies the development database; setting
`AMBER_ENV=test` applies the separate test database.

**Run from: the application root — useful database maintenance commands.**

```bash
amber database status
amber database rollback
amber database redo
amber database seed
```

## Released frontend and asset contract

The starter uses warm paper colors, faceted geometry, editorial type hierarchy,
and compact status labels. It is authored entirely in the generated ECR and
local CSS.

**File: `src/views/layouts/application.ecr` — generated front-end entry point.**

```ecr
<%= favicon_tag("images/favicon.svg") %>
<%= stylesheet_link_tag("stylesheets/app.css") %>
<%= javascript_importmap_tag(
  {"app" => "javascript/app.js"},
  preload: ["javascript/app.js"]
) %>
<script type="module">import "app";</script>
```

The visible page is `src/views/home/index.ecr`, the component layer is
`app/assets/stylesheets/app.css`, and browser behavior begins in
`app/assets/javascript/app.js`. See [Import maps](../assets/import-maps/) for
adding local ESM modules without a Node.js runtime or bundler.

`amber new` compiles the first manifest before it returns. The generated
boundary is:

**Generated files and authored source — ownership reference:**

```text
my_app/
├── app/assets/                                  # authored; source control
│   ├── stylesheets/app.css
│   ├── javascript/app.js
│   ├── images/amber-crystal.svg
│   ├── images/favicon.svg
│   ├── fonts/.keep
│   └── files/.keep
├── config/assets.cr                             # runtime manifest resolver
├── public/
│   ├── assets/                                  # generated; gitignored
│   │   ├── manifest.json
│   │   └── ...fingerprinted files...
│   └── robots.txt                               # authored
└── src/views/layouts/application.ecr
```

**Run from: the generated application root.**

```bash
amber assets build
amber assets check
```

`amber watch` rebuilds the manifest before application compilation and watches
`app/assets/**/*` alongside Crystal and ECR source. Older applications can use
the explicit `scripts/build_assets.cr` wrapper from the [Asset Pipeline
guide](../assets/) while adopting the same contract.

**File: `config/assets.cr` — generated runtime resolver configuration.**

```crystal
Amber::Assets.configure(
  manifest_path: "public/assets/manifest.json"
)
```

**File: `src/views/layouts/application.ecr` — generated helper usage.**

```ecr
<%= favicon_tag("images/favicon.svg") %>
<%= stylesheet_link_tag("stylesheets/app.css") %>
<%= javascript_importmap_tag(
  {"app" => "javascript/app.js"},
  preload: ["javascript/app.js"]
) %>
<script type="module">import "app";</script>
```

**File: `src/views/home/index.ecr` — generated brand image usage.**

```ecr
<%= image_tag("images/amber-crystal.svg", class: "starter-crystal", alt: "") %>
```

The generated stylesheet references
`../images/amber-crystal.svg`, proving that CSS URLs are rewritten as well as
ECR helpers. Images, fonts, favicons, and arbitrary binaries receive the same
content-addressed manifest treatment as CSS and JavaScript. User uploads do not;
they remain persistent runtime data outside the authored tree.

## Routes and request pipelines

**File: `config/routes.cr` — generated pipeline and route ownership.**

- `web` includes errors, logging, sessions, flash, and CSRF.
- `static` serves files under `public/`.
- `api` is available for explicitly registered API routes.
- `/` initially renders `HomeController#index`.
- `resources "/pets", PetController` is added by the Pet scaffold.

Controller generation alone does not edit routes. Scaffold generation does,
because its controller and views implement the complete resource contract.

## Compile and browser contract

**Run from: the generated application root.**

```bash
shards install
amber assets check
crystal spec
crystal build src/my_app.cr -o bin/my_app
amber watch
```

Open <http://127.0.0.1:3000/> and
<http://127.0.0.1:3000/pets/new>. The release test also submits that generated
form, reads the stored Pet, edits it through `_method=PATCH`, and verifies the
updated record.

The release gate runs `amber assets build` and `amber assets check`, starts the
compiled application with its release directory read-only, and requests the
fingerprinted CSS, JavaScript, image, and font URLs rendered from
`public/assets/manifest.json`. It also verifies SRI, MIME types, immutable cache
headers, gzip negotiation, and persisted Pet create/update behavior.

The supported web-template gate covers macOS, x86-64 Linux, and ARM64 Linux.
Windows x86-64 must compile the same generated database-backed application in
CI, but it does not yet have a CLI release archive. See
[Beta support](../../beta-support/) for the platform boundary and
[Build a Pet Tracker](../pet-tracker/) for the complete first application.


---

## Native Application Preview

Canonical page: https://amberframework.org/docs/v2/guides/native-preview

# Amber V2 Native Application Preview

Amber CLI can generate a cross-platform native project, but this surface is a
preview. It is **not release-gated with the V2 web beta** and is not covered by
the clean web-template compile guarantee.

**Run from: the parent directory where `field_app/` should be created.**

```bash
amber new field_app --type native
```

The generated project uses Amber V2 application patterns without starting an
HTTP server. Its interface layer is built around Asset Pipeline UI, with
platform hosts and build scripts for desktop and mobile work.

## Platform map

| Target | Generated direction | Preview boundary |
|---|---|---|
| macOS | Native AppKit host | Requires the Apple toolchain and preview dependencies |
| iOS | UIKit host and simulator/device build scripts | Cross-compilation and signing are not part of the web beta gate |
| Android | Android host and NDK build scripts | SDK, NDK, JDK, and device setup are not part of the web beta gate |

## Generated concepts

- `config/native.yml` as the native capability manifest
- Asset Pipeline UI components for platform rendering
- macOS, iOS, and Android host projects and build scripts
- FSDD process-manager structure
- crystal-audio integration points
- platform-oriented accessibility and end-to-end test locations

These are descriptions of generated output, not a promise that every platform
builds from a clean machine today. Platform-specific prerequisites, signing,
cross-compilers, and preview shard compatibility must be proven separately
before native support can graduate.

## Choose the supported first run

For the V2 beta installation and onboarding path, create the default web app:

**Run from: the parent directory where `my_app/` should be created.**

```bash
amber new my_app
cd my_app
crystal spec
amber watch
```

Use native generation when you intend to evaluate the platform work and can
report exact toolchain results. Do not interpret “generated” as “release-gated.”


---

## Schema API

Canonical page: https://amberframework.org/docs/v2/guides/schema-api

# Schema API

The Schema API is the headline feature of Amber 2.0. It provides compile-time validated request parameters with automatic type coercion, replacing the traditional params hash with a type-safe, validated approach.

## Where the examples go

- Schema definitions and their validated success/error types belong under
  `src/schemas/`, grouped by resource or request flow.
- Validation calls belong inside the controller action under `src/controllers/`
  that receives the matching request.
- Register the route for that action in `config/routes.cr`.

Blocks on this page use those destinations unless a closer label says
otherwise.

## Why Schema API?

Traditional web frameworks handle request parameters as loosely-typed hashes:

**File: a controller action under `src/controllers/` — this is the legacy
pattern to replace, not recommended V2 code.**

```crystal
# Old way - runtime errors, no type safety
def create
  email = params[:email].as(String)  # Could fail at runtime
  age = params[:age].to_i            # No validation
end
```

**File: `src/schemas/create_user_schema.cr` — define the request contract here.**

```crystal
# New way - compile-time safety, automatic validation
class CreateUserSchema < Amber::Schema::Definition
  field :email, String, required: true, format: :email
  field :age, Int32, min: 18

  validates_to UserRequest, UserValidationError
end
```

## Key Benefits

- **Type Safety**: Crystal's type system catches errors at compile time
- **Automatic Validation**: Built-in validators for common patterns
- **Content Type Aware**: Different schemas for JSON, XML, form data
- **Self-Documenting**: Schema definitions document your API
- **OpenAPI Generation**: Automatic API spec generation

## Quick Start

### 1. Define a Schema

**File: `src/schemas/create_post_schema.cr` — create this schema class.**

```crystal
class CreatePostSchema < Amber::Schema::Definition
  content_type "application/json"

  field :title, String, required: true, max_length: 200
  field :body, String, required: true
  field :published, Bool, default: false
  field :tags, Array(String), max_items: 10

  validates_to PostRequest, PostValidationError
end
```

### 2. Define Success/Error Types

**File: `src/schemas/create_post_schema.cr` — keep these result types beside the
schema, or split them under `src/schemas/posts/` when the resource grows.**

```crystal
class PostRequest < Amber::Schema::ValidatedRequest
  getter title : String
  getter body : String
  getter published : Bool
  getter tags : Array(String)
end

class PostValidationError < Amber::Schema::ValidationError
  def to_response
    {message: "Validation failed", errors: errors}
  end
end
```

### 3. Use in Controller

**File: `src/controllers/posts_controller.cr` — add this `create` action inside
`PostsController`, then register `POST /posts` in `config/routes.cr`.**

```crystal
class PostsController < ApplicationController
  def create
    case result = CreatePostSchema.validate(request)
    when Amber::Schema::Success
      post = Post.create!(result.data)
      respond_with 201, post.to_json
    when Amber::Schema::Failure
      respond_with 400, result.error.to_response.to_json
    end
  end
end
```

## Documentation Sections

- [Basics](basics/) - Schema definition, field types, and options
- [Validation](validation/) - Built-in validators and custom validation
- [Parsers](parsers/) - Content type handling (JSON, XML, Forms, etc.)
- [OpenAPI](openapi/) - Automatic API documentation generation


---

## Adapters

Canonical page: https://amberframework.org/docs/v2/guides/adapters

# Adapter System

Amber 2.0 routes session storage and pub/sub messaging through adapter
interfaces. In-memory adapters are built in; an application can register a
separate implementation when it needs an external store or message broker.

## Why Adapters?

In Amber 1.x, Redis was required for sessions and WebSocket messaging. This created issues:

- Required Redis installation for development
- External dependency even for simple apps
- No flexibility for other backends

Amber 2.0 solves this with:

- Memory-based adapters work immediately
- No external dependencies required
- Implement custom adapters for any backend
- Tests can use the in-memory implementations without an external service

## Built-in Adapters

### Memory Adapters (Default)

**File: `config/environments/development.yml` — edit the existing `session:`
and `pubsub:` keys. Apply the same shape deliberately to `test.yml` or
`production.yml`; environment files do not inherit from one another.**

```yaml
session:
  key: "amber.session"
  store: "signed_cookie"
  adapter: "memory"
  expires: 3600

pubsub:
  adapter: "memory"
```

Memory adapters are perfect for:

- Development environments
- Testing
- Single-server deployments
- Simple applications

### Cookie Sessions

For stateless session storage:

**File: one file under `config/environments/`, such as
`config/environments/production.yml` — replace that environment's existing
`session:` section.**

```yaml
session:
  key: "amber.session"
  store: "signed_cookie"
  expires: 3600
```

## Configuration

### Session Configuration

**File: `config/environments/production.yml` — replace the existing `session:`
section after registering the custom `database` adapter.**

```yaml
session:
  key: "myapp.session"
  adapter: "database"  # Your custom adapter
  expires: 86400       # 24 hours
```

### PubSub Configuration

**File: the applicable file under `config/environments/` — edit the existing
`pubsub:` section.**

```yaml
pubsub:
  adapter: "memory"  # Or custom adapter name
```

## Custom Adapters

Implement custom adapters for your specific needs:

- Database sessions (PostgreSQL, MySQL)
- Redis (via community shard)
- Cloud storage (AWS DynamoDB)
- Message queues (RabbitMQ, Kafka)

See [Session Adapters](sessions/) and [PubSub Adapters](pubsub/) for implementation guides.

## Migration from Redis

If you used Redis in Amber 1.x, see the [Migration Guide](../../migration-guide/redis-to-adapters/) for step-by-step migration instructions.


---

## Asset Pipeline

Canonical page: https://amberframework.org/docs/v2/guides/assets

# Asset Pipeline

> **Supported web path:** Amber `2.0.0-beta.4`, Amber CLI `2.0.5`, and
> asset_pipeline `0.37.0` are release-gated together. A new CLI web application
> already contains every file and command shown below.

Asset Pipeline turns application-authored CSS, JavaScript, images, fonts, and
other static files into one deterministic release artifact. It preserves each
logical path, adds a SHA-256 content fingerprint to the emitted filename, writes
subresource-integrity metadata, rewrites local CSS `url(...)` references, and
records the result in `public/assets/manifest.json`.

The important boundary is build time. A production process must never compile
assets on its first request or require a writable application directory.

## Where the examples go

Complete these steps from the application root, the directory containing
`shard.yml`.

**Reference file map:**

```text
my_app/
├── shard.yml                                      # dependency versions
├── config/assets.cr                               # runtime manifest resolver
├── scripts/build_assets.cr                        # create for an existing app
├── app/assets/                                    # authored source; edit
│   ├── stylesheets/app.css
│   ├── javascript/app.js
│   ├── images/amber-mark.svg
│   ├── fonts/Manrope-Variable.woff2
│   └── files/getting-started.pdf
├── public/assets/                                 # generated; never hand-edit
│   ├── manifest.json
│   └── ...fingerprinted files...
└── src/views/layouts/application.ecr              # edit
```

`app/assets/` belongs to source control. `public/assets/` is build output. Build
and deploy the entire output directory together; a manifest from one build must
never be paired with files from another.

Every non-hidden regular file discovered below `app/assets/` is copied or
compiled and fingerprinted, including CSS; JavaScript and source maps; JSON, web
manifests, XML, text, HTML, and CSV; SVG, PNG, JPEG, GIF, WebP, AVIF, and icons;
WOFF, WOFF2, TTF, OTF, and EOT fonts; PDF, ZIP, and WebAssembly; and common audio
and video formats. An unknown extension is still fingerprinted and recorded as
`application/octet-stream`. Dotfiles and files inside dot-directories are
ignored; symlinks and references may not escape the source root.

Compressible text, JSON-family formats (including web manifests), XML, SVG, and
WebAssembly also receive deterministic `.gz` companions. The manifest verifier
checks that each companion expands to the recorded bytes.

## 1. Confirm the compiler dependency

**File: `shard.yml` — generated apps already contain this entry. Add it under
the existing `dependencies:` key only when upgrading an older app.**

```yaml
dependencies:
  asset_pipeline:
    github: amberframework/asset_pipeline
    version: 0.37.0
```

Keep the Amber, Grant, database-driver, and other existing entries. Do not add a
second top-level `dependencies:` key.

**Run from: the application root.**

```bash
shards install
```

## 2. Configure the runtime resolver

**File: `config/assets.cr` — create this complete file.**

```crystal
Amber::Assets.configure(
  manifest_path: "public/assets/manifest.json"
)
```

**File: `scripts/build_assets.cr` — create this complete build wrapper for an
existing pre-2.0.5 application. New CLI applications use `amber assets`.**

```crystal
require "asset_pipeline/static_assets"

manifest = AssetPipeline::StaticAssets::Compiler.new(
  source_root: Path["app/assets"],
  output_root: Path["public/assets"],
  public_path: "/assets"
).build
puts "Built #{manifest.assets.size} assets"
```

**Run from: the application root, before compiling or packaging the app.**

```bash
crystal run scripts/build_assets.cr
```

This command is the build boundary. Run it in development after authored assets
change and in every release build. It emits the fingerprinted tree and
`public/assets/manifest.json`; it does not wait for an HTTP request.

Amber CLI `2.0.5` exposes this compiler as `amber assets build` and adds
`amber assets check` for strict manifest verification. Use those commands in a
generated app. Keep the wrapper only when migrating an older app that cannot
yet invoke the new CLI in its build environment.

## 3. Add authored assets

**File: `app/assets/stylesheets/app.css` — create or move the application
stylesheet here.**

```css
@font-face {
  font-family: "Manrope";
  src: url("../fonts/Manrope-Variable.woff2") format("woff2");
  font-display: swap;
}

.brand-mark {
  background: url("../images/amber-mark.svg") center / contain no-repeat;
}
```

**Files referenced by that stylesheet — place the real bytes at these paths.**

```text
app/assets/fonts/Manrope-Variable.woff2
app/assets/images/amber-mark.svg
```

The compiler resolves local CSS URLs relative to the stylesheet, fingerprints
the referenced files, and writes their final public URLs into emitted CSS. A
reference to a missing local file fails the build. External, absolute, fragment,
and `data:` URLs pass through unchanged.

**File: `app/assets/javascript/app.js` — move browser-ready ESM here.**

```javascript
const menuButton = document.querySelector("[data-menu-button]")

menuButton?.addEventListener("click", () => {
  const open = menuButton.getAttribute("aria-expanded") !== "true"
  menuButton.setAttribute("aria-expanded", String(open))
})
```

Asset Pipeline fingerprints browser-ready files; it is not a TypeScript, Sass,
or JSX compiler. Keep a necessary upstream compiler as an earlier build stage
and feed its reviewed browser output into `app/assets/`.

## 4. Confirm the configuration load boundary

**File: `src/my_app.cr` — the generated V2 entry point loads every top-level
configuration file with this line. Keep it before controllers and models.**

```crystal
require "../config/*"
```

Replace `my_app` with the application's target name when locating the file. If a
migrated application does not load `config/*`, explicitly require
`../config/assets` from its existing entry point after the file that requires
Amber. Creating `config/assets.cr` without requiring it does nothing.

Amber loads the manifest when an asset helper first resolves a logical path. A
logical path absent from the manifest raises an error instead of silently
producing a broken production URL. Absolute paths, external URLs, fragments,
and `data:` URLs pass through.

## 5. Use logical paths in the layout

**File: `src/views/layouts/application.ecr` — replace literal asset URLs with
manifest-aware helpers.**

```ecr
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%= stylesheet_link_tag("stylesheets/app.css") %>
    <%= favicon_tag("images/amber-mark.svg") %>
    <%= javascript_importmap_tag(
      {"app" => "javascript/app.js"},
      preload: ["javascript/app.js"]
    ) %>
  </head>
  <body>
    <%= content %>
    <script type="module">import "app";</script>
  </body>
</html>
```

Use `asset_path("images/amber-mark.svg")` when no semantic tag helper fits.
`image_tag`, `stylesheet_link_tag`, `javascript_include_tag`, `favicon_tag`, and
`javascript_importmap_tag` resolve logical paths through the same manifest.
`asset_integrity("javascript/app.js")` exposes the recorded SRI value when a
custom tag needs it. Stylesheet, script, and module-preload helpers add the
manifest's integrity value and anonymous CORS mode for logical assets unless the
caller explicitly supplies those attributes.

**File: an ECR view, for example `src/views/home/index.ecr` — refer to the
logical image, not its generated digest.**

```ecr
<%= image_tag("images/amber-mark.svg", alt: "Amber Framework") %>
<a href="<%= asset_path("files/getting-started.pdf") %>">Download the guide</a>
```

Never paste a generated fingerprint into an ECR file. Source code stays stable;
the manifest changes when bytes change.

## 6. Verify the build before launch

**Run from: the application root.**

```bash
amber assets build
amber assets check
crystal spec
crystal build src/my_app.cr -o bin/my_app
amber watch
```

For an upgraded older app using the wrapper, replace the first two lines with
`crystal run scripts/build_assets.cr` and a verification program as shown in
[Configuration](configuration/).

Open a rendered page and verify all of these signals:

1. `public/assets/manifest.json` exists and contains every logical asset used by
   the page;
2. HTML references fingerprinted `/assets/` URLs rather than query versions;
3. emitted CSS references fingerprinted font and image URLs that return `200`;
4. JavaScript, CSS, image, font, and download responses have correct content
   types;
5. editing a source file and rebuilding changes that file's URL; and
6. the compiled application can run with its release directory read-only.

Do not enable year-long immutable caching until the server or reverse proxy
applies it only to fingerprinted output. HTML and `manifest.json` must remain
revalidatable so a deployment can point clients at the new release.

## Authored assets are not uploads

The manifest is for files reviewed and shipped with the application. Files
received from users at runtime have a separate security, persistence, privacy,
and cache lifecycle. Keep uploads outside `app/assets/` and
`public/assets/manifest.json`; use [Gemma storage](../uploads/storage/) or an
application-owned delivery path instead.

## Next steps

- [Configuration](configuration/) — compiler, manifest, and cache boundaries
- [Import Maps](import-maps/) — map local ESM through the manifest
- [Stimulus Integration](stimulus/) — optional controller organization
- [Webpack migration](../../migration-guide/webpack-to-esm/) — migrate in
  reviewable stages without deleting the working build too early


---

## File Uploads (Gemma)

Canonical page: https://amberframework.org/docs/v2/guides/uploads

# File Uploads with Gemma

> **Preview ecosystem guide:** Gemma is not part of the Amber 2.0.0-beta.4
> core web-app release gate. Its package version, API, and platform support may
> change independently. Confirm a compatible official release before adding it
> to an application.

Gemma is a file attachment toolkit for Crystal applications, inspired by [Shrine for Ruby](https://shrinerb.com). It connects model attachments to validation, temporary uploads, permanent storage, and delivery across configurable backends.

## Authored assets and uploads are different lifecycles

Use [Asset Pipeline](../assets/) for files that ship with an application release:
CSS, JavaScript, logos, interface images, fonts, icons, and other reviewed static
files. Those files can be content-addressed, included in a release manifest, and
cached immutably because the deployment owns their bytes.

Use Gemma for files received while the application is running. An upload is
untrusted input and may be private, replaced, or deleted. Do not copy uploads
into the Asset Pipeline source tree, add them to its manifest, or assume its
immutable cache policy applies. Validate the file, store it outside the
application release artifact, and choose an authenticated controller response,
a presigned object-storage URL, or an explicitly configured public-upload route
for delivery.

## Where the examples go

- Add dependencies in `shard.yml` and run commands from the application root.
- Configure Gemma in `config/uploads.cr`. The generated application entry point
  loads top-level `config/*` files before application source.
- Attachment declarations belong in Grant models under `src/models/`.
- Upload handling belongs in the receiving controller under `src/controllers/`;
  form and display markup belongs in the matching ECR file under `src/views/`.

Blocks on this page use those destinations unless a closer label says
otherwise.

## Why Gemma?

- **Storage Agnostic** - Switch between filesystem and S3 without changing application code
- **Grant Integration** - First-class support for Grant ORM with `has_one_attached` and `has_many_attached`
- **Validation Support** - Built-in validators for file size, content type, and dimensions
- **Plugin System** - Add MIME type detection and metadata extraction
- **Two-Stage Uploads** - Cache files temporarily, then promote to permanent storage

## Installation

**File: `shard.yml` — add Gemma under the existing `dependencies:` key.**

```yaml
dependencies:
  gemma:
    github: amberframework/gemma
    version: ~> 0.6.5
```

Run `shards install` from the application root.

## Quick Start

### 1. Configure Storage

**File: `config/uploads.cr` — create this complete storage configuration. Do not
put it in the generated empty `config/initializers/` directory unless you also
add and verify an explicit require.**

```crystal
require "gemma"

Gemma.configure do |config|
  # Temporary storage for uploads in progress
  config.storages["cache"] = Gemma::Storage::FileSystem.new(
    "uploads",
    prefix: "cache"
  )

  # Permanent storage for completed uploads
  config.storages["store"] = Gemma::Storage::FileSystem.new("uploads")
end
```

**File: the application entry point, for example `src/my_app.cr` — retain
`require "../config/*"` before controllers and models.** A migrated app with a
narrower require list must explicitly require `../config/uploads`; creating the
file alone does not load it.

This example stores files under project-root `uploads/`. Amber's generated
static route serves `public/`; it does **not** make project-root `uploads/`
public. Keep private uploads there and deliver them through an authorized
application endpoint or object storage. If the product deliberately uses public
local uploads, configure a dedicated persistent directory and route, and test
the returned Gemma URL before rendering it in a view.

### 2. Add Attachment to Model

**File: `src/models/user.cr` — keep the attachment declaration inside `User`.**

```crystal
require "gemma/grant"

class User < Grant::Base
  include Gemma::Grant::Attachable

  column id : Int64, primary: true
  column name : String
  column avatar_data : JSON::Any?

  has_one_attached :avatar
end
```

### 3. Use in Controller

**File: `src/controllers/users_controller.cr` — add this behavior inside the
action that receives the upload.**

```crystal
class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    # Assign uploaded file
    if file = params.files["avatar"]?
      user.avatar = file.file
    end

    if user.save
      redirect_to "/users/#{user.id}"
    else
      render "users/new.ecr"
    end
  end
end
```

### 4. Display in View

**File: `src/views/users/show.ecr` — render the attachment inside the user page.**

```ecr
<% if user.avatar %>
  <img src="<%= user.avatar_url %>" alt="Avatar">
<% end %>
```

This view assumes `avatar_url` resolves through the delivery path selected
above. Request that URL directly during verification; a URL-shaped value alone
does not prove that Amber can serve the stored file.

## How It Works

Gemma uses a two-stage upload process:

1. **Cache Stage** - Files are first uploaded to temporary "cache" storage
2. **Store Stage** - On model save, cached files are promoted to permanent "store" storage

This approach provides several benefits:

- Failed validations don't leave orphaned files
- Users can preview uploads before final submission
- Background processing can happen between stages

```crystal
# Behind the scenes
user.avatar = uploaded_file  # Uploaded to cache
user.save                     # Promoted to store
```

## Core Concepts

### UploadedFile

Represents an uploaded file with metadata:

```crystal
uploaded_file = user.avatar

uploaded_file.id              # => "abc123.jpg"
uploaded_file.url             # => "/uploads/abc123.jpg"
uploaded_file.size            # => 12345
uploaded_file.mime_type       # => "image/jpeg"
uploaded_file.original_filename # => "photo.jpg"
uploaded_file.extension       # => "jpg"
uploaded_file.exists?         # => true

# Access raw IO
uploaded_file.open do |io|
  # Process file content
end

# Download to tempfile
uploaded_file.download do |tempfile|
  # Work with local file
end
```

### Storages

Gemma supports multiple storage backends:

| Storage | Use Case |
|---------|----------|
| `FileSystem` | Local development, simple deployments |
| `S3` | Production, cloud deployments |
| `Memory` | Testing |

### Attacher

The internal mechanism that manages file attachment lifecycle:

```crystal
attacher = user._avatar_attacher

attacher.file       # Current file
attacher.cached?    # File in temporary storage?
attacher.stored?    # File in permanent storage?
attacher.changed?   # File was modified?
attacher.url        # File URL
```

## Features

### Single File Attachments

```crystal
class User < Grant::Base
  include Gemma::Grant::Attachable

  column avatar_data : JSON::Any?
  has_one_attached :avatar
end

user.avatar = File.open("photo.jpg")
user.save

user.avatar_url  # => "/uploads/abc123.jpg"
```

### Multiple File Attachments

```crystal
class Post < Grant::Base
  include Gemma::Grant::Attachable

  column images_data : JSON::Any?
  has_many_attached :images
end

post.images = [File.open("img1.jpg"), File.open("img2.jpg")]
post.save

post.images.each do |image|
  puts image.url
end

# Add single file
post.add_image(File.open("img3.jpg"))

# Remove file
post.remove_image(post.images.first)

# Clear all
post.clear_images
```

### Custom Uploaders

Create custom uploaders for specialized handling:

```crystal
class ImageUploader < Gemma
  def generate_location(io, metadata, context, **options)
    name = super(io, metadata, **options)

    # Organize by model and ID
    File.join(
      context[:model].class.name.underscore,
      context[:model].id.to_s,
      name
    )
  end
end

# Use custom uploader
has_one_attached :avatar, uploader: ImageUploader
```

## Next Steps

- [Attachments](attachments/) - Single and multiple file attachments
- [Storage Backends](storage/) - Configure FileSystem and S3
- [Validation](validation/) - Validate file uploads


---

## Models

Canonical page: https://amberframework.org/docs/v2/guides/models

# Models in Amber V2

Amber CLI `2.0.5` installs Grant and the selected database driver in the
supported web template. SQLite is the zero-setup default; PostgreSQL and MySQL
are selected with `amber new APP -d pg` or `-d mysql`.

[Grant](grant/) is the supported V2 model layer. The generated `shard.yml` pins
the reviewed Grant commit, `config/database.cr` registers the `primary`
connection, and `amber database` applies [Micrate migrations](grant/migrations/)
under `db/migrations/`.

Generate the first complete model and resource from the application root:

**Run from: the application root beside `shard.yml`.**

```bash
amber generate scaffold Pet name:string:required species:string:required adopted:bool
amber database migrate
```

If you are migrating an Amber 1 application, keep the 1.4.1 documentation open
for the existing Granite or Jennifer code and use the
[Granite-to-Grant guide](../../migration-guide/granite-to-grant/) only after
reviewing its compatibility notice and proving a database restore.


---

## Controllers

Canonical page: https://amberframework.org/docs/v2/guides/controllers

# Controllers

A controller action turns an HTTP request into a response. Amber creates the
controller selected by the router, runs its filters, calls the action, and
finalizes the response through the active pipeline.

**Run from: the application root.**

```bash
amber generate controller Posts index show
```

The generator writes Crystal controller code and ECR views, but it deliberately
does not guess routes. For the command above it creates
`src/controllers/posts_controller.cr`, `src/views/posts/index.ecr`, and
`src/views/posts/show.ecr`.

**File: `config/routes.cr` — add these routes inside the existing
`Amber::Server.configure` block.**

```crystal
Amber::Server.configure do
  routes :web do
    get "/posts", PostsController, :index
    get "/posts/:id", PostsController, :show
  end
end
```

## Actions and views

**File: `src/controllers/posts_controller.cr` — replace the generated action
bodies with the application behavior. Keep the class inside this file.**

```crystal
class PostsController < ApplicationController
  def index
    title = "Recent posts"
    render("index.ecr")
  end

  def show
    post_id = params[:id]
    render("show.ecr")
  end
end
```

Local variables remain available to the ECR template rendered by the action.
Keep request parsing and authorization in explicit boundaries; use the [Schema
API](../schema-api/index.md) when input needs typed validation.

Amber's `resources` macro uses the conventional action names `index`, `new`,
`create`, `show`, `edit`, `update`, and `destroy`. Ordinary actions may use any
name when registered explicitly.

## Controller interfaces

- [Sessions and flash](sessions.md)
- [Request and response objects](request-and-response-objects.md)
- [Routing](../routing/index.md)
- [Schema API](../schema-api/index.md)

V2 web output is ECR. Examples that require `.slang` templates belong to the
V1 documentation and should not be copied into a new V2 application.


---

## SSL

Canonical page: https://amberframework.org/docs/v2/guides/ssl

# SSL

For development use self-signed keys and edit ```config/environments/development.yml```

```
ssl_key_file: example.key
ssl_cert_file: example.crt
```

For production, please use CertBot (https://certbot.eff.org) and edit ```config/environments/production.yml```

It is possible to set this in your Amber configure block as well, in ```config/application.cr```

```
Amber::Server.configure do |setting|
  # Server options
  setting.name = "Example web application."
  setting.port = 3000 # Port you wish your app to run
  setting.host = "0.0.0.0"
  setting.ssl_key_file = "example.key"
  setting.ssl_cert_file = "example.crt"
end
```


---

## Views

Canonical page: https://amberframework.org/docs/v2/guides/views

# Views

Amber V2's supported web path renders HTML with Crystal ECR templates. The
convention is deliberately small:

- controllers load resources and declare response formats;
- ECR templates own HTML;
- the application layout owns the document shell and local assets;
- `public/` owns files the browser requests directly.

## Negotiate HTML and JSON in one action

Use `respond_with` when one resource has more than one representation. The
action loads the resource once and makes each public format explicit:

**File: `src/controllers/articles_controller.cr` — add this action inside
`ArticlesController`.**

```crystal
class ArticlesController < ApplicationController
  def show
    article = ArticleCatalog.fetch(params["slug"])

    respond_with do
      html { render("show.ecr") }
      json { article.to_json }
    end
  end
end
```

A request with `Accept: text/html` renders the ECR template and layout. A
request with `Accept: application/json` runs only the JSON block. Amber also
recognizes supported path extensions when the route accepts that path. If the
request asks for no available representation, Amber returns `406 Not
Acceptable`.

Keep representation selection in the controller. Do not duplicate resource
loading in separate HTML and JSON actions unless the application behavior is
actually different. Register the matching route in `config/routes.cr`; see
[Routes](../routing/routes/) for the complete route boundary.

## Generated view structure

A clean web application starts with:

**Generated files:**

```text
src/views/
├── home/index.ecr
└── layouts/application.ecr
```

As the application grows, group templates by controller and name reusable
partials with a leading underscore:

**Reference structure:**

```text
src/views/
├── articles/
│   ├── _meta.ecr
│   ├── index.ecr
│   └── show.ecr
└── layouts/
    └── application.ecr
```

**File: `src/controllers/application_controller.cr` — keep this constant inside
the generated base controller.**

```crystal
class ApplicationController < Amber::Controller::Base
  LAYOUT = "application.ecr"
end
```

## Render ECR safely

Local variables in the controller action are available to the rendered ECR.
ECR does not automatically escape interpolation, so escape values that can
contain user or external data.

**File: `src/views/articles/show.ecr` — create this template for the controller's
`render("show.ecr")` branch.**

```ecr
<article class="article-shell">
  <p class="eyebrow">Field note</p>
  <h1><%= escape_html(article[:title]) %></h1>
  <p><%= escape_html(article[:summary]) %></p>

  <%= render(partial: "articles/_meta.ecr") %>
</article>
```

The layout receives the completed action template as `content`. That value is
framework-rendered HTML, so it is intentionally inserted without escaping.

**File: `src/views/layouts/application.ecr` — this is a complete minimal layout;
merge the asset tags into an existing branded layout instead of discarding its
navigation and metadata.**

```ecr
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%= stylesheet_link_tag("stylesheets/app.css") %>
  </head>
  <body>
    <%= content %>
    <%= javascript_importmap_tag(
      {"app" => "javascript/app.js"},
      preload: ["javascript/app.js"]
    ) %>
    <script type="module">import "app";</script>
  </body>
</html>
```

The common rendering forms belong inside controller actions.

**File: a controller under `src/controllers/`, such as
`src/controllers/articles_controller.cr` — choose the form that matches the
view file you created.**

```crystal
render("show.ecr")
render(partial: "articles/_meta.ecr")
render("card.ecr", layout: false)
render("admin/show.ecr", layout: "admin.ecr")
```

## Front-end boundary

The layout above uses a browser-native import map. The `app` name resolves to a
local ES module served by Amber's static pipeline. The generated baseline needs
no Node.js dependency, package manager, bundler, UI framework, or CDN.

Read [Import maps](../assets/import-maps/) for the complete local-module pattern
and [Web template](../web-template/) for the exact generated project structure.

The V2 CLI generator emits ECR only. Slang, Kilt, Mustache, and Temel examples
on the V1 site remain maintenance references for old applications, not choices
in the supported V2 web template.


---

## WebSockets and live pages

Canonical page: https://amberframework.org/docs/v2/guides/websockets

# WebSockets and live pages

Amber's default remains server-rendered HTML. Add a WebSocket when the document
is already useful and one part of it needs to change as work happens. Amber V2
provides client sockets, topic-based channels, broadcasts from controllers or
jobs, presence events, three decoders, and short-window connection recovery.

This guide builds one complete path. Every block names its destination.

## 1. Generate the channel

**Run from: the application root.**

```bash
amber generate channel Status --topics=status
```

**File: `src/channels/status_channel.cr` — replace the generated
handler with this small rebroadcasting channel.**

```crystal
class StatusChannel < Amber::WebSockets::Channel
  def handle_message(client_socket, message)
    rebroadcast!(message)
  end
end
```

`status:*` is a topic family. A page can join `status:reports`, while another
joins `status:deploys`, without creating another channel class.

## 2. Define the socket boundary

**File: `src/sockets/user_socket.cr` — create this file.**

```crystal
struct UserSocket < Amber::WebSockets::ClientSocket
  channel "status:*", StatusChannel

  def on_connect : Bool
    true
  end
end
```

Authentication belongs in `on_connect`. The socket exposes the request
`session`, `cookies`, `params`, and `context`; return `false` to reject the
connection.

**File: `src/my_app.cr` — require sockets and channels before the routes.**

```crystal
require "./channels/**"
require "./sockets/**"
require "../config/routes"
```

Replace `my_app` with the generated application filename.

## 3. Register the handshake

**File: `config/routes.cr` — add this line inside `routes :web`.**

```crystal
websocket "/ws", UserSocket
```

## 4. Join from a local ES module

**File: `app/assets/javascript/live-status.js` — create this browser module.**

```javascript
const protocol = location.protocol === "https:" ? "wss" : "ws";
const socket = new WebSocket(`${protocol}://${location.host}/ws`);

socket.addEventListener("open", () => {
  socket.send(JSON.stringify({
    event: "join",
    topic: "status:reports",
    payload: {}
  }));
});

socket.addEventListener("message", ({data}) => {
  const message = JSON.parse(data);
  if (message.event !== "report:ready") return;

  document
    .querySelector(`[data-report="${message.payload.id}"]`)
    ?.setAttribute("data-state", "ready");
});
```

**File: `src/views/layouts/application.ecr` — add the module to the existing
import map and import it after the map.**

```ecr
<%= javascript_importmap_tag(
  {
    "app" => "javascript/app.js",
    "live-status" => "javascript/live-status.js"
  },
  preload: ["javascript/app.js", "javascript/live-status.js"]
) %>
<script type="module">
  import "app";
  import "live-status";
</script>
```

No npm package, bundler, client framework, or CDN is required.

## 5. Publish after work succeeds

**File: the controller, service, or job that owns the successful operation.**

```crystal
StatusChannel.broadcast_to(
  "status:reports",
  "report:ready",
  {"id" => report.id.to_s}
)
```

Broadcast after the state change succeeds. A background job can call the same
class method when slow work finishes.

## Protocol and lifecycle

The default JSON envelope contains `event`, `topic`, and `payload`. Clients send
`join`, `message`, and `leave`; applications define their own event names for
server broadcasts. Amber also includes text and binary decoders, channel error
isolation, presence join/leave diffs, a 30-second heartbeat, a 100-second idle
timeout, and a 60-second reconnection window with a bounded 100-message buffer.

Those defaults are process-local. The built-in pub/sub adapter does not fan an
event across multiple Amber processes. Register a shared adapter before relying
on cross-instance broadcasts, and measure the proxy and operating-system limits
for the connection count your application expects.

## Measured on the Amber website

The August 11, 2026 release candidate for this website uses the same channel
path described above. On a DigitalOcean one-shared-vCPU, 512 MB-class target it
held 1,000 joined clients for 85 seconds with zero connection errors. While
those sockets remained open, a separate host drove the rendered `/index.json`
path at a median 8,058 requests/second across three trials; the median trial's
p99 latency was 26.77 ms.

That is a dated boundary, not a universal connection limit. The clients were
idle after joining, the test did not exercise fan-out, TLS, proxies, or multiple
processes, and the sequential shared-vCPU stages were noisy. Read the
[complete machine-readable evidence](/benchmarks/amber-v2-site-websocket-2026-08-11.json)
before using the number for planning.

Continue with [Sockets](sockets.md) for authentication and lifecycle hooks, or
[Background jobs](../background-jobs/) to publish an event after queued work.


---

## Background jobs

Canonical page: https://amberframework.org/docs/v2/guides/background-jobs

# Background jobs

Amber V2 can move slow work out of an HTTP request without adding a job library.
Jobs serialize their arguments, enter a named queue, and run in worker fibers.
The built-in adapter is intentionally small; understand its durability and
memory boundary before using it in production.

## 1. Define and register a job

**File: `src/jobs/build_report_job.cr` — create this file.**

```crystal
class BuildReportJob < Amber::Jobs::Job
  include JSON::Serializable

  property report_id : Int64

  def initialize(@report_id : Int64)
  end

  def perform
    ReportBuilder.build(report_id)
  end

  def self.queue : String
    "reports"
  end

  def self.max_retries : Int32
    5
  end
end

Amber::Jobs.register(BuildReportJob)
```

**File: `src/my_app.cr` — require jobs before the server starts.**

```crystal
require "./jobs/**"
require "../config/routes"
```

Replace `my_app` with the generated application filename. Registration is
required because a worker must reconstruct the typed job from its JSON payload.

## 2. Enqueue from the request boundary

**File: `src/controllers/reports_controller.cr` — enqueue only after request
validation and persistence succeed.**

```crystal
class ReportsController < ApplicationController
  def create
    report = ReportCatalog.create(params)
    BuildReportJob.new(report.id).enqueue

    redirect_to "/reports/#{report.id}"
  end
end
```

Use `enqueue(delay: 5.minutes)` for delayed work or
`enqueue(queue: "critical")` for a one-off queue override.

## 3. Configure workers and queue priority

**File: `config/environments/development.yml` — add this top-level block for a
local, single-process application.**

```yaml
jobs:
  adapter: "memory"
  workers: 2
  auto_start: true
  polling_interval_seconds: 1.0
  scheduler_interval_seconds: 5.0
  work_stealing: false
```

**File: `config/application.cr` — set ordered queues when the application needs
more than `default`.**

```crystal
Amber::Jobs.configure do |config|
  config.queues = ["critical", "default", "reports", "low"]
end
```

Workers check this list from left to right and take the first available job.
This is strict queue ordering, not weighted fairness: a continuously full
`critical` queue can starve the queues after it.

## Retries and dead jobs

Each execution increments the envelope's attempt count. A failure is scheduled
again with exponential backoff; after `max_retries`, the adapter marks the job
dead. The in-memory adapter exposes completed, failed, scheduled, and dead job
collections for inspection, but Amber V2 does not yet ship a dashboard or a
durable replay policy.

Keep job bodies idempotent. A worker can fail after an external side effect but
before completion is recorded, so an adapter that promises delivery may run the
same logical job again.

## What request-aware work stealing means

**Beta.3 behavior:** work stealing remains off by default. When enabled, Amber
starts one additional idle-only worker. Amber's outer
request pipeline increments a live counter for each ordinary HTTP request and
decrements it in an `ensure` block. The idle-only worker dequeues a job only
when that counter is zero. Upgraded WebSocket connections are excluded so one
persistent connection does not disable idle work forever.

This is a conservative scheduling signal, not CPU or memory telemetry. A job
already running is allowed to finish, and Amber does not preempt it when a new
request arrives. Keep latency-sensitive production workers separate until the
application has measured its own job duration and request tail latency.

## Memory, durability, and multiple instances

The default `memory` adapter is:

- process-local and lost on restart;
- unbounded by the framework, so queued payloads consume application memory;
- unavailable to workers in another process;
- appropriate for development, tests, and deliberately small single-process
  deployments where those limits are acceptable.

For durable or multi-instance work, implement and register a `QueueAdapter`
backed by a service with explicit queue-size, payload-size, retention, timeout,
and retry policies. Do not increase worker count as a substitute for measuring
job memory. Start with one worker, record peak resident memory and p95 job time,
then raise concurrency within the smallest deployment target's headroom.

## Broadcast completion to the page

**File: `src/jobs/build_report_job.cr` — add the broadcast after the report is
successfully written.**

```crystal
def perform
  ReportBuilder.build(report_id)
  StatusChannel.broadcast_to(
    "status:reports",
    "report:ready",
    {"id" => report_id.to_s}
  )
end
```

The [WebSockets and live pages](../websockets/) guide shows the channel, socket,
route, and exact browser module that receives this event.


---

## Performance

Canonical page: https://amberframework.org/docs/v2/guides/performance

# Performance

Amber treats performance as an architectural property and a documentation
obligation. Every published number should travel with its workload, hardware,
protocol, duration, errors, and limits.

## Hosted Amber V2 result

On July 17, 2026, the Amber V2 performance lab measured a mature mixed
application on a DigitalOcean Basic one-vCPU, 512 MB-class target. A separate
four-vCPU host generated load over a private VPC.

| Current Amber JSON path | Result |
|---|---:|
| Median throughput | **21,795 requests/second** |
| Median p50 latency | 655 microseconds |
| Median p99 latency | 4.20 milliseconds |
| Repetitions | 7 |
| Socket errors | 0 |
| Non-2xx responses | 0 |

This result is whole HTTP traffic over real sockets. It is not an in-process
router lookup rate.

## This website on the same smallest target

On August 11, 2026, we compiled the Amber Framework website release candidate
for Linux `x86_64-v2` and ran it on the current $4/month DigitalOcean size: one
shared vCPU with 512 MB advertised memory. A separate four-vCPU machine drove
traffic over the private VPC.

| Actual website path | Median throughput | Median-trial p50 | Median-trial p99 |
|---|---:|---:|---:|
| Complete 26,271-byte homepage | **5,907 req/s** | 2.67 ms | 7.07 ms |
| Rendered `/index.json` | **9,355 req/s** | 1.66 ms | 5.84 ms |
| Static `/llms.txt` | **14,085 req/s** | 1.08 ms | 3.90 ms |

Each row used four load-generator threads, 16 persistent connections, a
five-second warmup, and five 15-second trials. Together, these baseline and
WebSocket-concurrency stages delivered 2,944,287 successful HTTP responses
with zero reported socket errors and zero non-2xx responses.

The same release candidate then held 100, 500, and 1,000 joined WebSocket
clients. All 2,600 connection attempts across the stages and the second
1,000-client cycle succeeded. During the first 1,000-client hold, the rendered
JSON path sustained a median **8,058 requests/second**; the median trial's p99
was 26.77 ms.

This is useful capacity evidence, but not a scaling curve. The connection
stages ran sequentially on a shared-vCPU target and were visibly noisy: the
500-client stage was slower than the 1,000-client stage. Clients joined a topic
and then remained idle, so the result does not measure broadcast fan-out, slow
consumers, TLS, a reverse proxy, a public network, or multiple Amber processes.

The complete [website and WebSocket evidence](/benchmarks/amber-v2-site-websocket-2026-08-11.json)
includes every throughput trial, response size, resource snapshot, executable
fingerprint, method, and limitation.

## Workload

The release-mode `x86_64-v2` binary installed 1,000 routes and replayed the same
deterministic 4,096-request table in every trial:

| Dimension | Mix |
|---|---|
| Route shapes | 45% static, 25% REST ID, 15% ID plus action, 5% nested, 5% constrained, 5% glob |
| HTTP methods | 65% GET, 20% POST, 8% PUT, 5% PATCH, 2% DELETE |
| Locality | 70% selected the first 20% in each method-and-shape cell |
| Query strings | 20% of requests |
| Connections | 16 |
| Load-generator threads | 4 |
| Warmup | 5 seconds |
| Measurement | 15 seconds |
| Repetitions | 7, with rotating variant order |

Writes carried an eight-field JSON CRUD/mobile payload. Controllers consumed
every decoded field and serialized an acknowledgement. Reads consumed captured
route parameters and serialized a response. The measured path included the
Crystal HTTP parser and serializer, Amber routing and pipeline dispatch, body
decoding, controller work, and JSON serialization.

Across the complete seven-variant body-codec/compiler matrix, the load
generator received **18,728,053 successful responses** with zero socket errors
and zero non-2xx responses.

## What the number means

The 21,795 requests/second result is more demanding and more representative
than a static-response endpoint. It supports the narrower statement that Amber
V2 can exceed 10,000 requests/second in this documented one-vCPU hosted
workload.

It does not establish:

- a cross-framework ranking;
- a universal result for every Amber application;
- a production capacity plan or service-level agreement;
- database, cache, proxy, TLS, or public-internet performance;
- the throughput of the final beta tag on different hardware.

Application behavior, infrastructure, compiler version, connection strategy,
and request shape can move the result substantially. Benchmark your deployed
path before making capacity decisions.

## Router microbenchmarks are separate

Amber also measures route matching in isolation. Those results can reach
millions of lookups per second because they intentionally exclude sockets,
HTTP parsing, middleware, controller dispatch, template rendering, and response
serialization. They are useful for choosing router implementations, but they
must never be presented as HTTP requests per second.

## Published evidence

The [round 22 summary data](/benchmarks/amber-v2-round22-summary.json) records
the result, workload, source commit, request-table hash, and hardware boundary
in a machine-readable form. The source experiment used commit
`deccb9358fd378a8d4e060cd13a19a35c609197e`; the runner used commit
`744269f4fa83ea5a5cbbbeef58d541d0981171d1`.

The result should be rerun for the GA release. If the workload, hardware, or
harness changes, publish it as a new benchmark rather than silently replacing
the historical context.

The separate [August 11 website evidence](/benchmarks/amber-v2-site-websocket-2026-08-11.json)
records what the actual public-site release candidate did under both HTTP and
held-WebSocket load. Keep these two workloads separate when quoting them.


---

## Amber Docs Assistant

Canonical page: https://amberframework.org/docs/v2/guides/ai-assistants

# Amber Docs Assistant

Every V2 documentation page has a plain-Markdown source and one-click handoffs
for ChatGPT, Claude, and Gemini. For repeat use, you can also create a custom
GPT whose knowledge is the complete published Amber V2 documentation.

The assistant is a reading and teaching layer. The documentation remains the
source of truth, and platform support claims still come from the published beta
matrix and its linked CI evidence.

For tools that support remote MCP servers, use the live, read-only
[Amber documentation MCP server](mcp.md). It searches the published V2 source
without requiring a knowledge-file refresh.

## Download the knowledge file

**Reference download: save this generated Markdown file before opening the GPT
builder.**

<a href="/docs/v2/knowledge.md" download>Download the Amber V2 documentation knowledge bundle</a>

The bundle combines every page currently published under `/docs/v2`, including
inherited maintenance references, and gives each section its canonical page
URL. It is text-forward so the GPT can retrieve code and prose without
interpreting a visual layout.

Download a fresh copy after a documentation release. A custom GPT does not
automatically replace a knowledge file when this website changes.

The Custom GPT workflow below uses a knowledge upload because GPT knowledge and
remote MCP configuration are different product surfaces. Do not paste the MCP
endpoint into the Knowledge field.

## Create the custom GPT

Custom GPT creation happens in ChatGPT's web editor and depends on your plan
and workspace permissions. Open [Explore GPTs](https://chatgpt.com/gpts), choose
**Create**, and use the configuration view. OpenAI's current
[creating and editing GPTs guide](https://help.openai.com/en/articles/8554397-creating-a-gpt)
documents access, knowledge uploads, Preview testing, sharing, and version
history.

Use these public fields:

| Field | Recommended value |
|---|---|
| Name | Amber Framework Guide |
| Description | Build and understand Amber V2 applications with answers grounded in the published documentation. |
| Knowledge | Upload the downloaded `amber-v2-docs.md` file. |

Knowledge supplies source material; instructions define behavior. Keep those
responsibilities separate.

## Where the examples go

- Paste the **GPT instructions** block into the Custom GPT editor's
  **Instructions** field. It is assistant configuration, not an Amber project
  file.
- Add each line in **Conversation starters** as its own starter in the same GPT
  configuration screen.
- Upload `amber-v2-docs.md` under **Knowledge**. Do not place it in an Amber
  application's source tree.

**GPT instructions: paste this complete Markdown into the Instructions field.**

```markdown
# Role
You are the Amber Framework Guide for Amber V2 beta users.

# Source contract
- Ground Amber answers in the uploaded Amber V2 documentation.
- Cite the canonical Amber documentation page named in the relevant bundle section.
- Distinguish release-gated web core, supported output, and preview ecosystem material.
- Prefer V2-authored guidance when an inherited Amber 1.4.1 reference conflicts with V2.
- Never invent a command, generator flag, package version, platform guarantee, benchmark, or file path.

# Teaching contract
- For every code example, name the exact file to create or edit.
- For every command, name the directory where it runs.
- Explain whether a snippet is a complete file, a replacement block, or an addition inside existing code.
- Use Crystal, ECR, YAML, CSS, JavaScript, or terminal labels accurately.
- Prefer the dependency-free web template unless the user deliberately chooses a preview integration.

# Build workflow
When a user wants to learn Amber through an app:
1. Start with the Build a Pet Tracker guide.
2. Keep HTML in ECR views, representation choice in controllers, routes in config/routes.cr, styles in app/assets/stylesheets, and browser modules in app/assets/javascript.
3. End with crystal spec, a native crystal build, and the exact URL or curl request that proves the feature.

# Uncertainty
If the uploaded documentation does not establish an answer, say what is unknown and link the closest canonical page. Do not convert an assumption into beta support language.
```

## Add useful conversation starters

**GPT configuration: add these as separate Conversation starters.**

```text
Build the Pet Tracker with me, one verified file at a time.
Show me where HTML, JSON, CSS, and JavaScript belong in an Amber V2 app.
Check whether a generator or platform is release-gated before I depend on it.
Explain this Amber error and cite the guide that supports your answer.
```

## Test before sharing

Use the GPT editor's Preview with questions that require retrieval rather than
general Crystal knowledge:

1. Ask it to start the Pet Tracker. It should name the parent directory for
   `amber new pet_tracker` and then `src/models/pet.cr`.
2. Ask for both HTML and JSON from one action. It should use `respond_with` and
   name `src/controllers/pets_controller.cr`.
3. Ask whether persistence and native generation are in the clean web compile
   guarantee. It should say they are preview surfaces.
4. Ask where CSS and JavaScript go. It should keep them local under `public/`
   and preserve the generated import map.

If an answer omits a file location, weakens the beta boundary, or cannot cite a
canonical page, tighten the instructions before adding capabilities. Web search
is optional; it is not a replacement for the uploaded release documentation.

## Use one page with any assistant

The buttons above each documentation page create a prompt containing that
page's public raw-Markdown URL. Use them when one page is enough. Copy as
Markdown remains the reliable fallback when an assistant does not accept a
prefilled prompt or the site is running only on localhost.

The page-level source contract is:

**Reference URL pattern:**

```text
https://amberframework.org/docs/v2/PAGE_PATH.md
```

For example, the Pet Tracker source is
`https://amberframework.org/docs/v2/guides/pet-tracker.md`. Add `.json` instead
when the assistant or script needs title, description, version, canonical URL,
inheritance state, and Markdown content in one structured object.


---

## Documentation MCP server

Canonical page: https://amberframework.org/docs/v2/guides/ai-assistants/mcp

# Documentation MCP server

Amber publishes a remote, read-only Model Context Protocol endpoint at:

```text
https://amberframework.org/mcp
```

The server exposes three tools:

| Tool | Use it for |
|---|---|
| `search_docs` | Find V2 pages by task, concept, API, or filename. |
| `read_doc` | Read one canonical page as Markdown. |
| `list_docs` | List the complete published V2 documentation set. |

The endpoint never writes to an Amber application, repository, account, or
deployment. Tool results point back to canonical public pages so an assistant
can cite the source it used.

## Where the examples go

- The JSON object is MCP client configuration. Add it in the client's server
  settings; do not create it inside an Amber application.
- The `curl` examples run in any terminal and only verify the public endpoint.
  They do not create or modify an application file.
- This guide creates no application source. Do not add the examples to
  `src/`, `config/`, `public/`, `spec/`, or `shard.yml`.

## Add it to an MCP client

**Client configuration — add this as a remote HTTP MCP server, not as an Amber
application file.**

```json
{
  "mcpServers": {
    "amber-docs": {
      "url": "https://amberframework.org/mcp"
    }
  }
}
```

MCP clients use different settings screens and configuration filenames. Keep
the server name and URL above, then follow the client's instructions for adding
a remote HTTP server. No Amber API key or authorization header is required.

## Verify the endpoint directly

**Run from: any terminal; this command does not belong in an Amber project.**

```bash
curl https://amberframework.org/mcp \
  --header 'Content-Type: application/json' \
  --header 'Mcp-Method: tools/list' \
  --data '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

A successful response has `jsonrpc: "2.0"`, the same `id`, and a `result.tools`
array containing `search_docs`, `read_doc`, and `list_docs`.

## Call a documentation tool

**Run from: any terminal.**

```bash
curl https://amberframework.org/mcp \
  --header 'Content-Type: application/json' \
  --header 'Mcp-Method: tools/call' \
  --data '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"search_docs","arguments":{"query":"background job work stealing"}}}'
```

For a specific page, call `read_doc` with a documentation-relative path such
as `guides/websockets` or `/docs/v2/guides/background-jobs`.

## Protocol boundary

The endpoint supports the current stateless `2026-07-28` discovery and tool
methods. It also accepts the legacy `initialize` and
`notifications/initialized` handshake used by 2025 MCP clients. Current clients
can call `server/discover`, `tools/list`, and `tools/call` without creating a
session. The optional `Mcp-Method` request header must match the JSON-RPC method
when supplied.

Because the tool set and public documentation are cacheable, list and discovery
responses include a 15-minute public cache lifetime. Tool calls themselves are
returned with `Cache-Control: no-store` at the HTTP layer.

## Use the other machine-readable formats

MCP is the searchable assistant interface. These simpler public formats remain
useful for scripts and readers:

- add `.md` to a main site, documentation, or blog URL for its Markdown representation;
- add `.json` for structured page, guide, or post data;
- use `/docs/v2/PAGE_PATH.md` for a documentation page's exact Markdown source;
- use `/docs/v2/knowledge.md` for the complete V2 knowledge bundle;
- use `/llms.txt` for the machine-oriented site map;
- use `/blog/feed.xml` or `/rss` for the chronological publication feed.

HTML remains the human browsing representation. JSON is structured data,
Markdown is the readable source representation, RSS is the subscription stream,
and MCP provides discovery plus targeted retrieval. They are complementary,
not aliases for the same job.


---

## Routing

Canonical page: https://amberframework.org/docs/v2/guides/routing

# Routing

Amber compiles the routes in `config/routes.cr`. Each route selects a pipeline,
matches an HTTP method and path, then dispatches to a controller action.

The generated V2 web application starts with separate `web` and `static`
pipelines. Keep that separation: request/session behavior belongs to the web
pipeline, while files under `public/` are served through the static pipeline.

- [Pipelines](pipelines.md) — compose request handlers in execution order.
- [Routes](routes.md) — map paths, resources, namespaces, and constraints.

Run `amber routes` from the project root to inspect the routes declared in
`config/routes.cr`. The compiler and request specs remain the source of truth
for whether those routes dispatch successfully.


---

## Mailers

Canonical page: https://amberframework.org/docs/v2/guides/mailers

# Mailers

Amber V2 includes `Amber::Mailer::Base`, MIME generation, attachments, an
in-memory delivery adapter, and SMTP delivery. Generate an ECR-backed mailer
with the standalone CLI.

**Run from: the application root.**

```bash
amber generate mailer Digest --actions=weekly
```

The generator writes `src/mailers/digest_mailer.cr`, an ECR template under
`src/views/digest_mailer/`, and a mailer spec. The generated class implements
the required HTML and text bodies.

**File: `src/mailers/digest_mailer.cr` — edit the generated class in place.**

```crystal
class DigestMailer < Amber::Mailer::Base
  def initialize(@user_name : String, @user_email : String)
  end

  def html_body : String?
    ECR.render("src/views/digest_mailer/weekly.ecr")
  end

  def text_body : String?
    "Hello, #{@user_name}!"
  end
end
```

**File: `src/views/digest_mailer/weekly.ecr` — edit the generated HTML body and
escape user-provided values.**

```crystal
<h1>Hello, <%= HTML.escape(@user_name) %>!</h1>
```

## Delivery configuration

The memory adapter is the default and is appropriate for tests. Configure SMTP
at application startup before delivering production mail.

**File: `config/application.cr` — append this configuration after
`require "amber"`.**

```crystal
Amber::Mailer::Configuration.configure do |config|
  config.adapter = :smtp
  config.smtp_host = ENV["SMTP_HOST"]
  config.smtp_port = ENV.fetch("SMTP_PORT", "587").to_i
  config.smtp_username = ENV["SMTP_USERNAME"]?
  config.smtp_password = ENV["SMTP_PASSWORD"]?
  config.use_tls = true
  config.default_from = ENV.fetch("MAIL_FROM", "noreply@example.com")
  config.helo_domain = ENV.fetch("SMTP_HELO_DOMAIN", "localhost")
end
```

Do not commit SMTP credentials.

## Build and deliver

**File: the controller action or job that owns delivery, for example
`src/jobs/digest_delivery_job.cr` — build the message before calling
`.deliver`.**

```crystal
result = DigestMailer.new("Alice", "alice@example.com")
  .to("alice@example.com")
  .subject("Your weekly digest")
  .deliver

raise result.error.to_s unless result.is_successful
```

Use `.from`, `.cc`, `.bcc`, `.reply_to`, `.header`, `.attach`, or
`.attach_file` before `.deliver` when the message needs them. The Quartz-Mailer
and Slang examples on the V1 page do not describe Amber V2's mailer API.


---

## Testing

Canonical page: https://amberframework.org/docs/v2/guides/testing

# Testing

This guide covers built-in mechanisms in Amber for testing your application.

With this guide you will learn:

* Amber testing terminology
* How to write unit, functional, integration, and system tests for your application.

## Why write tests for your Amber Application?

* Amber makes it very easy to test your application. Amber generates skeleton test code when you generate your controllers, models.
* Tests ensure your application adheres to the specifications it was built for.
* Tests help and guide you through a code refactor.
* Amber tests can also simulate browser requests and thus you can test your application's response without having to test it through your browser.

## Amber Testing

Amber was built with testing in mind. The first time you generate an Amber application using `amber new your_app_name` a `spec` directory is generated. The contents of this directory looks as follow.

* `/spec`
  * `/controllers`
  * `/system`
  * `/models`
  * `/integrations`
  * `/mailers`

The `helpers`, `mailers`, and `models` directories are meant to hold tests for view helpers, mailers, and models, respectively. The `controllers` directory is meant to hold tests for controllers, routes, and views. The integration directory is meant to hold tests for interactions between controllers.

The `system` test directory holds system tests, which are used for full browser testing of your application. System tests allow you to test your application the way your users experience it and help you test your JavaScript as well. System tests inherit from GarnetSpec and perform in browser tests for your application.

### The Test Environment

By default every Amber application generates with three environments: `development`, `test` and `production`.

Each environment's configuration can be modified similarly. In this case, we can modify our test environment by changing the options found in `config/environments/test.yml`.

{% hint style="warning" %}
Your tests are run under AMBER\_ENV=test.
{% endhint %}

{% hint style="warning" %}
Guides for other tests like Controller tests, Integration tests and Model testing are work in progress...
{% endhint %}


---

## Session Adapters

Canonical page: https://amberframework.org/docs/v2/guides/adapters/sessions

# Session Adapters

Session adapters store the key/value data associated with a session ID. Amber
V2 includes `MemorySessionAdapter`; applications can register another backend
through `AdapterFactory` when state must survive a restart or be shared across
processes.

## Complete adapter contract

A custom adapter inherits `Amber::Adapters::SessionAdapter` and implements every
abstract operation.

**Reference API: implemented by a class under `src/adapters/`, for example
`src/adapters/redis_session_adapter.cr`. Do not copy the abstract class into the
application.**

```crystal
abstract class Amber::Adapters::SessionAdapter
  abstract def get(session_id : String, key : String) : String?
  abstract def set(session_id : String, key : String, value : String) : Nil
  abstract def delete(session_id : String, key : String) : Nil
  abstract def destroy(session_id : String) : Nil
  abstract def exists?(session_id : String, key : String) : Bool
  abstract def keys(session_id : String) : Array(String)
  abstract def values(session_id : String) : Array(String)
  abstract def to_hash(session_id : String) : Hash(String, String)
  abstract def empty?(session_id : String) : Bool
  abstract def expire(session_id : String, seconds : Int32) : Nil
  abstract def batch_set(session_id : String, values : Hash(String, String)) : Nil
  abstract def batch(session_id : String, &block : Amber::Adapters::SessionBatchOperations ->) : Nil
end
```

Adapters may also override `close` to release connections and `healthy?` to
report backend availability.

`batch_set` and `batch` should be atomic when the backend supports transactions
or pipelining. The expiration operation applies to the complete session, not an
individual key.

## Built-in memory adapter

**File: the applicable file under `config/environments/`, such as
`config/environments/development.yml` — edit its existing `session:` section.**

```yaml
session:
  key: "my_app.session"
  store: "signed_cookie"
  adapter: "memory"
  expires: 3600
```

Memory state belongs to one application process and disappears when that process
stops. Use it for development, tests, or a deployment where that lifecycle is an
explicit product decision.

## Register an application adapter

Load and register the adapter before Amber builds the configured session store.
The generated application entry point requires top-level `config/*`, including
`config/application.cr`, before application source, so it is a reliable
registration point.

**File: `config/application.cr` — keep `require "amber"`, require the adapter
class, then register it before routes are loaded.**

```crystal
# config/application.cr
require "amber"
require "../src/adapters/redis_session_adapter"

Amber::Adapters::AdapterFactory.register_session_adapter("redis") do
  RedisSessionAdapter.new(redis_client)
end
```

**File: `config/environments/production.yml` — edit the existing `session:`
section after the adapter is registered.**

```yaml
# config/environments/production.yml
session:
  key: "my_app.session"
  store: "signed_cookie"
  adapter: "redis"
  expires: 86400
```

The generated V2 application does not automatically require every file under
`config/initializers/`. If you choose that directory, add an explicit require
before `Amber::Server.start` and prove the load order in a clean build.

## Adapter verification

Test the implementation independently from controller behavior:

- create, read, update, and delete more than one key in a session;
- distinguish deleting one key from destroying the complete session;
- return consistent results from `keys`, `values`, `to_hash`, and `empty?`;
- expire a session and verify its keys disappear;
- prove `batch_set` and `batch` do not expose a partial update;
- exercise backend timeout, reconnect, and unavailable states;
- close connections cleanly during shutdown;
- run concurrent access tests that match the deployment process model.

For a Redis migration, also preserve or intentionally replace the previous key
namespace, serialization, expiration, and active-session policy. See
[Redis to Adapters](../../migration-guide/redis-to-adapters/).


---

## PubSub Adapters

Canonical page: https://amberframework.org/docs/v2/guides/adapters/pubsub

# PubSub Adapters

Pub/sub adapters carry WebSocket messages between publishers and subscribers.
Amber V2 includes `MemoryPubSubAdapter`; applications can register a shared
broker when broadcasts must cross process or host boundaries.

## Complete adapter contract

A custom adapter inherits `Amber::Adapters::PubSubAdapter`.

**Reference API: implemented by a class under `src/adapters/`, for example
`src/adapters/redis_pubsub_adapter.cr`. Do not copy the abstract class into the
application.**

```crystal
abstract class Amber::Adapters::PubSubAdapter
  abstract def publish(topic : String, sender_id : String, message : JSON::Any) : Nil
  abstract def subscribe(topic : String, &block : (String, JSON::Any) -> Nil) : Nil
  abstract def unsubscribe(topic : String) : Nil
  abstract def unsubscribe_all : Nil
  abstract def close : Nil
end
```

Adapters may also override `healthy?`, `subscriber_count`, and `active_topics`
when the backend can report those values accurately.

The adapter owns broker subscriptions and resource cleanup. Calling
`unsubscribe(topic)` must stop delivery for that topic; `unsubscribe_all` and
`close` must release all remaining subscriptions and connections.

## Built-in memory adapter

**File: the applicable file under `config/environments/`, such as
`config/environments/development.yml` — edit its existing `pubsub:` section.**

```yaml
pubsub:
  adapter: "memory"
```

Use it for development, tests, and intentional single-process deployments. A
browser connected to one process cannot receive a message published only inside
another process through the memory adapter.

## Register a shared adapter

**File: `config/application.cr` — keep `require "amber"`, require the adapter
class, then register it before routes are loaded.**

```crystal
# config/application.cr
require "amber"
require "../src/adapters/redis_pubsub_adapter"

Amber::Adapters::AdapterFactory.register_pubsub_adapter("redis") do
  RedisPubSubAdapter.new(redis_client)
end
```

**File: `config/environments/production.yml` — edit the existing `pubsub:`
section after the adapter is registered.**

```yaml
# config/environments/production.yml
pubsub:
  adapter: "redis"
```

Redis is an example of an application-supplied broker, not a built-in Amber V2
adapter. The adapter must match the chosen Redis shard API, connection model,
authentication, TLS, and reconnect behavior.

## Message contract

`publish` receives a topic, sender ID, and `JSON::Any` message. A shared adapter
must preserve those three values across serialization so each subscriber callback
receives the original sender ID and message.

Define a collision-safe broker namespace for the application and environment.
Do not subscribe directly to an untrusted topic name without validating or
encoding it for the broker.

## Adapter verification

- publish and receive representative JSON values without losing types;
- preserve the sender ID used to identify or filter an originating socket;
- deliver to multiple subscribers on the same topic;
- stop delivery after `unsubscribe` and `unsubscribe_all`;
- close broker connections and listener fibers cleanly;
- recover or fail visibly after a broker disconnect;
- use two application processes to prove cross-process delivery;
- verify topic isolation between environments and applications;
- load-test the subscription count and message sizes expected in production.

Presence, replay, persistence, ordering, and exactly-once delivery are not
provided merely by implementing the Amber pub/sub interface. If the application
requires one of those guarantees, specify and test it as part of the adapter.

See [Redis to Adapters](../../migration-guide/redis-to-adapters/) for a staged
cutover and rollback checklist.


---

## Import Maps

Canonical page: https://amberframework.org/docs/v2/guides/assets/import-maps

# Import Maps

Import maps let a browser resolve a stable module name such as `app` to a
JavaScript module. They do not require Node.js, npm, or a bundler. Asset
Pipeline adds a production cache boundary by mapping logical source names to
content-fingerprinted public URLs.

> **Supported web path:** Amber CLI `2.0.5` generates one manifest-aware import
> map for browser-ready local modules. External modules remain an application
> choice with their own availability, privacy, and review boundary.

## Where the examples go

**Reference file map:**

```text
my_app/
├── app/assets/javascript/
│   ├── app.js
│   ├── controllers/menu.js
│   └── lib/format-date.js
├── public/assets/manifest.json                    # generated
└── src/views/layouts/application.ecr
```

Complete the [Asset Pipeline setup](../) first. The examples below extend its
existing compiler and Amber manifest configuration.

## Create the local modules

**File: `app/assets/javascript/controllers/menu.js` — create this complete
module.**

```javascript
export function connectMenu() {
  const button = document.querySelector("[data-menu-button]")
  const menu = document.querySelector("[data-menu]")

  button?.addEventListener("click", () => {
    const open = button.getAttribute("aria-expanded") !== "true"
    button.setAttribute("aria-expanded", String(open))
    menu?.toggleAttribute("data-open", open)
  })
}
```

**File: `app/assets/javascript/lib/format-date.js` — create this complete
module.**

```javascript
export function formatDate(value) {
  return new Intl.DateTimeFormat(document.documentElement.lang).format(value)
}
```

**File: `app/assets/javascript/app.js` — create the application entry point.**

```javascript
import { connectMenu } from "menu-controller"
import { formatDate } from "format-date"

connectMenu()

for (const element of document.querySelectorAll("[data-date]")) {
  element.textContent = formatDate(new Date(element.dataset.date))
}
```

The entry point imports stable names, not generated digest filenames. The ECR
layout owns their mapping.

## Render one manifest-aware import map

**File: `src/views/layouts/application.ecr` — place the import map in `<head>`,
before any module script. Extend the generated import-map helper call; do not
add a second map.**

```ecr
<%= javascript_importmap_tag(
  {
    "app" => "javascript/app.js",
    "menu-controller" => "javascript/controllers/menu.js",
    "format-date" => "javascript/lib/format-date.js"
  },
  preload: [
    "javascript/app.js",
    "javascript/controllers/menu.js"
  ]
) %>
```

**File: `src/views/layouts/application.ecr` — place the module entry point just
before `</body>`.**

```ecr
<%= content %>
<script type="module">import "app";</script>
</body>
```

The helper resolves each application-owned logical path through
`public/assets/manifest.json` and emits fingerprinted URLs. Its `preload` values
are logical asset paths, not import-map keys and not generated filenames.

## Add an external module deliberately

External modules add availability, privacy, integrity, compatibility, and
release-policy concerns. Prefer reviewed local modules. If a remote module earns
its place, pin an exact artifact and put the external URL directly in the same
map; external URLs pass through without a manifest lookup.

**File: `src/views/layouts/application.ecr` — extend the existing map; do not
render another one.**

```ecr
<%= javascript_importmap_tag(
  {
    "app" => "javascript/app.js",
    "chart.js" => "https://cdn.example.invalid/chart.js@REVIEWED_VERSION/+esm"
  },
  preload: ["javascript/app.js"]
) %>
```

The example domain and version marker are intentionally nonfunctional. Replace
them only after reviewing a real provider, exact version, browser format,
license, privacy impact, and outage behavior. Self-host the reviewed module
under `app/assets/javascript/vendor/` when the application must work without a
third-party runtime dependency.

## CSS is part of the same release

An import map solves JavaScript names; it does not load styles. Keep CSS in the
same authored tree and resolve it through the same manifest.

**File: `src/views/layouts/application.ecr` — place this helper in `<head>`.**

```ecr
<%= stylesheet_link_tag("stylesheets/app.css") %>
```

The compiler rewrites local `url(...)` references inside that stylesheet, so
images and fonts receive the same content-addressed release boundary. Do not
append hand-maintained `?v=` values to CSS, JavaScript, images, or fonts. A byte
change creates a new fingerprinted path automatically.

## Build and verify

**Run from: the application root.**

```bash
amber assets build
amber assets check
crystal spec
amber watch
```

Use **View Source** and the browser network panel to confirm:

1. exactly one import map appears before the module entry point;
2. every local mapped value is a fingerprinted `/assets/` URL;
3. every preloaded module is used and returns JavaScript;
4. no source file imports a generated digest filename;
5. there are no module-resolution or CSP errors; and
6. rebuilding after a module edit changes its mapped URL.

If a strict manifest lookup fails, compare the logical value in
`src/views/layouts/application.ecr` with the relative source path below
`app/assets/`, then rebuild. Do not “fix” a missing entry by pasting a raw public
path into the import map.

Continue with [Stimulus integration](stimulus/) for an optional controller
organization pattern.


---

## Stimulus Integration

Canonical page: https://amberframework.org/docs/v2/guides/assets/stimulus

# Stimulus integration

> **Optional library:** Amber's asset manifest is release-gated. Stimulus is an
> optional third-party dependency, not an Amber requirement; review and pin the
> exact browser artifact your application chooses.

Stimulus can add focused behavior to server-rendered ECR without moving markup
or page ownership into JavaScript. Asset Pipeline fingerprints the local modules
and Amber's manifest-aware import-map helper connects stable module names to
their generated URLs.

Complete [Asset Pipeline](../) first. This page creates and edits:

**Reference file map:**

```text
app/assets/javascript/application.js
app/assets/javascript/controllers/dropdown_controller.js
src/views/layouts/application.ecr
src/views/home/index.ecr
```

## 1. Create the controller

**File: `app/assets/javascript/controllers/dropdown_controller.js` — create
this complete file.**

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "panel"]

  connect() {
    this.close()
  }

  toggle() {
    const open = this.buttonTarget.getAttribute("aria-expanded") !== "true"
    this.buttonTarget.setAttribute("aria-expanded", String(open))
    this.panelTarget.hidden = !open
  }

  close() {
    this.buttonTarget.setAttribute("aria-expanded", "false")
    this.panelTarget.hidden = true
  }
}
```

## 2. Start Stimulus and register the controller

**File: `app/assets/javascript/application.js` — create this complete entry
point.**

```javascript
import { Application } from "@hotwired/stimulus"
import DropdownController from "dropdown-controller"

const application = Application.start()
application.register("dropdown", DropdownController)
```

Registration is explicit. A filename ending in `_controller.js` does not make
it register itself, and Asset Pipeline does not inspect application semantics.

## 3. Map the modules in the layout

**File: `src/views/layouts/application.ecr` — place this map in `<head>` before
module scripts. Replace any existing import map rather than adding a second.**

```ecr
<%= javascript_importmap_tag(
  {
    "application" => "javascript/application.js",
    "dropdown-controller" => "javascript/controllers/dropdown_controller.js",
    "@hotwired/stimulus" => "https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3.2.2/+esm"
  },
  preload: [
    "javascript/application.js",
    "javascript/controllers/dropdown_controller.js"
  ]
) %>
```

**File: `src/views/layouts/application.ecr` — start the application immediately
before `</body>`.**

```ecr
<%= content %>
<script type="module">import "application";</script>
</body>
```

The two local values are strict logical paths resolved through the asset
manifest. The exact external HTTPS URL passes through. Pinning a version does
not remove CDN availability, privacy, integrity, or policy risk; to self-host,
place the reviewed browser-ready ESM artifact under
`app/assets/javascript/vendor/` and map that logical path instead.

## 4. Add the ECR markup

**File: `src/views/home/index.ecr` — add this section inside the page content.**

```ecr
<section data-controller="dropdown">
  <button
    type="button"
    data-dropdown-target="button"
    data-action="click->dropdown#toggle"
    aria-controls="framework-details"
  >
    Framework details
  </button>

  <div id="framework-details" data-dropdown-target="panel">
    Amber renders the document; Stimulus adds this interaction.
  </div>
</section>
```

The identifier passed to `application.register`, `data-controller`, each
`data-action`, and every target prefix must be `dropdown`.

## Pass server values through HTML

Use Stimulus values or ordinary `data-*` attributes for server-rendered
configuration. Do not generate executable JavaScript from user-controlled ECR
values.

**File: `app/assets/javascript/controllers/countdown_controller.js` — create
the controller.**

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]
  static values = { seconds: { type: Number, default: 60 } }

  connect() {
    this.remaining = this.secondsValue
    this.displayTarget.textContent = String(this.remaining)
    this.timer = window.setInterval(() => this.tick(), 1000)
  }

  tick() {
    this.remaining -= 1
    this.displayTarget.textContent = String(this.remaining)
    if (this.remaining <= 0) window.clearInterval(this.timer)
  }

  disconnect() {
    window.clearInterval(this.timer)
  }
}
```

Then make three matching edits:

1. map `"countdown-controller"` to
   `"javascript/controllers/countdown_controller.js"` in the existing
   `javascript_importmap_tag` call;
2. import it and call `application.register("countdown", CountdownController)`
   in `app/assets/javascript/application.js`; and
3. add the following markup to its owning ECR view.

**File: for example `src/views/events/show.ecr` — add this element where the
timer belongs.**

```ecr
<p data-controller="countdown" data-countdown-seconds-value="30">
  Time remaining:
  <span data-countdown-target="display" aria-live="polite">30</span>
</p>
```

Escape user-controlled attribute values. The view owns the value; the
controller owns reusable behavior.

## Build and verify

**Run from: the application root after every module change.**

```bash
amber assets build
amber assets check
crystal spec
amber watch
```

Verify in order:

1. the manifest contains the application and every controller logical path;
2. the one import map contains fingerprinted local URLs and the intended pinned
   Stimulus URL;
3. every mapped response returns `200` with a JavaScript content type;
4. the controller connects and the keyboard and pointer interaction work;
5. navigation away cleans up timers and listeners; and
6. the browser console contains no import-map, CSP, or module errors.

Trace failures through the actual ownership chain:
`app/assets/javascript/` source → `amber assets build` →
`public/assets/manifest.json` → `src/views/layouts/application.ecr` → the
`data-controller` element.


---

## Configuration

Canonical page: https://amberframework.org/docs/v2/guides/assets/configuration

# Asset Pipeline configuration

> **Supported web path:** This is the asset contract generated by Amber CLI
> `2.0.5` for Amber `2.0.0-beta.4` and asset_pipeline `0.37.0`.

Complete [Asset Pipeline](../) first. Every filesystem path below is resolved
from the application root, beside `shard.yml`.

## Keep build-time and runtime responsibilities separate

**File: `config/assets.cr` — this complete generated file configures only the
runtime manifest resolver.**

```crystal
Amber::Assets.configure(
  manifest_path: "public/assets/manifest.json"
)
```

Do not require the compiler from `config/assets.cr`. That file is loaded into
the running server, which only needs Amber's resolver. Keeping the compiler in
the CLI or a build script prevents release tooling from becoming an accidental
runtime dependency.

The three paths have different owners:

| Setting | Value | Owner |
|---|---|---|
| `source_root` | `app/assets` | source files developers edit |
| `output_root` | `public/assets` | generated release files |
| `public_path` | `/assets` | URLs emitted into the manifest |

Never point `source_root` and `output_root` at the same directory. Never store
uploads in either directory. The build is allowed to replace generated output;
it must not delete application source or runtime data.

Nested logical paths are preserved.

**Reference structure — authored source files:**

```text
app/assets/stylesheets/app.css
app/assets/javascript/controllers/menu.js
app/assets/images/marketing/hero.webp
app/assets/fonts/Manrope-Variable.woff2
```

remain distinct logical entries with the same relative paths, even though the
emitted filenames include content digests. Directory preservation prevents two
files such as `admin/logo.svg` and `store/logo.svg` from colliding.

**File: `scripts/build_assets.cr` — an existing pre-2.0.5 application can use
this complete build-only wrapper.**

```crystal
require "asset_pipeline/static_assets"

AssetPipeline::StaticAssets::Compiler.new(
  source_root: Path["app/assets"],
  output_root: Path["public/assets"],
  public_path: "/assets"
).build
```

## Configure Amber's resolver

**File: `src/my_app.cr` — verify the application entry point loads top-level
configuration before controllers and models.**

```crystal
require "../config/*"
```

Replace `my_app` with the target name. The generated V2 entry point uses that
wildcard, so `config/assets.cr` is loaded. If a migrated app has a narrower
require list, add `require "../config/assets"` explicitly after the
configuration file that loads Amber. Do not put the setup in the empty
`config/initializers/` directory unless the app explicitly requires it.

The resolver is strict for logical paths. A missing entry is a build or deploy
failure to fix, not a reason to fall back silently to an unhashed URL. External
URLs, absolute application paths, fragments, and `data:` URLs pass through.

## Inspect the manifest directly

Application views should normally use Amber's helpers. Build tooling can load
the same manifest directly when it needs structured metadata.

**File: a build verification program, for example
`scripts/verify_assets.cr` — create this complete file.**

```crystal
require "asset_pipeline/static_assets"

manifest = AssetPipeline::StaticAssets::Manifest.load(
  Path["public/assets/manifest.json"]
)
manifest.verify(Path["public/assets"])

puts manifest.path("stylesheets/app.css")
puts manifest.integrity("stylesheets/app.css")
entry = manifest.entry("fonts/Manrope-Variable.woff2")
puts "#{entry.content_type} #{entry.bytes} bytes"
```

Each entry records its public path, full SHA-256 digest, SRI value, content type,
and byte count. `verify` checks those values against the emitted bytes and
deterministic gzip companions. `path`, `integrity`, and `entry` are strict
lookups; a miss stops release verification.

**Run from: the application root, after building assets.**

```bash
crystal run scripts/verify_assets.cr
```

## CSS references

**File: `app/assets/stylesheets/app.css` — use paths relative to this source
stylesheet for local authored files.**

```css
@font-face {
  font-family: "Manrope";
  src: url("../fonts/Manrope-Variable.woff2") format("woff2");
  font-display: swap;
}

.hero {
  background-image: url("../images/marketing/hero.webp");
}
```

The build rewrites those local references to the fingerprinted public paths.
Keep an external URL, root-absolute URL, fragment, or data URL only when that is
deliberately outside the manifest. A missing relative file is an error.

Relative CSS `@import` references are rewritten too. Query strings and fragments
on a local reference are preserved after the fingerprinted path. The compiler
also rewrites relative static imports, exports, dynamic imports, and source-map
references in browser-ready JavaScript. Bare module names stay unchanged so an
import map can resolve them.

Asset Pipeline copies the bytes supplied to it. Generate real responsive image
sizes and formats in an earlier deterministic build step if the application
needs them, then put every emitted variant under `app/assets/images/` and list
the real logical paths in `srcset` or `<picture>`. Query parameters such as
`?w=640` or `?format=webp` do not create an image variant.

## Development workflow

Rebuild assets after an authored source file changes, then let the Amber watcher
reload application code.

**Run from: the application root.**

```bash
amber assets build
amber watch
```

`amber watch` already runs the same compiler before application compilation
when `app/assets/**/*` changes. Running `amber assets build` explicitly is
useful before the initial watcher start and when diagnosing output. The compiler
is never a first-request hook.

## Production workflow

**Run from: the application root — build before compiling or packaging the
application.**

```bash
shards install --production
amber assets build
amber assets check
crystal spec
shards build my_app --release
```

For an older app that uses `scripts/build_assets.cr`, run that file instead of
`amber assets build`, then run `scripts/verify_assets.cr`. Both paths invoke the
same asset_pipeline `0.37.0` manifest contract.

Package `bin/my_app`, `config/`, and the complete generated `public/assets/`
tree. Start the runtime with a read-only release directory. A writable
`public/assets/` path or a warm-up request must never be required.

The compiler writes files atomically, publishes `manifest.json` last, and after
a successful rebuild removes stale files owned by the previous manifest. It
does not delete unrelated files under `public/assets/`. Deployment still must
copy or switch the complete generated tree as one unit.

Deploy atomically: place a complete release in a new directory, verify it, then
switch traffic. Rollback switches back to the prior complete directory. Do not
copy new files over an old asset tree, and do not share a manifest between
releases.

## Cache boundary

**Reference response header — apply only to fingerprinted asset URLs:**

```text
Cache-Control: public, max-age=31536000, immutable
```

HTML and `public/assets/manifest.json` must revalidate or use a short cache so
clients can discover a new deployment. Unfingerprinted aliases must never be
cached as immutable. Configure compression in Amber's static handler or the
reverse proxy, and verify `Content-Type`, `Content-Encoding`, and `Vary` rather
than assuming a CDN corrected them.

## Release verification

Verify at least one CSS file, JavaScript module, image, font, and other binary:

1. build assets from a clean checkout;
2. load `manifest.json` and perform strict lookups;
3. start the compiled app with the release directory read-only;
4. request every emitted URL and check bytes and content type;
5. confirm fingerprinted responses receive immutable caching;
6. confirm HTML and the manifest do not;
7. edit each source class, rebuild, and confirm its URL changes; and
8. switch back to the prior complete release and confirm its URLs still work.


---

## Sessions

Canonical page: https://amberframework.org/docs/v2/guides/controllers/sessions

# Sessions

Amber exposes `session` and `flash` directly inside a controller. Amber CLI's
V2 web template enables the session and flash pipes in this order.

**File: `config/routes.cr` — keep this order inside the generated `pipeline
:web` block.**

```crystal
pipeline :web do
  plug Amber::Pipe::Error.new
  plug Amber::Pipe::Logger.new
  plug Amber::Pipe::Session.new
  plug Amber::Pipe::Flash.new
  plug Amber::Pipe::CSRF.new
end
```

Keep `Session` before `Flash`: flash messages are serialized through the
session after the request.

## Generated configuration

The web template writes the following section to each environment YAML file.

**Files: `config/environments/development.yml`,
`config/environments/test.yml`, and `config/environments/production.yml` — edit
the existing `session:` section in each environment rather than adding a
duplicate key.**

```yaml
session:
  key: my_app.session
  store: signed_cookie
  adapter: memory
  expires: 0
```

The V2 session store uses the configured adapter for session values and an
encrypted cookie for the session identifier. The built-in `memory` adapter is
useful for local development and tests, but its data is process-local. Choose a
shared custom adapter before running multiple application processes or before
depending on sessions that must survive a restart. See [Session
Adapters](../adapters/sessions.md).

Production also requires a long `AMBER_SERVER_SECRET_KEY_BASE`; Amber uses it
to protect cookies. Do not commit a production secret to the YAML file.

## Read, write, and delete values

Session keys accept strings or symbols. Values are stored as strings.

**File: `src/controllers/logins_controller.cr` — place these actions inside
`LoginsController`, then register their routes in `config/routes.cr`.**

```crystal
class LoginsController < ApplicationController
  def create
    # Replace this lookup with your application's authentication logic.
    user_id = "42"
    session[:current_user_id] = user_id

    # Regenerate an adapter-backed session ID after authentication to prevent
    # session fixation. This is a no-op for a cookie-only store.
    context.regenerate_session!

    flash.notice = "Welcome back."
    redirect_to location: "/", status: 302
  end

  def destroy
    session.delete(:current_user_id)
    flash[:notice] = "You have signed out."
    redirect_to location: "/", status: 302
  end
end
```

**File: the controller action that needs the authenticated identity — use the
optional lookup where absence is expected.**

```crystal
if user_id = session[:current_user_id]?
  # Load the user through the persistence layer selected by the application.
end
```

Keep session payloads small and non-sensitive. Store a stable identifier, not
an entire model or authorization policy, and verify authorization again on
every protected request.

## Flash messages

Flash values are intended for the next request. Reading a value marks it for
removal; `keep` carries it forward, while `now` makes a value available only in
the current request.

**File: the controller action that sets the message.**

```crystal
flash[:error] = "Please correct the highlighted fields."
flash.keep(:error)
flash.now(:notice, "The preview was not saved.")
```

**File: `src/views/layouts/_flash.ecr` — create this reusable partial, then
render it from `src/views/layouts/application.ecr`.**

```ecr
<% flash.each do |name, message| %>
  <div class="flash flash-<%= name %>"><%= message %></div>
<% end %>
```

**File: `src/views/layouts/application.ecr` — add this call where global
messages should appear.**

```ecr
<%= render(partial: "layouts/_flash.ecr") %>
```

The V1 guide's inline Redis configuration is not a V2 configuration contract.
Implement and register a session adapter instead, then select it with the
`session.adapter` setting.


---

## Request & Response Objects

Canonical page: https://amberframework.org/docs/v2/guides/controllers/request-and-response-objects

# Request & Response Objects

Every Amber controller delegates `request` and `response` to the current
`HTTP::Server::Context`. Use Amber's controller helpers for ordinary rendering,
redirects, and negotiated responses; reach for the underlying Crystal objects
when you need a header, method, resource, or status directly.

## Request

`request` is Crystal's `HTTP::Request` with Amber routing extensions.

**File: `src/controllers/diagnostics_controller.cr` — place this action inside
`DiagnosticsController`, then register it in `config/routes.cr`.**

```crystal
class DiagnosticsController < ApplicationController
  def show
    method = request.method
    resource = request.resource
    user_agent = request.headers["User-Agent"]?
    query = request.query

    respond_with do
      json({method: method, resource: resource, user_agent: user_agent, query: query}.to_json)
    end
  end
end
```

Common controller-level helpers include:

| Helper | Result |
|---|---|
| `get?`, `post?`, `put?`, `patch?`, `delete?`, `head?` | Whether the request uses that HTTP method |
| `params` | Amber route, query, and form parameters |
| `format` | The requested response format inferred from the path or headers |
| `port` | The request port |
| `requested_url` | The parsed request URL |
| `cookies` | Amber's cookie store |
| `session`, `flash` | The current session and flash stores |

The raw request body is an `IO`. A parser or [request
schema](../schema-api/index.md) is usually a better boundary for JSON or form
input than manually reading the stream in each action.

## Response

`response` is Crystal's `HTTP::Server::Response`. Its most useful direct
properties are `status_code`, `headers`, and `content_type`.

**File: `src/controllers/health_controller.cr` — place this action inside
`HealthController`, then register it in `config/routes.cr`.**

```crystal
class HealthController < ApplicationController
  def show
    response.headers["Cache-Control"] = "no-store"
    set_response(
      body: "ok",
      status_code: 200,
      content_type: "text/plain"
    )
  end
end
```

**File: a controller action under `src/controllers/` — use `respond_with` when
that action offers these representations.**

```crystal
respond_with do
  html render("show.ecr")
  json({status: "ok"}.to_json)
  text "ok"
end
```

**File: a controller filter or action under `src/controllers/` — use `halt!`
when the pipeline must stop with a plain response.**

```crystal
halt!(403, "forbidden") unless authorized?
```

**File: a controller action under `src/controllers/` — use the redirect helper
rather than setting a `Location` header by hand.**

```crystal
redirect_to location: "/login", status: 302
```

For the upstream object APIs, see Crystal's `HTTP::Request` and
`HTTP::Server::Response` reference. Amber-specific helpers and schema
integration should remain the first choice when they express the intent.


---

## Halt!

Canonical page: https://amberframework.org/docs/v2/guides/controllers/halt

# Halt!

`halt!` sets the current context body, plain-text content type, and status code.
It is most useful in a before filter, where setting context content prevents the
controller action from running.

**File: `src/controllers/admin_controller.cr` — place the filter and action
inside `AdminController`.**

```crystal
class AdminController < ApplicationController
  before_action do
    only :index do
      halt!(403, "Forbidden") unless session[:admin_id]?
    end
  end

  def index
    render("index.ecr")
  end
end
```

`halt!` marks the request context; it does not raise an exception that escapes
ordinary Crystal control flow. Inside an action, return an explicit response
when later expressions must not run.

**File: the controller that owns `show`, for example
`src/controllers/admin_controller.cr` — replace that action body.**

```crystal
def show
  unless authorized?
    return set_response(
      body: "Forbidden",
      status_code: 403,
      content_type: "text/plain"
    )
  end

  render("show.ecr")
end
```

Amber's redirect helper sets the `Location` header and uses the same context
response mechanism.

**File: a controller action under `src/controllers/` — return this expression
at the point where request processing should redirect.**

```crystal
redirect_to location: "/login", status: 302
```

The V1 Slang example and its claim that `halt!` interrupts any action like an
exception are not copied into V2.


---

## Respond With

Canonical page: https://amberframework.org/docs/v2/guides/controllers/respond-with

# Respond With

Use `respond_with` when one controller action can return more than one content
type. Amber selects a response from the path extension or the request's
`Accept` header.

**File: `src/controllers/status_controller.cr` — add this action inside
`StatusController`.**

```crystal
class StatusController < ApplicationController
  def show
    respond_with do
      html render("show.ecr")
      json({status: "ok"}.to_json)
      text "ok"
      xml "<status>ok</status>"
    end
  end
end
```

Supported helpers and emitted media types are:

| Helper | Media type |
|---|---|
| `html` | `text/html` |
| `json` | `application/json; charset=utf-8` |
| `text` | `text/plain` |
| `xml` | `application/xml` |
| `js` | `text/javascript` |

Each helper accepts a string, a zero-argument block returning a string, or—for
HTML—rendered ECR output. If Amber cannot match any available response, it
returns `406 Response Not Acceptable`.

Amber `2.0.0-beta.4` does not ship a `markdown` responder helper. When the
application publishes Markdown, keep that representation explicit until a
tagged framework release includes it.

**File: `src/controllers/status_controller.cr` — add this second action inside
`StatusController`.**

```crystal
def show_markdown
  response.content_type = "text/markdown; charset=utf-8"
  "# Status\n\nOK\n"
end
```

**File: `config/routes.cr` — register the action inside the existing `routes
:web` block.**

```crystal
get "/status", StatusController, :show
get "/status.md", StatusController, :show_markdown
```

**File: `src/views/status/show.ecr` — create the HTML representation referenced
by `render("show.ecr")`.**

```ecr
<p>Status: ok</p>
```

**Run from: the application root while `amber watch` is running.**

```bash
curl -H 'Accept: application/json' http://127.0.0.1:3000/status
curl http://127.0.0.1:3000/status.json
curl http://127.0.0.1:3000/status.md
```

Keep serialization explicit. For typed request parsing and structured API
errors, use the [Schema API](../schema-api/index.md).


---

## Cookies

Canonical page: https://amberframework.org/docs/v2/guides/controllers/cookies

# Cookies

Cookies are read and written through **Amber::Base::Controller\#cookies**.

The cookies being read are the ones received along with the request, the cookies being written will be sent out with the response. Reading a cookie does not get the cookie object itself back, just the value it holds.

It's advisable that you only store simple data \(strings and numbers\) in cookies. If you have to store complex objects, you would need to handle the conversion manually when reading the values on subsequent requests.

Amber also has an encrypted cookie jar for storing sensitive data. The encrypted cookie jar encrypts the values in addition to signing them, so that they cannot be read by the end user.

## Examples of writing

```crystal
class CommentsController < ApplicationController
  def new
    # Auto-fill the commenter's name if it has been stored in a cookie
    @comment = Comment.new(author: cookies[:commenter_name])
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = "Thanks for your comment!"
      if params[:remember_name]
        # Remember the commenter's name.
        cookies[:commenter_name] = @comment.author
      else
        # Delete cookie for the commenter's name cookie, if any.
        cookies.delete(:commenter_name)
      end
      redirect_to @comment.article
    else
      render action: "new"
    end
  end
end
```

## Examples of reading

```crystal
cookies[:user_name]           # => "david"
cookies.size                  # => 2
JSON.parse(cookies[:lat_lon]) # => [47.68, -122.37]
cookies.encrypted[:discount]  # => 45
```

Please note that if you specify a :domain when setting a cookie, you must also specify the domain when deleting the cookie:

```crystal
cookies.set "name", "a yummy cookie", expires: 1.year.from_now, domain:  "domain.com"
cookies.delete "name", domain: "domain.com"
```

The optional parameters for setting cookies are:

```crystal
path   # The path for which this cookie applies. Defaults to the root of the application.
domain # The domain for which this cookie applies so you can restrict to the domain level. 
        # If you use a schema like www.example.com and want to share session with user.example.com 
        # set :domain to :all. Make sure to specify the :domain option with :all or Array again 
        #  when deleting cookies.

domain: nil                           # Does not set cookie domain. (default)
domain: :all                          # Allow the cookie for the top most level domain and subdomains.
domain: %w(.example.com .example.org) # Allow the cookie for concrete domain names.

tld_length # When using :domain => :all, this option can be used to explicitly set the TLD length 
            # when using a short (<= 3 character) domain that is being interpreted as part of a TLD. 
            # For example, to share cookies between user1.lvh.me and user2.lvh.me, set :tld_length to 1.

expires    # The time at which this cookie expires, as a Time object.
secure     # Whether this cookie is only transmitted to HTTPS servers. Default is false.
httponly   # Whether this cookie is accessible via scripting or only HTTP. Defaults to false.
```


---

## Filters

Canonical page: https://amberframework.org/docs/v2/guides/controllers/filters

# Filters

Filters are methods that are run "before", "after" or "around" a controller action.

Filters are inherited, so if you set a filter on`ApplicationController`, it will be run on every controller in your application.

## Before filter

"before" filters may halt the request cycle. A common "before" filter is one which requires that a user is logged in for an action to be run. You can define the filter method this way:

```crystal
# Filters are methods that are run "before", "after" a controller action.
before_action do
  # runs for specified actions
  only [:index, :world, :show] { increment(1) }
  # runs for all actions
  all { increment(1) }
end
```

## After filter

"after" filters are executed after the request cycle. A common "after" filter is one which requires to cleanup user data after an action has been run. You can define the filter method this way:

```crystal
after_action do
  # runs for specified actions
  only [:index, :world] { increment(1) }
end
```


---

## Flash

Canonical page: https://amberframework.org/docs/v2/guides/controllers/flash

# Flash

The flash is a special part of the session which is cleared with each request. This means that values stored there will only be available on the next request, which is useful for passing error messages etc.

## Accessing the flash scope

It is accessed in much the same way as the session, as a hash.

Let's use the act of logging out as an example. The controller can send a message which will be displayed to the user on the next request:

```crystal
class LoginsController < ApplicationController
  def destroy
    session[:current_user_id] = nil
    #  Alternatively, `flash.notice=` could be use.
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
end
```

## Rendering the flash message

```markup
<html>
  <!-- <head/> -->
  <body>
    <% flash.each do |name, msg| -%>
      <%= content_tag :div, msg, class: name %>
    <% end -%>

    <!-- more content -->
  </body>
</html>
```

## Flash values

You can pass anything that the session can store; you're not limited to notices and alerts:

```markup
<% if flash[:just_signed_up] %>
  <p class="welcome">Welcome to our site!</p>
<% end %>
```

## Flash.keep

If you want a flash value to be carried over to another request, use the keep method:

```crystal
class MainController < ApplicationController

  # Let's say this action corresponds to root URL, but you want
  # all requests here to be redirected to UsersController#index.
  # If an action sets the flash and redirects here, the values
  # would normally be lost when another redirect happens, but you
  # can use 'keep' to make it persist for another request.

  def index
    # Will persist all flash values.
    flash.keep

    # You can also use a key to keep only some kind of value.
    # flash.keep(:notice)
    redirect_to users_url
  end
end
```

## Flash.now

By default, adding values to the flash will make them available to the next request, but sometimes you may want to access those values in the same request. For example, if the create action fails to save a resource and you render the new template directly, that's not going to result in a new request, but you may still want to display a message using the flash. To do this, you can use flash.now in the same way you use the normal flash.

```crystal
class ClientsController < ApplicationController
  def create
    @client = Client.new(params[:client])
    if @client.save
      # ...
    else
      flash.now[:error] = "Could not save client"
      render action: "new"
    end
  end
end
```


---

## Redirection

Canonical page: https://amberframework.org/docs/v2/guides/controllers/redirection

# Redirection

Often, we need to redirect to a new url in the middle of a request. A successful `create`action, for instance, will usually redirect to the `show` action for the model we just created. Alternately, it could redirect to the `index` action to show all the things of that same type. There are plenty of other cases where redirection is useful as well.

Calling **redirect\_to** will halt the request lifecycle.

## Redirect to URL

```crystal
redirect_to(
  location: "", 
  status: 302, 
  params: { "key" => "value" }, 
  flash: { "user_id" => "1" }
)
```

## Redirect to Action

```crystal
redirect_to(
  action: :index, 
  status: 302, 
  params: { "key" => "value" }, 
  flash: { "user_id" => "1" }
)
```

## Redirect to Controller Action

```crystal
redirect_to(
  controller: :symbol, 
  action: :index, 
  status: 302, 
  params: { "key" => "value" }, 
  flash: { "user_id" => "1" })
```

## Redirect Back

```crystal
redirect_back(
  status: 302, 
  params: { "key" => "value" }, 
  flash: { "user_id" => "1" }
)
```


---

## CSRF

Canonical page: https://amberframework.org/docs/v2/guides/controllers/csrf

# CSRF

To use CSRF, enable the pipe in your `routes.cr` by adding the following pipe to a pipeline.

```
plug Amber::Pipe::CSRF.new
```

Then, insert the `csrf_tag` helper in your forms.

## How to use CSRF with AJAX

Simply call the `csrf_tag` helper inside your controller and return it as part of a JSON object:

```crystal
def my_action
    {csrf: csrf_tag}.to_json
end
```

In your Javascript, after getting the JSON object back, refresh your CSRF tag with the one from the server.

```javascript
$("input[name*=_csrf]").replaceWith(e['csrf']);
```


---

## Grant ORM

Canonical page: https://amberframework.org/docs/v2/guides/models/grant

# Grant ORM

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. The Grant project keeps its
> own release lifecycle, so preserve the generated pin when following this beta.

Grant is an ActiveRecord-style ORM for Crystal that provides a familiar
interface for database operations. It is the default model layer for the Amber
V2 web template, with SQLite as the zero-setup database.

## Where the examples go

- Model declarations, columns, associations, validations, and callbacks belong
  in one class file under `src/models/`, such as `src/models/user.cr`.
- CRUD and query snippets run from the controller, job, service, or spec that
  owns the operation; they are expressions, not complete source files.
- Register database connections in a direct file under `config/`, such as
  `config/database.cr`, because the V2 entry point requires `config/*`.
- Run every command from the application root, beside `shard.yml`.

Blocks on this page use those destinations unless a closer label says
otherwise.

## Why Grant?

Grant aims for feature parity with Rails 8+ ActiveRecord while leveraging Crystal's compile-time type safety:

- **Familiar API**: If you know ActiveRecord, you know Grant
- **Type Safety**: Compile-time checking eliminates many runtime errors
- **Zero-cost Abstractions**: Performance comparable to hand-written SQL
- **Fiber-based Concurrency**: Native async support without callback complexity
- **Horizontal Sharding**: Built-in support for distributed databases

## Feature Overview

| Category | Features |
|----------|----------|
| **Core** | Models, columns, timestamps, CRUD operations |
| **Associations** | belongs_to, has_one, has_many, has_many :through, polymorphic |
| **Validations** | All standard validators, custom validations, conditional validation |
| **Callbacks** | Full lifecycle hooks including transaction callbacks |
| **Queries** | Fluent interface, scopes, complex conditions, eager loading |
| **Security** | Encrypted attributes, secure tokens, signed IDs |
| **Advanced** | Enums, serialization, dirty tracking, optimistic/pessimistic locking |

## Quick Start

### Define a Model

**File: `src/models/user.cr` — create this model class.**

```crystal
class User < Grant::Base
  connection pg
  table users

  column id : Int64, primary: true
  column email : String
  column name : String
  column role : String = "user"
  column active : Bool = true

  has_many :posts
  has_one :profile

  validates_presence_of :email, :name
  validates_email :email
  validate_uniqueness :email

  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: "admin") }

  timestamps
end
```

### Basic Operations

**File: the controller, job, service, or spec that owns the user operation.**

```crystal
# Create
user = User.create!(email: "alice@example.com", name: "Alice")

# Read
user = User.find(1)
users = User.where(active: true).order(:name).limit(10)

# Update
user.update!(name: "Alice Smith")

# Delete
user.destroy!
```

### Associations

**Files: declare relationships in the matching files under `src/models/`;
execute the usage examples from an application operation or spec.**

```crystal
# Define relationships
class Post < Grant::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
end

# Use associations
user = User.find(1)
user.posts.each do |post|
  puts post.title
  puts post.comments.count
end

# Eager loading (N+1 prevention)
posts = Post.includes(:user, :comments).where(published: true)
```

### Validations

**File: `src/models/product.cr` — keep these validations inside `Product`.**

```crystal
class Product < Grant::Base
  column price : Float64
  column stock : Int32
  column sku : String

  validates_presence_of :sku, :price
  validates_numericality_of :price, greater_than: 0
  validates_format_of :sku, with: /\A[A-Z]{2}-\d{4}\z/
  validate_uniqueness :sku

  validate "price must be reasonable" do |product|
    product.price < 1_000_000
  end
end
```

### Callbacks

**File: `src/models/order.cr` — keep these callbacks and private methods inside
`Order`.**

```crystal
class Order < Grant::Base
  before_create :generate_order_number
  before_save :calculate_total
  after_create :send_confirmation
  after_commit :update_inventory, on: :create

  private def generate_order_number
    self.order_number = "ORD-#{Time.utc.to_unix}-#{SecureRandom.hex(4)}"
  end

  private def calculate_total
    self.total = line_items.sum(&.price)
  end
end
```

## Database Support

Grant supports multiple databases:

- **PostgreSQL** (recommended): Full feature support including arrays, JSONB, UUID
- **MySQL**: JSON columns, full-text search
- **SQLite**: Great for development and testing

**File: `config/database.cr` — create this direct config file so the generated
V2 entry point loads it through `require "../config/*"`.**

```crystal
# config/database.cr
Grant::Connections << Grant::Adapter::Pg.new(
  name: "primary",
  url: ENV["DATABASE_URL"]
)
```

## Getting Started

1. [Models and Columns](basics/) - Define your data structure
2. [Associations](associations/) - Connect related models
3. [Validations](validations/) - Ensure data integrity
4. [Callbacks](callbacks/) - Hook into the lifecycle
5. [Querying](queries/) - Find and filter data
6. [Transactions](transactions/) - Maintain data consistency
7. [Security](security/) - Encryption, tokens, and secure IDs

## Migration from Granite

If you're migrating from Granite (Amber 1.x's default ORM), Grant provides a similar API with enhanced features. See the [Migration Guide](../../../migration-guide/granite-to-grant/) for details.


---

## Models and Columns

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/basics

# Models and Columns

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Model classes, columns, defaults, converters, and serialization declarations
belong under `src/models/`, one primary model per file. Register connections in
a direct file under `config/`, such as `config/database.cr`, so the V2 entry
point loads it through `require "../config/*"`. Usage expressions run from the
controller, job, service, or spec that owns the operation. Blocks on this page
use those destinations unless a closer comment identifies another role.

Models in Grant represent database tables and provide an object-oriented interface for data interaction.

## Basic Model Definition

```crystal
class User < Grant::Base
  connection pg        # Database connection
  table users         # Table name (optional, defaults to pluralized class name)

  column id : Int64, primary: true
  column email : String
  column name : String
  column active : Bool = true

  timestamps          # Adds created_at and updated_at
end
```

## Column Types

### Primitive Types

```crystal
class Product < Grant::Base
  connection pg

  # Integer types
  column id : Int64, primary: true      # BIGINT
  column quantity : Int32               # INTEGER
  column position : Int16               # SMALLINT

  # Floating point
  column price : Float64                # DOUBLE PRECISION
  column rating : Float32               # FLOAT

  # String types
  column name : String                  # VARCHAR/TEXT
  column description : String?          # Nullable string

  # Boolean
  column active : Bool = true           # BOOLEAN

  # Time/Date
  column published_at : Time?           # TIMESTAMP

  timestamps
end
```

### Special Types

```crystal
class AdvancedModel < Grant::Base
  connection pg

  # UUID (PostgreSQL, MySQL 8+)
  column id : UUID, primary: true

  # JSON (PostgreSQL JSONB, MySQL JSON)
  column metadata : JSON::Any?
  column settings : JSON::Any = JSON.parse("{}")

  # Arrays (PostgreSQL only)
  column tags : Array(String)?
  column scores : Array(Int32)?

  # Binary data
  column file_data : Bytes?
end
```

## Column Options

| Option | Description | Example |
|--------|-------------|---------|
| `primary: true` | Marks as primary key | `column id : Int64, primary: true` |
| `auto: false` | Disables auto-increment | `column uuid : String, primary: true, auto: false` |
| `converter:` | Custom type converter | `column data : JSON::Any, converter: Grant::Converters::Json` |
| Default value | Sets default | `column active : Bool = true` |

## Primary Keys

### Standard Auto-increment

```crystal
class User < Grant::Base
  column id : Int64, primary: true
end
```

### UUID Primary Key

```crystal
class Document < Grant::Base
  connection pg
  column id : UUID, primary: true
  column title : String
end

doc = Document.new(title: "Report")
doc.save
doc.id # => "550e8400-e29b-41d4-a716-446655440000"
```

### Natural Key

```crystal
class Country < Grant::Base
  connection pg
  column iso_code : String, primary: true, auto: false
  column name : String
end

Country.create!(iso_code: "US", name: "United States")
```

## Timestamps

```crystal
class Post < Grant::Base
  column id : Int64, primary: true
  column title : String

  timestamps  # Adds created_at and updated_at
end

post = Post.create!(title: "Hello")
post.created_at  # => 2025-01-15 12:00:00 UTC
post.updated_at  # => 2025-01-15 12:00:00 UTC

post.update!(title: "Hello World")
post.updated_at  # => 2025-01-15 12:05:00 UTC (updated)
```

## Default Values

### Static Defaults

```crystal
class Article < Grant::Base
  column status : String = "draft"
  column views : Int32 = 0
  column featured : Bool = false
  column tags : Array(String) = [] of String
end
```

### Dynamic Defaults via Callbacks

```crystal
class Token < Grant::Base
  column value : String?
  column expires_at : Time?

  before_create :set_defaults

  private def set_defaults
    self.value ||= Random::Secure.hex(32)
    self.expires_at ||= 24.hours.from_now
  end
end
```

## Multiple Database Connections

### Registering Connections

```crystal
# config/database.cr
Grant::Connections << Grant::Adapter::Pg.new(
  name: "primary",
  url: ENV["PRIMARY_DATABASE_URL"]
)

Grant::Connections << Grant::Adapter::Mysql.new(
  name: "legacy",
  url: ENV["LEGACY_DATABASE_URL"]
)

Grant::Connections << Grant::Adapter::Sqlite.new(
  name: "cache",
  url: "sqlite3://./cache.db"
)
```

### Using Different Connections

```crystal
class User < Grant::Base
  connection primary
  table users
end

class LegacyCustomer < Grant::Base
  connection legacy
  table customers
end

class CacheEntry < Grant::Base
  connection cache
  table cache_entries
end
```

## Type Converters

### Built-in Converters

```crystal
# Enum converter
enum Status
  Active
  Inactive
  Pending
end

class Account < Grant::Base
  column status : Status, converter: Grant::Converters::Enum(Status, String)
end

# JSON converter for custom types
class Settings
  include JSON::Serializable
  property theme : String = "light"
  property notifications : Bool = true
end

class User < Grant::Base
  column preferences : Settings, converter: Grant::Converters::Json(Settings, String)
end
```

### Custom Converters

```crystal
module Grant::Converters
  class EncryptedString < Grant::Converters::Base(String, String)
    def self.from_db(value : String) : String
      decrypt(value)
    end

    def self.to_db(value : String) : String
      encrypt(value)
    end
  end
end

class SecureModel < Grant::Base
  column secret : String, converter: Grant::Converters::EncryptedString
end
```

## JSON Serialization

Grant models include JSON::Serializable by default:

```crystal
user = User.find(1)
json = user.to_json
# => {"id":1,"name":"John","email":"john@example.com"}

# Custom serialization
class User < Grant::Base
  @[JSON::Field(key: "user_name")]
  column name : String

  @[JSON::Field(ignore: true)]
  column password_hash : String?
end
```

## Database-Specific Features

### PostgreSQL

```crystal
class PgModel < Grant::Base
  connection pg

  # Arrays
  column tags : Array(String)

  # JSONB
  column metadata : JSON::Any

  # Full-text search scope
  scope :search, ->(query : String) {
    where("to_tsvector('english', content) @@ plainto_tsquery('english', ?)", [query])
  }
end
```

### MySQL

```crystal
class MysqlModel < Grant::Base
  connection mysql

  # JSON column (MySQL 5.7+)
  column settings : JSON::Any

  # Full-text search
  scope :search, ->(query : String) {
    where("MATCH(title, content) AGAINST(? IN NATURAL LANGUAGE MODE)", [query])
  }
end
```

## Best Practices

### 1. Choose Appropriate Types

```crystal
# Good: Use specific types
column price_cents : Int32      # Store money as integers
column email : String           # Validated elsewhere
column published : Bool         # Clear boolean

# Avoid: Ambiguous types
column price : Float64          # Floating point money issues
column data : String            # Consider JSON::Any
```

### 2. Use Nullability Appropriately

```crystal
# Required fields (not nilable)
column email : String
column name : String

# Optional fields (nilable)
column bio : String?
column deleted_at : Time?
```

### 3. Set Sensible Defaults

```crystal
column status : String = "pending"
column retry_count : Int32 = 0
column active : Bool = true
```


---

## Migrations

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/migrations

# Database Migrations

Amber CLI `2.0.5` ships Micrate inside the `amber` executable. A generated web
application does not need a second migration binary or a Micrate shard entry.
Migration files belong under `db/migrations/` and database commands run from
the application root.

## Generate a migration

**Run from: the application root beside `shard.yml`.**

```bash
amber generate migration AddBirthdayToPets
```

**Generated file: `db/migrations/<timestamp>_add_birthday_to_pets.sql`.**

```sql
-- Migration: add_birthday_to_pets
-- Created: 2026-08-11 20:00:00 UTC

-- +micrate Up
-- Add SQL to apply the migration here.

-- +micrate Down
-- Add SQL to roll the migration back here.
```

The timestamp is part of the migration version. Keep it in the filename and
commit the file once; do not rename an applied migration.

## Write both directions

**File: `db/migrations/<timestamp>_add_birthday_to_pets.sql` — replace the two
placeholder comments.**

```sql
-- +micrate Up
ALTER TABLE pets ADD COLUMN birthday DATE;

-- +micrate Down
ALTER TABLE pets DROP COLUMN birthday;
```

Write SQL for the database selected when the application was generated. SQL
features differ across SQLite, PostgreSQL, and MySQL; test both directions on
the same engine and major version used in production. In particular, older
SQLite versions support fewer `ALTER TABLE` operations and may require a table
rebuild migration.

## Apply development and test separately

**Run from: the application root.**

```bash
amber database migrate
AMBER_ENV=test amber database migrate
```

The command reads `config/environments/development.yml` by default and
`config/environments/test.yml` when `AMBER_ENV=test`. `DATABASE_URL` overrides
that file for CLI operations.

For SQLite, the first migration creates the database file. For PostgreSQL or
MySQL, create the database first when it does not already exist:

**Run from: the application root for a PostgreSQL or MySQL database.**

```bash
amber database create
amber database migrate
```

## Inspect and reverse

**Run from: the application root.**

```bash
amber database status
amber database version
amber database rollback
amber database redo
```

- `status` lists applied and pending files.
- `version` prints the latest applied migration version.
- `rollback` runs the latest applied Down section once.
- `redo` rolls back and reapplies the latest migration.

Use rollback and redo while developing a new migration. Once a migration has
been applied in a shared environment, add a new corrective migration instead
of rewriting its history.

## Seed data

**File: `db/seeds.cr` — application-owned seed program.**

```crystal
require "../config/*"
require "../src/models/**"

Pet.create(name: "Miso", species: "Cat", adopted: false)
```

**Run from: the application root after migrations.**

```bash
amber database seed
```

Keep production seed behavior idempotent or explicitly one-time. A seed is
ordinary application code; it is not tracked as a migration version.

## Release workflow

Before deploying an application with schema changes:

1. Back up the production database and prove the restore path.
2. Apply the migration to a production-shaped staging database.
3. Run request and model specs against the migrated test database.
4. Review locks, table rewrites, and compatibility with the currently running
   application version.
5. Apply migrations as an explicit release step before starting code that
   requires the new schema.

The default SQLite workflow is excellent for local development and small
single-host applications. Choose PostgreSQL or MySQL when the deployment needs
independent database scaling, multiple application hosts, or operational
features provided by those servers.


---

## Associations

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/associations

# Associations

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Association declarations and helper methods belong inside the matching Grant
model under `src/models/`, such as `src/models/post.cr`. Usage and eager-loading
expressions run from the controller, job, service, or spec that owns the
operation. SQL index examples belong in the migration system selected by the
application, not in a model file. Blocks on this page use those destinations
unless a closer comment identifies a different role.

Grant associations declare how models find related records and where the foreign
key for that relationship lives.

## belongs_to

Creates a one-to-one connection where the declaring model holds the foreign key.

```crystal
class Post < Grant::Base
  belongs_to :user

  column id : Int64, primary: true
  column title : String
  column user_id : Int64  # Foreign key
end

# Usage
post = Post.find(1)
author = post.user  # Fetches associated user
```

### belongs_to Options

```crystal
class Post < Grant::Base
  # Custom foreign key
  belongs_to user : User, foreign_key: author_id : Int64

  # Optional association (allows NULL)
  belongs_to :category, optional: true

  # With counter cache
  belongs_to :blog, counter_cache: true

  # Touch parent on save
  belongs_to :article, touch: true

  # Custom class name
  belongs_to :author, class_name: User
end
```

## has_one

Creates a one-to-one connection where the other model holds the foreign key.

```crystal
class User < Grant::Base
  has_one :profile

  column id : Int64, primary: true
  column email : String
end

class Profile < Grant::Base
  belongs_to :user

  column id : Int64, primary: true
  column bio : String
  column user_id : Int64
end

# Usage
user = User.find(1)
profile = user.profile
user.profile = Profile.new(bio: "My bio")
```

## has_many

Creates a one-to-many connection.

```crystal
class User < Grant::Base
  has_many :posts
  has_many :comments

  # With custom foreign key
  has_many :articles, class_name: Post, foreign_key: :author_id

  column id : Int64, primary: true
end

# Usage
user = User.find(1)
user.posts.each do |post|
  puts post.title
end

# Add new post
user.posts << Post.new(title: "New Post")
```

## has_many :through

Creates a many-to-many connection through a join model.

```crystal
class User < Grant::Base
  has_many :participations
  has_many :rooms, through: :participations

  column id : Int64, primary: true
  column name : String
end

class Participation < Grant::Base
  belongs_to :user
  belongs_to :room

  column id : Int64, primary: true
  column joined_at : Time
  column role : String  # Additional attributes
end

class Room < Grant::Base
  has_many :participations
  has_many :users, through: :participations

  column id : Int64, primary: true
  column name : String
end

# Usage
user = User.find(1)
user.rooms.each { |room| puts room.name }

# Create association
Participation.create!(user: user, room: room, role: "member")
```

## Polymorphic Associations

Allow a model to belong to multiple other models through a single association.

```crystal
class Comment < Grant::Base
  belongs_to :commentable, polymorphic: true

  column id : Int64, primary: true
  column content : String
  column commentable_id : Int64?
  column commentable_type : String?
end

class Post < Grant::Base
  has_many :comments, as: :commentable
end

class Photo < Grant::Base
  has_many :comments, as: :commentable
end

# Usage
post = Post.create!(title: "My Post")
photo = Photo.create!(url: "image.jpg")

comment1 = Comment.create!(content: "Great post!", commentable: post)
comment2 = Comment.create!(content: "Nice photo!", commentable: photo)

# Retrieve polymorphic association
comment = Comment.find(1)
if comment.commentable.is_a?(Post)
  puts "Comment on post: #{comment.commentable.title}"
end
```

## Self-Referential Associations

Models that have associations to themselves.

```crystal
class Employee < Grant::Base
  belongs_to :manager, class_name: Employee, optional: true
  has_many :subordinates, class_name: Employee, foreign_key: :manager_id

  column id : Int64, primary: true
  column name : String
  column manager_id : Int64?
end

# Usage
ceo = Employee.create!(name: "CEO")
manager = Employee.create!(name: "Manager", manager: ceo)
employee = Employee.create!(name: "Employee", manager: manager)

ceo.subordinates      # => [manager]
manager.subordinates  # => [employee]
employee.manager      # => manager
```

## Association Options

### dependent

Controls what happens to associated records when parent is destroyed.

```crystal
class Author < Grant::Base
  # Destroys all posts when author is destroyed
  has_many :posts, dependent: :destroy

  # Sets category_id to NULL on products
  has_many :products, dependent: :nullify

  # Prevents deletion if players exist
  has_many :players, dependent: :restrict
end
```

### counter_cache

Maintains count of associated records on parent model.

```crystal
class Blog < Grant::Base
  column posts_count : Int32 = 0
  has_many :posts
end

class Post < Grant::Base
  belongs_to :blog, counter_cache: true
end

# Usage
blog = Blog.create!(title: "My Blog")
Post.create!(title: "First Post", blog: blog)
blog.reload.posts_count  # => 1
```

### touch

Updates parent's `updated_at` when child is saved.

```crystal
class Comment < Grant::Base
  belongs_to :post, touch: true

  # Touch specific column
  belongs_to :article, touch: :last_activity_at
end

# Updates post.updated_at whenever comment changes
comment.update!(content: "Updated")
```

### autosave

Automatically saves associated records with parent.

```crystal
class Order < Grant::Base
  has_many :line_items, autosave: true
  has_one :invoice, autosave: true
end

order = Order.new
order.line_items << LineItem.new(product: "Widget", qty: 2)
order.invoice = Invoice.new(total: 100)
order.save!  # Saves everything in transaction
```

## Nested Attributes

Accept nested attributes for associated records.

```crystal
class Order < Grant::Base
  has_many :line_items

  accepts_nested_attributes_for line_items : LineItem,
    allow_destroy: true,
    reject_if: ->(attrs : Hash) { attrs["quantity"]?.try(&.to_i) == 0 },
    limit: 50
end

# Create order with line items
order = Order.create!(
  customer_id: 1,
  line_items_attributes: [
    {product_id: 1, quantity: 2},
    {product_id: 3, quantity: 1}
  ]
)
```

## Eager Loading (N+1 Prevention)

```crystal
# Bad: N+1 queries
posts = Post.all
posts.each do |post|
  puts post.author.name  # Query for each post
end

# Good: Eager loading
posts = Post.includes(:author)
posts.each do |post|
  puts post.author.name  # No additional queries
end

# Multiple associations
posts = Post.includes(:author, :comments)

# Nested associations
users = User.includes(posts: [:comments, :tags])
```

## Validating Associations

```crystal
class Order < Grant::Base
  has_many :line_items
  belongs_to :customer

  validates_associated :line_items

  validate :must_have_items

  private def must_have_items
    if line_items.empty?
      errors.add(:line_items, "must have at least one item")
    end
  end
end
```

## Best Practices

### 1. Index Foreign Keys

```sql
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_blog_id ON posts(blog_id);
```

### 2. Use dependent Wisely

- `:destroy` - When child records should be deleted
- `:nullify` - When child records can exist independently
- `:restrict` - When deletion should be prevented

### 3. Document Complex Associations

```crystal
# Represents many-to-many between users and projects
# through team memberships with role attribute
class TeamMembership < Grant::Base
  belongs_to :user
  belongs_to :project

  column role : String  # "owner", "member", "viewer"
end
```


---

## Validations

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/validations

# Validations

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Validation declarations, custom validator methods, conditions, and validation
callbacks belong inside the matching Grant model under `src/models/`. Examples
that call validation methods or inspect errors run from the controller,
service, form object, or spec that owns the operation. Database constraints
belong in the migration system selected by the application. Blocks on this page
use those destinations unless a closer comment identifies a different role.

Grant runs model validations before persistence and records failures on the
model's error collection.

## Basic Validation

```crystal
class User < Grant::Base
  column email : String
  column age : Int32

  validates_email :email
  validates_numericality_of :age, greater_than: 0
end

user = User.new(email: "invalid", age: -5)
user.valid?  # => false
user.errors  # => Array of validation errors
user.save    # => false (won't save invalid records)
user.save!   # => raises Grant::RecordInvalid
```

## Built-in Validators

### Presence and Absence

```crystal
class Product < Grant::Base
  column name : String
  column internal_notes : String?

  validates_presence_of :name
  validate_not_blank :name

  validates_absence_of :internal_notes  # Must be nil/blank
end
```

### Numericality

```crystal
class Order < Grant::Base
  column total : Float64
  column quantity : Int32
  column discount : Float64

  validates_numericality_of :total, greater_than: 0
  validates_numericality_of :quantity,
    only_integer: true,
    greater_than: 0
  validates_numericality_of :discount,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
end
```

**Options:**
- `greater_than`, `greater_than_or_equal_to`
- `less_than`, `less_than_or_equal_to`
- `equal_to`, `other_than`
- `odd: true`, `even: true`
- `only_integer: true`
- `in: range`
- `allow_nil: true`, `allow_blank: true`

### Format

```crystal
class User < Grant::Base
  column username : String
  column phone : String

  validates_format_of :username, with: /\A[a-zA-Z0-9_]+\z/
  validates_format_of :phone, with: /\A\d{3}-\d{3}-\d{4}\z/
  validates_format_of :username, without: /\A(admin|root)\z/,
    message: "is reserved"
end
```

### Length/Size

```crystal
class Article < Grant::Base
  column title : String
  column body : String
  column tags : Array(String)

  validates_length_of :title, minimum: 5, maximum: 100
  validates_length_of :body, minimum: 100
  validates_size_of :tags, maximum: 10
  validates_length_of :slug, is: 8  # Exactly 8
end
```

### Email and URL

```crystal
class Contact < Grant::Base
  column email : String
  column website : String?

  validates_email :email
  validates_url :website, allow_blank: true
end
```

### Confirmation

```crystal
class Account < Grant::Base
  column email : String
  column password : String

  validates_confirmation_of :email
  validates_confirmation_of :password
end

# Usage requires confirmation fields
account = Account.new(
  email: "user@example.com",
  password: "secret123"
)
account.email_confirmation = "user@example.com"
account.password_confirmation = "secret123"
account.valid?  # => true
```

### Inclusion and Exclusion

```crystal
class Subscription < Grant::Base
  column plan : String
  column username : String

  validates_inclusion_of :plan,
    in: ["free", "basic", "premium", "enterprise"]

  validates_exclusion_of :username,
    in: ["admin", "root", "system"],
    message: "is reserved"
end
```

### Uniqueness

```crystal
class User < Grant::Base
  column email : String
  column employee_id : String
  column company_id : Int64

  validate_uniqueness :email

  # Scoped uniqueness (unique within scope)
  validate_uniqueness :employee_id, scope: :company_id
end
```

## Custom Validations

### Block Syntax

```crystal
class Post < Grant::Base
  column title : String
  column content : String

  validate :title, "can't be blank" do |post|
    !post.title.to_s.blank?
  end

  validate :content, "must be at least 10 characters" do |post|
    post.content.size >= 10
  end
end
```

### Method Reference

```crystal
class Product < Grant::Base
  column price : Float64
  column sale_price : Float64?
  column on_sale : Bool

  validate :valid_sale_price

  private def valid_sale_price
    return true unless on_sale && sale_price

    if sale_price.not_nil! >= price
      errors.add(:sale_price, "must be less than regular price")
    end
  end
end
```

### Model-level Validation

```crystal
class Order < Grant::Base
  validate "total must equal sum of line items" do |order|
    calculated_total = order.line_items.sum(&.total_price)
    (order.total_amount - calculated_total).abs < 0.01
  end
end
```

## Conditional Validations

### Using Symbols

```crystal
class Post < Grant::Base
  column title : String
  column content : String
  column published : Bool

  validates_length_of :title, minimum: 10, if: :published?
  validates_presence_of :content, unless: :draft?

  def published?
    published == true
  end

  def draft?
    !published
  end
end
```

### Using Procs

```crystal
class Order < Grant::Base
  column payment_method : String
  column credit_card : String?

  validates_presence_of :credit_card,
    if: ->(order : Order) { order.payment_method == "credit" }
end
```

## Validation Contexts

```crystal
class User < Grant::Base
  column email : String
  column password : String

  # Only on create
  validates_presence_of :password, on: :create

  # Only on update
  validates_confirmation_of :password, on: :update

  # Custom context
  validate :email, "must be corporate email", on: :corporate do |user|
    user.email.ends_with?("@company.com")
  end
end

# Usage with context
user.valid?(:corporate)
user.save(context: :corporate)
```

## Working with Errors

```crystal
user = User.new(email: "invalid", age: 10)
user.valid?  # => false

# Get all errors
user.errors  # => Array(Grant::Error)

# Get errors for specific field
email_errors = user.errors.select { |e| e.field == :email }

# Get error messages
user.errors.map(&.message)
# => ["is not a valid email", "must be at least 18"]

# Full error messages
user.errors.map { |e| "#{e.field} #{e.message}" }
# => ["email is not a valid email", "age must be at least 18"]

# Add custom errors
user.errors.add(:base, "Something went wrong")
```

## Custom Error Messages

```crystal
class User < Grant::Base
  validates_numericality_of :age,
    greater_than_or_equal_to: 18,
    message: "You must be at least 18 years old"

  validates_format_of :email,
    with: /@company\.com\z/,
    message: "must be a company email address"
end
```

## Validation Callbacks

```crystal
class User < Grant::Base
  before_validation :normalize_email
  after_validation :set_defaults

  private def normalize_email
    self.email = email.downcase.strip if email
  end

  private def set_defaults
    self.role ||= "user" if errors.empty?
  end
end
```

## Skipping Validations

```crystal
# Skip validations (use carefully!)
user.save(validate: false)

# Bulk operations skip validations
User.update_all(active: false)
```

## Best Practices

### 1. Layer Validations

```crystal
class CreditCard < Grant::Base
  # Format validation
  validates_format_of :number, with: /\A\d{16}\z/

  # Business logic validation
  validate :number, "must pass Luhn check" do |card|
    LuhnValidator.valid?(card.number)
  end

  # Database constraint (in migration)
  # ADD CONSTRAINT valid_card_number CHECK (char_length(number) = 16)
end
```

### 2. Add Database Constraints

```crystal
# Model validation
validate_uniqueness :email

# Also add database constraint
# CREATE UNIQUE INDEX users_email_unique ON users(email);
```

### 3. Order Validations by Cost

```crystal
class Product < Grant::Base
  # Fast validations first
  validates_presence_of :name
  validates_length_of :name, in: 1..100

  # Database queries later
  validate_uniqueness :sku

  # Expensive operations last
  validate :image, "must be valid" do |product|
    ImageValidator.valid?(product.image_data) if product.image_data
  end
end
```


---

## Callbacks

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/callbacks

# Callbacks

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Callback declarations and their private methods belong inside the matching
Grant model under `src/models/`, such as `src/models/user.cr`. Examples that
invoke `save`, `destroy`, or a bulk operation run from the controller, job,
service, or spec that owns the operation. External delivery belongs in a job or
service called after commit. Blocks on this page use those destinations unless
a closer comment identifies a different role.

Callbacks are methods that get called at certain moments of an object's lifecycle. They allow you to trigger logic before or after alterations to your model's state.

## Available Callbacks

### Create Callbacks

```crystal
class User < Grant::Base
  before_validation :set_defaults           # 1. First callback
  # validations run here                    # 2. Validations
  after_validation :process_validated_data  # 3. After validation
  before_save :before_save_tasks           # 4. Before save (create or update)
  before_create :before_create_tasks       # 5. Before create specifically
  # INSERT happens here                     # 6. Database insert
  after_create :after_create_tasks         # 7. After create
  after_save :after_save_tasks            # 8. After save (create or update)
  after_commit :after_commit_tasks        # 9. After transaction commits
end
```

### Update Callbacks

```crystal
class Product < Grant::Base
  before_validation :normalize_data         # 1. First callback
  # validations run here                    # 2. Validations
  after_validation :process_changes        # 3. After validation
  before_save :before_save_tasks          # 4. Before save
  before_update :before_update_tasks      # 5. Before update specifically
  # UPDATE happens here                    # 6. Database update
  after_update :after_update_tasks        # 7. After update
  after_save :after_save_tasks           # 8. After save
  after_commit :after_commit_tasks       # 9. After transaction commits
end
```

### Destroy Callbacks

```crystal
class Comment < Grant::Base
  before_destroy :cleanup_associations     # 1. Before destroy
  # DELETE happens here                    # 2. Database delete
  after_destroy :log_deletion             # 3. After destroy
  after_commit :notify_deletion          # 4. After transaction commits
end
```

## Callback Registration

### Method Symbols

```crystal
class Article < Grant::Base
  before_save :sanitize_content
  after_create :publish_to_feed

  private def sanitize_content
    self.content = Sanitizer.clean(content)
  end

  private def publish_to_feed
    FeedService.publish(self) if published?
  end
end
```

### Blocks

```crystal
class Order < Grant::Base
  before_save do
    self.total = calculate_total
  end

  after_create do
    OrderMailer.confirmation(self).deliver_later
  end
end
```

### Conditional Callbacks

```crystal
class Post < Grant::Base
  # With symbol conditions
  before_save :update_slug, if: :title_changed?
  after_create :notify_subscribers, if: :published?

  # With proc conditions
  before_destroy :archive_content,
    if: ->(post : Post) { post.views > 1000 }

  # Multiple conditions
  after_save :clear_cache,
    if: :published?,
    unless: :draft?
end
```

## Common Callback Patterns

### Data Normalization

```crystal
class User < Grant::Base
  before_validation :normalize_fields

  column email : String
  column phone : String?
  column name : String

  private def normalize_fields
    self.email = email.downcase.strip
    self.phone = phone.try(&.gsub(/\D/, ""))
    self.name = name.split.map(&.capitalize).join(" ")
  end
end
```

### Setting Defaults

```crystal
class Document < Grant::Base
  before_create :set_defaults

  column uuid : String
  column version : Int32
  column status : String

  private def set_defaults
    self.uuid ||= UUID.random.to_s
    self.version ||= 1
    self.status ||= "draft"
  end
end
```

### Generating Tokens

```crystal
class Session < Grant::Base
  before_create :generate_token

  column token : String
  column expires_at : Time

  private def generate_token
    loop do
      self.token = Random::Secure.hex(32)
      break unless Session.exists?(token: token)
    end
    self.expires_at = 24.hours.from_now
  end
end
```

### Slug Generation

```crystal
class Article < Grant::Base
  before_save :generate_slug

  column title : String
  column slug : String

  private def generate_slug
    return unless title_changed?

    base_slug = title.downcase.gsub(/[^a-z0-9]+/, "-")
    self.slug = base_slug

    counter = 1
    while Article.exists?(slug: slug)
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
end
```

### Audit Trails

```crystal
class AuditableModel < Grant::Base
  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy

  private def log_create
    AuditLog.create!(
      model: self.class.name,
      record_id: id,
      action: "create",
      user_id: Current.user_id,
      changes: attributes.to_json
    )
  end

  private def log_update
    return unless changes.any?
    AuditLog.create!(
      model: self.class.name,
      record_id: id,
      action: "update",
      user_id: Current.user_id,
      changes: changes.to_json
    )
  end
end
```

### Cache Management

```crystal
class Product < Grant::Base
  after_save :clear_cache
  after_destroy :clear_cache

  private def clear_cache
    Cache.delete("product:#{id}")
    Cache.delete("category:#{category_id}:products")
  end
end
```

## Halting Execution

### Throwing :abort

```crystal
class Order < Grant::Base
  before_save :check_inventory

  private def check_inventory
    if total_items > available_stock
      errors.add(:items, "Insufficient inventory")
      throw :abort  # Halts execution
    end
  end
end
```

### Preventing Destruction

```crystal
class User < Grant::Base
  before_destroy :prevent_admin_deletion

  private def prevent_admin_deletion
    if admin? && User.where(admin: true).count == 1
      errors.add(:base, "Cannot delete the last admin")
      throw :abort
    end
  end
end
```

## Transaction Callbacks

### after_commit

Runs after the database transaction successfully commits:

```crystal
class Order < Grant::Base
  after_commit :send_confirmation, on: :create
  after_commit :update_inventory, on: :update

  private def send_confirmation
    # Safe to send email - transaction committed
    OrderMailer.confirmation(self).deliver_later
  end

  private def update_inventory
    # Safe to call external services
    InventoryService.sync(self)
  end
end
```

### after_rollback

Runs if the database transaction is rolled back:

```crystal
class Payment < Grant::Base
  after_rollback :log_failure

  private def log_failure
    Log.error { "Payment #{id} failed: #{errors.full_messages}" }
  end
end
```

## Performance Considerations

### Keep Callbacks Fast

```crystal
class Post < Grant::Base
  # Bad: Synchronous external call
  after_create :notify_external_service

  private def notify_external_service
    HTTPClient.post("https://api.example.com/webhook", body: to_json)
  end

  # Good: Queue for background processing
  after_create :queue_notification

  private def queue_notification
    NotificationJob.perform_later(self.id)
  end
end
```

### Use Conditional Callbacks

```crystal
class User < Grant::Base
  # Only run expensive callbacks when necessary
  after_save :sync_to_crm, if: :crm_fields_changed?

  private def crm_fields_changed?
    (changes.keys & ["email", "name", "company"]).any?
  end
end
```

## Skipping Callbacks

```crystal
# Skip callbacks when needed
user.save(skip_callbacks: true)

# Bulk operations skip callbacks
User.update_all(active: false)
user.update_columns(name: "New")  # Direct SQL, no callbacks
```

## Best Practices

### 1. Keep Callbacks Simple

```crystal
# Good: Single responsibility
before_save :normalize_email
before_save :hash_password
before_save :set_defaults

# Bad: Doing too much
before_save :do_everything
```

### 2. Use Appropriate Callback

```crystal
# Good: after_commit for external services
after_commit :send_email

# Bad: after_save might run even if rolled back
after_save :send_email
```

### 3. Consider Service Objects

```crystal
# Instead of complex callbacks
class User < Grant::Base
  after_create :setup_user_account

  private def setup_user_account
    UserAccountSetupService.new(self).perform
  end
end

class UserAccountSetupService
  def initialize(@user : User)
  end

  def perform
    create_profile
    send_welcome_email
    assign_default_role
  end
end
```


---

## Querying

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/queries

# Querying

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Query expressions run from the controller, job, service, or spec that owns the
read; they are not complete model files. Named and default scopes belong inside
the matching Grant model under `src/models/`. The complex-query example should
be extracted to a service or query object under `src/services/` when it is
shared or independently tested. Blocks on this page use those destinations
unless a closer comment identifies a different role.

Grant provides a fluent, chainable query API that generates efficient SQL while maintaining type safety.

## Basic Querying

```crystal
# Find all active users
users = User.where(active: true)

# Chain multiple conditions (AND)
posts = Post.where(published: true, featured: true)
            .where(author_id: current_user.id)

# Find with multiple fields
post = Post.find_by(slug: "my-post", published: true)
```

### Query Execution

Queries are lazy - they don't execute until you call a terminal method:

```crystal
# Building query (not executed)
query = User.where(active: true).order(:name)

# Execution happens here
users = query.select     # Returns array of User
first = query.first      # Returns User?
count = query.count      # Returns Int32
exists = query.exists?   # Returns Bool
```

## Where Conditions

### Basic WHERE

```crystal
# Equality
User.where(status: "active")
User.where(age: 25)

# Multiple conditions (AND)
User.where(status: "active", verified: true)
```

### Comparison Operators

```crystal
Post.where(:views, :gt, 100)        # Greater than
Post.where(:price, :lteq, 50.0)     # Less than or equal
Post.where(:created_at, :gt, 7.days.ago)

# Available operators
Post.where(:field, :eq, value)      # =
Post.where(:field, :neq, value)     # !=
Post.where(:field, :gt, value)      # >
Post.where(:field, :lt, value)      # <
Post.where(:field, :gteq, value)    # >=
Post.where(:field, :lteq, value)    # <=
Post.where(:field, :in, array)      # IN
Post.where(:field, :nin, array)     # NOT IN
Post.where(:field, :like, pattern)  # LIKE
```

### WhereChain Methods

```crystal
# Pattern matching
User.where.like(:email, "%@gmail.com")
User.where.not_like(:name, "test%")

# Comparisons
User.where.gt(:age, 18)
User.where.lt(:age, 65)
User.where.gteq(:score, 80)
User.where.lteq(:price, 100)

# NULL checks
User.where.is_null(:deleted_at)
User.where.is_not_null(:verified_at)

# Ranges
User.where.between(:age, 25..35)
Product.where.between(:price, 10.0..50.0)

# NOT IN
User.where.not_in(:id, [1, 2, 3])
```

### Raw SQL Conditions

```crystal
# With placeholders
Post.where("LOWER(title) LIKE ?", ["%crystal%"])
User.where("age * 2 > ?", [50])

# PostgreSQL specific
Post.where("tags @> ARRAY[?]::varchar[]", ["ruby"])
Post.where("metadata->>'key' = $", ["value"])
```

## OR and NOT Conditions

### OR Groups

```crystal
# Simple OR
User.where(role: "admin").or { |q| q.where(role: "moderator") }
# SQL: WHERE role = 'admin' OR role = 'moderator'

# Complex OR
User.where(verified: true)
    .or do |q|
      q.where(role: "admin")
       .where.gt(:level, 10)
    end
# SQL: WHERE verified = true OR (role = 'admin' AND level > 10)
```

### NOT Groups

```crystal
# Simple NOT
User.not { |q| q.where(status: "banned") }

# Complex NOT
User.not do |q|
  q.where(active: false)
   .where.is_null(:email_verified_at)
end
# SQL: WHERE NOT (active = false AND email_verified_at IS NULL)
```

## Ordering and Limiting

```crystal
# Single field
User.order(:name)              # ASC by default
User.order(created_at: :desc)  # Explicit direction

# Multiple fields
Post.order(featured: :desc, created_at: :desc)

# Limit and offset
Post.limit(10)
Post.offset(20).limit(10)  # Pagination

# First/Last
User.first          # Single record
User.first(5)       # First 5 records
User.last(10)       # Last 10 records

# Distinct
User.distinct.select(:country)
```

## Scopes

### Defining Scopes

```crystal
class Post < Grant::Base
  # Simple scopes
  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(created_at: :desc) }

  # Parameterized scopes
  scope :by_author, ->(author_id : Int32) { where(author_id: author_id) }
  scope :tagged_with, ->(tag : String) { where("tags @> ARRAY[?]", [tag]) }
  scope :older_than, ->(date : Time) { where.lt(:created_at, date) }

  # Complex scopes
  scope :popular, -> {
    where.gt(:views, 1000)
         .where.gt(:likes, 100)
         .order(views: :desc)
  }
end

# Using scopes
Post.published.recent.limit(10)
Post.by_author(current_user.id).featured
```

### Default Scopes

```crystal
class Product < Grant::Base
  # Applied to all queries automatically
  default_scope { where(active: true).where.is_null(:deleted_at) }

  # Bypass default scope
  scope :all_including_deleted, -> { unscoped }
end

Product.all              # Includes default scope
Product.unscoped.all     # Bypasses default scope
```

## Joins and Eager Loading

### Joins

```crystal
# Join with association
Post.joins(:author)
    .where("users.active = ?", [true])

# Left joins (include records without association)
User.left_joins(:posts)
    .where("posts.id IS NULL")  # Users without posts
```

### Eager Loading

```crystal
# Preload associations
posts = Post.includes(:author, :comments)
posts.each do |post|
  puts post.author.name        # No additional query
  puts post.comments.size      # No additional query
end

# Nested includes
User.includes(posts: [:comments, :tags])
```

## Aggregations

```crystal
# Count
User.count
User.where(active: true).count
User.distinct.count(:country)

# Sum, Average, Min, Max
Order.sum(:total)
Product.average(:price)
Product.minimum(:price)
Product.maximum(:stock)

# With grouping
Order.group_by(:customer_id).sum(:total)
Review.group_by(:product_id).average(:rating)
```

## Batch Processing

```crystal
# Bad: Loads everything at once
User.all.each { |user| user.process! }

# Good: Process in batches
User.find_in_batches(batch_size: 1000) do |users|
  users.each(&.process!)
end
```

## Pluck for Values

```crystal
# Bad: Instantiate models
emails = User.where(active: true).map(&.email)

# Good: Direct database values
emails = User.where(active: true).pluck(:email)
```

## Complex Query Example

```crystal
def search_products(params)
  query = Product.where(active: true)

  # Text search
  if term = params["q"]?
    query = query.where.like(:name, "%#{term}%")
                 .or { |q| q.where.like(:description, "%#{term}%") }
  end

  # Price range
  if min_price = params["min_price"]?
    query = query.where.gteq(:price, min_price.to_f)
  end
  if max_price = params["max_price"]?
    query = query.where.lteq(:price, max_price.to_f)
  end

  # Categories
  if categories = params["categories"]?
    query = query.where.in(:category_id, categories.split(","))
  end

  # In stock only
  if params["in_stock"]?
    query = query.where.gt(:stock, 0)
  end

  # Sorting
  case params["sort"]?
  when "price_asc"
    query = query.order(:price)
  when "price_desc"
    query = query.order(price: :desc)
  when "newest"
    query = query.order(created_at: :desc)
  else
    query = query.order(:name)
  end

  query.limit(params.fetch("limit", "20").to_i)
end
```

## Best Practices

### 1. Use Indexes

```crystal
# Ensure indexed columns in WHERE
User.where(email: "user@example.com")  # email should be indexed
```

### 2. Select Only Needed Columns

```crystal
# Bad: Loads all columns
users = User.where(active: true)

# Good: Load only required columns
users = User.where(active: true).select(:id, :name, :email)
```

### 3. Avoid N+1 Queries

```crystal
# Bad: N+1 queries
posts = Post.all
posts.each { |post| puts post.author.name }

# Good: Eager loading
posts = Post.includes(:author)
posts.each { |post| puts post.author.name }
```


---

## Transactions

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/transactions

# Transactions

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Transaction and locking expressions run from the controller, job, service, or
spec that owns the multi-record operation. Optimistic-locking columns and
transaction callback declarations belong inside the matching Grant model under
`src/models/`. Shared financial or inventory workflows should live in a service
under `src/services/` with focused specs. Blocks on this page use those
destinations unless a closer comment identifies a different role.

Use a transaction when several writes must commit or roll back together. Grant
also exposes isolation and locking controls for workflows that coordinate
concurrent database changes.

## Basic Transactions

```crystal
Grant::Base.transaction do
  user = User.find!(1)
  user.balance -= 100
  user.save!

  transfer = Transfer.create!(
    user_id: user.id,
    amount: -100
  )

  # Automatic rollback on exception
  raise "Insufficient funds" if user.balance < 0
end
```

### Transaction Methods

```crystal
# Block syntax
Grant::Base.transaction do
  # All operations in one transaction
  User.create!(name: "Alice")
  User.create!(name: "Bob")
end

# With explicit rollback
Grant::Base.transaction do |tx|
  user = User.create!(name: "Alice")

  if some_condition_fails
    raise DB::Rollback.new("Condition failed")
  end
end
```

## Nested Transactions with Savepoints

```crystal
Grant::Base.transaction do
  order = Order.create!(customer_id: 1, total: 0)

  items.each do |item_data|
    Grant::Base.transaction do  # Savepoint
      item = OrderItem.create!(
        order_id: order.id,
        product_id: item_data[:product_id],
        quantity: item_data[:quantity]
      )

      product = Product.find!(item_data[:product_id])
      product.stock -= item_data[:quantity]

      # Rollback just this item if out of stock
      raise "Out of stock" if product.stock < 0

      product.save!
      order.total += item.subtotal
    end
  rescue
    # Skip item but continue with order
    Log.warn { "Skipping item #{item_data[:id]}" }
  end

  order.save!
end
```

## Isolation Levels

```crystal
# Available levels
IsolationLevel::ReadUncommitted
IsolationLevel::ReadCommitted
IsolationLevel::RepeatableRead
IsolationLevel::Serializable

# Serializable for financial operations
Grant::Base.transaction(isolation: :serializable) do
  account1 = Account.find!(1)
  account2 = Account.find!(2)

  account1.balance -= 100
  account2.balance += 100

  account1.save!
  account2.save!
end

# Read committed for reports
Grant::Base.transaction(isolation: :read_committed) do
  generate_report
end
```

## Pessimistic Locking

Lock rows to prevent concurrent modifications.

### Row-Level Locking

```crystal
Grant::Base.transaction do
  # Lock account for update
  account = Account.find!(1)
  account.lock!  # FOR UPDATE

  # No other transaction can modify this account
  account.balance -= 100
  account.save!
end

# Lock with custom mode
Grant::Base.transaction do
  account = Account.lock!(:share)  # FOR SHARE
  # Read but prevent updates
end
```

### with_lock Helper

```crystal
account = Account.find!(1)

account.with_lock do |locked_account|
  locked_account.balance -= 100
  locked_account.save!
end
```

### Lock Multiple Rows

```crystal
Grant::Base.transaction do
  accounts = Account.where(user_id: 1).lock
  accounts.each do |account|
    account.process_fees
  end
end
```

## Optimistic Locking

Use a version column to detect concurrent modifications.

```crystal
class Product < Grant::Base
  include Grant::Locking::Optimistic

  column id : Int64, primary: true
  column name : String
  column price : Float64
  column lock_version : Int32 = 0
end

# Automatic version checking
product = Product.find!(1)
product.price = 29.99
product.save!  # Increments lock_version

# Concurrent update detection
product1 = Product.find!(1)
product2 = Product.find!(1)

product1.price = 19.99
product1.save!  # Works

product2.price = 24.99
product2.save!  # Raises Grant::StaleRecordError
```

### Handling Conflicts

```crystal
def update_with_retry(product, max_retries = 3)
  retry_count = 0

  loop do
    begin
      yield product
      product.save!
      break
    rescue Grant::StaleRecordError
      retry_count += 1
      raise if retry_count >= max_retries

      product.reload
      Log.info { "Retrying update (attempt #{retry_count})" }
    end
  end
end

update_with_retry(product) do |p|
  p.stock -= 1
end
```

## Deadlock Prevention

### Ordered Locking

Always acquire locks in the same order to prevent deadlocks.

```crystal
def transfer_funds(from_id, to_id, amount)
  # Sort IDs to ensure consistent lock order
  ids = [from_id, to_id].sort

  Grant::Base.transaction do
    accounts = ids.map { |id| Account.find_and_lock!(id) }
    from = accounts.find { |a| a.id == from_id }.not_nil!
    to = accounts.find { |a| a.id == to_id }.not_nil!

    from.balance -= amount
    to.balance += amount

    from.save!
    to.save!
  end
end
```

### Lock Timeouts

```crystal
Grant::Base.transaction do
  Grant.connection.exec("SET LOCAL lock_timeout = '5s'")

  begin
    account = Account.find_and_lock!(1)
    account.process!
  rescue ex : DB::Error
    if ex.message.includes?("lock timeout")
      Log.warn { "Lock timeout, retrying..." }
    end
    raise ex
  end
end
```

## Transaction Callbacks

```crystal
class Order < Grant::Base
  after_commit :send_confirmation, on: :create
  after_commit :update_inventory, on: :update
  after_rollback :log_failure

  private def send_confirmation
    # Safe - transaction committed
    OrderMailer.confirmation(self).deliver_later
  end

  private def update_inventory
    InventoryService.sync(self)
  end

  private def log_failure
    Log.error { "Order #{id} failed to save" }
  end
end
```

## Best Practices

### 1. Keep Transactions Short

```crystal
# Good: Short transaction
Grant::Base.transaction do
  user.update!(status: "active")
end

# Bad: Long transaction
Grant::Base.transaction do
  users = User.all.to_a
  users.each do |user|
    user.process_complex_logic  # Time-consuming
    user.save!
  end
end
```

### 2. Use Appropriate Isolation

```crystal
# Serializable for critical financial operations
Grant::Base.transaction(isolation: :serializable) do
  transfer_funds(from, to, amount)
end

# Read committed for reports (better performance)
Grant::Base.transaction(isolation: :read_committed) do
  generate_report
end
```

### 3. Handle Failures Gracefully

```crystal
def process_order(order)
  Grant::Base.transaction do
    order.process!
    Payment.charge!(order)
    Inventory.decrement!(order)
  end
rescue Grant::RecordInvalid => e
  Log.error { "Validation failed: #{e.message}" }
  order.update!(status: "failed")
rescue => e
  Log.error { "Order processing failed: #{e.message}" }
  raise
end
```

### 4. Test Transaction Behavior

```crystal
describe "Transfer funds" do
  it "rolls back on failure" do
    account1 = Account.create!(balance: 100)
    account2 = Account.create!(balance: 50)

    expect_raises(Exception) do
      Grant::Base.transaction do
        account1.balance -= 200  # More than available
        account2.balance += 200
        account1.save!
        account2.save!
        raise "Insufficient funds"
      end
    end

    # Both accounts unchanged
    account1.reload.balance.should eq(100)
    account2.reload.balance.should eq(50)
  end
end
```


---

## Security Features

Canonical page: https://amberframework.org/docs/v2/guides/models/grant/security

# Security Features

> **Supported web path:** Amber CLI `2.0.5` includes Grant in every generated
> web application and pins the reviewed V2 commit. Preserve that pin while
> following this beta.

## Where the examples go

Encrypted attributes, secure-token declarations, signed-ID methods,
normalization, and enums belong inside the matching Grant model under
`src/models/`. Configure encryption in `config/application.cr`; the generated
application entry point loads top-level `config/*` before application source.
Token generation and lookup expressions run from the controller, job, service,
or spec that owns the security flow.
Never put key values in source code or committed environment YAML.

Grant provides built-in security features for protecting sensitive data, generating secure tokens, and creating tamper-proof URLs.

## Encrypted Attributes

Store sensitive data encrypted at rest.

### Basic Encryption

```crystal
class User < Grant::Base
  column id : Int64, primary: true
  column email : String
  column ssn : String?
  column credit_card_number : String?

  # Encrypt these fields
  encrypts :ssn, :credit_card_number
end

# Usage is transparent
user = User.create!(
  email: "alice@example.com",
  ssn: "123-45-6789"
)

user.ssn  # => "123-45-6789" (decrypted)
# In database: encrypted blob
```

### Deterministic Encryption

Use deterministic encryption when you need to search encrypted fields.

```crystal
class User < Grant::Base
  # Non-deterministic (more secure, cannot search)
  encrypts :ssn

  # Deterministic (searchable)
  encrypts :phone_number, deterministic: true
end

# Can search deterministic fields
User.where(phone_number: "+1-555-1234")  # Works

# Cannot search non-deterministic fields
User.where(ssn: "123-45-6789")  # Won't work
```

### Configuration

**File: `config/application.cr` — append this configuration after the Grant
dependency is required.**

```crystal
Grant::Encryption.configure do |config|
  config.primary_key = ENV["ENCRYPTION_PRIMARY_KEY"]
  config.key_derivation_salt = ENV["ENCRYPTION_KEY_DERIVATION_SALT"]
  config.deterministic_key = ENV["ENCRYPTION_DETERMINISTIC_KEY"]
end

# Generate keys
# crystal eval 'require "random"; puts Random::Secure.hex(32)'
```

## Secure Tokens

Generate cryptographically secure tokens for authentication.

### Basic Token Generation

```crystal
class User < Grant::Base
  column id : Int64, primary: true
  column email : String
  column auth_token : String?

  has_secure_token :auth_token
end

user = User.create!(email: "alice@example.com")
user.auth_token  # => "pX27zsMN2ViQKta1bGfLmVJE"

# Regenerate token
user.regenerate_auth_token
```

### Token Options

```crystal
class ApiKey < Grant::Base
  column id : Int64, primary: true
  column user_id : Int64
  column key : String?
  column secret : String?

  # Default: 24 characters, URL-safe base64
  has_secure_token :key

  # Custom length
  has_secure_token :secret, length: 32

  # Hex format
  has_secure_token :hex_key, length: 16, alphabet: :hex
end
```

### Token Authentication

```crystal
class ApplicationController < Amber::Controller::Base
  def authenticate_api_key
    token = request.headers["Authorization"]?
      .try(&.gsub("Bearer ", ""))

    unless token && ApiKey.find_by(key: token)
      halt!(401, "Invalid API key")
    end
  end
end
```

## Signed IDs

Create tamper-proof, expiring identifiers for URLs.

### Basic Signed IDs

```crystal
class User < Grant::Base
  include Grant::SignedId

  column id : Int64, primary: true
  column email : String
end

user = User.find!(1)

# Generate signed ID
signed_id = user.signed_id
# => "eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1RPT0iL..."

# Find by signed ID
found = User.find_signed(signed_id)
# => User(id: 1, email: "alice@example.com")

# Invalid/tampered ID returns nil
User.find_signed("tampered_id")  # => nil
```

### Expiring Signed IDs

```crystal
# Expires in 15 minutes
signed_id = user.signed_id(expires_in: 15.minutes)

# Expires at specific time
signed_id = user.signed_id(expires_at: 1.hour.from_now)

# Expired ID returns nil
User.find_signed(expired_signed_id)  # => nil
```

### Scoped Signed IDs

```crystal
# Scope to specific purpose
signed_id = user.signed_id(purpose: :password_reset)

# Must use same purpose to verify
User.find_signed(signed_id, purpose: :password_reset)  # Works
User.find_signed(signed_id, purpose: :email_confirm)   # => nil
```

### Use Cases

```crystal
class PasswordResetController < ApplicationController
  def create
    user = User.find_by!(email: params["email"])
    token = user.signed_id(
      expires_in: 15.minutes,
      purpose: :password_reset
    )

    PasswordResetMailer.send(user.email, token)
    redirect_to "/login", notice: "Check your email"
  end

  def update
    user = User.find_signed!(
      params["token"],
      purpose: :password_reset
    )

    user.update!(password: params["password"])
    redirect_to "/login", notice: "Password updated"
  rescue Grant::InvalidSignedId
    redirect_to "/forgot-password", alert: "Invalid or expired link"
  end
end
```

## Token Generation (token_for)

Generate purpose-specific tokens that can include record state.

```crystal
class User < Grant::Base
  include Grant::TokenFor

  column id : Int64, primary: true
  column email : String
  column password_salt : String

  # Token invalidates when password_salt changes
  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt
  end

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end
end

# Generate token
user = User.find!(1)
token = user.generate_token_for(:password_reset)

# Find by token
found = User.find_by_token_for(:password_reset, token)

# Token invalidates if password changes
user.update!(password_salt: SecureRandom.hex)
User.find_by_token_for(:password_reset, token)  # => nil
```

## Data Normalization

Automatically normalize data before saving.

```crystal
class User < Grant::Base
  column email : String
  column phone : String?
  column name : String

  # Normalize email
  normalizes :email, &.downcase.strip

  # Normalize name
  normalizes :name, &.strip.titleize

  # Normalize phone (remove non-digits)
  normalizes :phone do |phone|
    phone.gsub(/\D/, "")
  end
end

user = User.new(
  email: "  ALICE@Example.COM  ",
  name: "alice smith",
  phone: "(555) 123-4567"
)

user.email  # => "alice@example.com"
user.name   # => "Alice Smith"
user.phone  # => "5551234567"
```

## Enum Attributes

Type-safe enumerated values.

```crystal
class User < Grant::Base
  column id : Int64, primary: true
  column role : String

  enum Role
    Guest
    Member
    Admin
    SuperAdmin
  end

  enum_attribute role : Role = :member
end

user = User.new
user.role        # => Role::Member
user.member?     # => true
user.admin?      # => false

user.admin!      # Sets role to Admin
user.role        # => Role::Admin

# Scopes generated automatically
User.admin       # Users with admin role
User.member      # Users with member role
```

## Best Practices

### 1. Protect Sensitive Data

```crystal
class User < Grant::Base
  # Always encrypt PII
  encrypts :ssn, :tax_id, :bank_account

  # Deterministic only when searchable needed
  encrypts :phone_number, deterministic: true

  # Never log sensitive data
  @[JSON::Field(ignore: true)]
  column ssn : String?
end
```

### 2. Use Scoped Tokens

```crystal
# Always scope tokens to purpose
signed_id = user.signed_id(purpose: :password_reset)

# Never use generic signed IDs for sensitive operations
```

### 3. Set Appropriate Expiration

```crystal
# Short expiration for sensitive operations
password_reset_token = user.signed_id(
  expires_in: 15.minutes,
  purpose: :password_reset
)

# Longer for less sensitive
email_unsubscribe = user.signed_id(
  expires_in: 30.days,
  purpose: :unsubscribe
)
```

### 4. Rotate Encryption Keys

```crystal
# Support key rotation
Grant::Encryption.configure do |config|
  config.primary_key = ENV["NEW_ENCRYPTION_KEY"]
  config.previous_keys = [ENV["OLD_ENCRYPTION_KEY"]]
end
```


---

## Pipelines

Canonical page: https://amberframework.org/docs/v2/guides/routing/pipelines

# Pipelines

A pipeline is the ordered set of `HTTP::Handler`-compatible pipes applied to a
group of routes. The V2 web template generates this configuration.

**File: `config/routes.cr` — this is the generated baseline. Edit the existing
pipelines in place; do not create a second `Amber::Server.configure` block only
to change their order.**

```crystal
Amber::Server.configure do
  pipeline :web do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new
  end

  pipeline :static do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :web do
    get "/", HomeController, :index
  end

  routes :static do
    get "/*", Amber::Controller::Static, :index
  end
end
```

Order is behavior. `Session` must run before `Flash`, and error handling should
wrap work that can fail. Add authentication, rate limiting, or application
headers deliberately to only the pipelines that need them.

## A protected pipeline

Define a second pipeline when a route group needs additional handling.

**File: `config/routes.cr` — add both the `:admin` pipeline and its route group
inside the existing `Amber::Server.configure` block.**

```crystal
Amber::Server.configure do
  pipeline :admin do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug AuthenticateAdmin.new
    plug Amber::Pipe::CSRF.new
  end

  routes :admin, "/admin" do
    get "/", AdminController, :index
  end
end
```

Custom pipes implement `call(context)` and invoke the next handler when the
request should continue. Put `AuthenticateAdmin` in its own source file, for
example `src/pipes/authenticate_admin.cr`, and require that file from the
application before `config/routes.cr` is compiled. A pipe that finalizes a
response can stop the chain.


---

## Routes

Canonical page: https://amberframework.org/docs/v2/guides/routing/routes

# Routes

Define routes inside `Amber::Server.configure` and attach each group to a named
pipeline.

**File: `config/routes.cr` — add these declarations inside the generated
`Amber::Server.configure` block. Keep the existing `:static` routes.**

```crystal
Amber::Server.configure do
  routes :web do
    get "/posts", PostsController, :index
    get "/posts/:id", PostsController, :show
    post "/posts", PostsController, :create
    patch "/posts/:id", PostsController, :update
    delete "/posts/:id", PostsController, :destroy
  end
end
```

Dynamic segments such as `:id` are available through `params` in the action.
Amber also supports `put`, `options`, `head`, `trace`, and `connect` route
macros.

## Resource routes

`resources` creates conventional routes for `index`, `new`, `create`, `show`,
`edit`, `update`, and `destroy`:

**File: `config/routes.cr` — use these entries inside an existing
`Amber::Server.configure` block, as an alternative to listing every route.**

```crystal
routes :web do
  resources "/posts", PostsController
  resources "/profiles", ProfilesController, only: [:show, :edit, :update]
  resources "/events", EventsController, except: [:destroy]
end
```

Only declare actions implemented by the controller; missing resource actions
fail during compilation.

## Scopes and namespaces

A scope on `routes` prefixes the complete group. Nested `namespace` blocks add
another path segment.

**File: `config/routes.cr` — add this route group inside
`Amber::Server.configure`.**

```crystal
routes :api, "/api" do
  namespace "/v1" do
    resources "/posts", Api::PostsController, only: [:index, :show]
  end
end
```

## Segment constraints

Constrain a dynamic segment with a regular expression when a route must reject
non-matching values.

**File: `config/routes.cr` — add the constrained route inside the existing
`:web` route group.**

```crystal
routes :web do
  get "/orders/:id", OrdersController, :show, {"id" => /\d+/}
end
```

Run `amber routes` from the project root to print the declared route table. Pair
that inspection with request specs and the compiler to verify dispatch behavior.


---

## Schema Basics

Canonical page: https://amberframework.org/docs/v2/guides/schema-api/basics

# Schema Basics

## Where the examples go

Schema classes, fields, nested schemas, inheritance, coercion, transformations,
and validated success/error types belong under `src/schemas/`, grouped by
resource or request flow. Most blocks on this page are fragments to place
inside one of those schema classes, not complete files. Controller validation
calls belong under `src/controllers/`, and their routes belong in
`config/routes.cr`.

A schema declares an input contract: accepted content type, typed fields,
defaults, validation rules, and the value or error type produced after parsing.

## Schema Definition

A schema is a class that inherits from `Amber::Schema::Definition`:

```crystal
class CreateUserSchema < Amber::Schema::Definition
  content_type "application/json"

  field :email, String, required: true, format: :email
  field :name, String, required: true
  field :age, Int32, min: 18

  validates_to UserRequest, UserValidationError
end
```

## Field Types

### Basic Types

```crystal
field :name, String              # String field
field :age, Int32                # Integer field
field :price, Float64            # Float field
field :active, Bool              # Boolean field
field :id, UUID                  # UUID field
field :created_at, Time          # Time field
```

### Collections

```crystal
field :tags, Array(String)                # Array of strings
field :scores, Array(Int32)               # Array of integers
field :metadata, Hash(String, String)     # Hash/dictionary
```

### Nested Objects

```crystal
field :address, AddressSchema             # Single nested object
field :addresses, Array(AddressSchema)    # Array of nested objects
```

## Field Options

### Required Fields

```crystal
field :email, String, required: true    # Must be present
field :nickname, String?                # Optional (can be nil)
field :bio, String                      # Optional by default
```

### Default Values

```crystal
field :role, String, default: "user"
field :active, Bool, default: true
field :page, Int32, default: 1
```

### Field Aliases

Map different input names to your field:

```crystal
field :email, String, as: "user_email"       # JSON: {"user_email": "..."}
field :full_name, String, as: "fullName"     # CamelCase input
```

### Normalization

Transform values before validation:

```crystal
field :email, String,
  normalize: ->(s : String) { s.downcase.strip }

field :phone, String,
  normalize: ->(s : String) { s.gsub(/\D/, "") }

field :tags, Array(String),
  normalize: ->(tags : Array(String)) { tags.map(&.downcase).uniq }
```

## Parameter Sources

Specify where parameters come from:

```crystal
class SearchSchema < Amber::Schema::Definition
  # From URL query string: ?q=search&page=1
  from_query do
    field :q, String, as: :query
    field :page, Int32, default: 1
    field :per_page, Int32, default: 20
  end

  # From URL path: /categories/:category_id/products
  from_path do
    field :category_id, Int32
  end

  # From HTTP headers
  from_header do
    field :api_key, String, key: "X-API-Key"
    field :version, String, key: "X-API-Version", default: "v1"
  end

  # From request body
  from_body do
    field :filters, SearchFilters
  end

  validates_to SearchRequest, SearchValidationError
end
```

## Nested Schemas

Create reusable schemas for nested objects:

```crystal
class AddressSchema < Amber::Schema::Definition
  field :street, String, required: true
  field :city, String, required: true
  field :state, String, required: true, length: 2
  field :zip, String, required: true, format: /^\d{5}(-\d{4})?$/

  validates_to Address, AddressValidationError
end

class UserSchema < Amber::Schema::Definition
  field :name, String, required: true
  field :email, String, required: true, format: :email

  # Single nested object
  field :primary_address, AddressSchema

  # Array of nested objects
  field :addresses, Array(AddressSchema), max_items: 5

  validates_to User, UserValidationError
end
```

## Schema Inheritance

Share common fields across schemas:

```crystal
# Base schema with common fields
abstract class BaseUserSchema < Amber::Schema::Definition
  field :email, String, required: true, format: :email
  field :name, String, required: true
end

# Registration adds password
class RegistrationSchema < BaseUserSchema
  field :password, String, required: true, min_length: 8
  field :password_confirmation, String, required: true
  field :terms_accepted, Bool, required: true

  validate :password_matches
  validates_to NewUser, RegistrationError
end

# Update doesn't require password
class UpdateUserSchema < BaseUserSchema
  field :bio, String, max_length: 500
  field :avatar_url, String, format: :url

  validates_to UserUpdate, UpdateError
end
```

## Type Coercion

The schema system automatically converts string inputs:

```crystal
# Input: {"age": "25", "active": "true", "price": "19.99"}
class ProductSchema < Amber::Schema::Definition
  field :age, Int32        # "25" -> 25
  field :active, Bool      # "true" -> true
  field :price, Float64    # "19.99" -> 19.99
end
```

### Custom Coercion

```crystal
class DateRangeSchema < Amber::Schema::Definition
  field :start_date, Time,
    coerce: ->(s : String) { Time.parse(s, "%Y-%m-%d", Time::Location::UTC) }

  field :status, Status,
    coerce: ->(s : String) { Status.parse(s) }
end
```

## State-Based Types

Schemas validate to specific success and failure types:

```crystal
# Success type - immutable, validated data
class UserRequest < Amber::Schema::ValidatedRequest
  getter email : String
  getter name : String
  getter age : Int32

  # Computed properties
  def adult? : Bool
    age >= 18
  end
end

# Failure type - contains validation errors
class UserValidationError < Amber::Schema::ValidationError
  def to_response
    {
      message: "User validation failed",
      errors: errors,
      fields: errors.keys
    }
  end
end
```

## Transformations

Apply transformations after validation:

```crystal
class RegistrationSchema < Amber::Schema::Definition
  field :first_name, String, required: true
  field :last_name, String, required: true
  field :email, String, required: true

  # Add computed fields after validation
  transform do |data|
    data.full_name = "#{data.first_name} #{data.last_name}"
    data.username = data.email.split("@").first
  end

  validates_to Registration, RegistrationError
end
```

## Documentation Metadata

Add documentation for API generation:

```crystal
class APISchema < Amber::Schema::Definition
  description "Creates a new user account"

  field :email, String,
    required: true,
    format: :email,
    description: "User's email address",
    example: "user@example.com"

  field :role, String,
    enum: ["admin", "user", "guest"],
    default: "user",
    description: "User's role in the system"
end
```


---

## Validation

Canonical page: https://amberframework.org/docs/v2/guides/schema-api/validation

# Validation

## Where the examples go

Built-in validation options, conditions, custom validator methods, validator
classes, contexts, and messages belong under `src/schemas/`. Most blocks on
this page are fragments to place inside the schema class they describe. Calls
that validate a request and serialize errors belong in the receiving controller
under `src/controllers/`, with its route in `config/routes.cr`.

Schema fields can enforce presence, length, format, numeric bounds, and custom
rules before application code receives a typed value.

## Built-in Validators

### Required

```crystal
field :email, String, required: true
field :age, Int32, required: true
field :bio, String?  # Optional by default
```

### String Validators

#### Length

```crystal
field :username, String, min_length: 3, max_length: 20
field :password, String, min_length: 8
field :bio, String, max_length: 500
field :zip_code, String, length: 5  # Exact length
```

#### Format

```crystal
field :email, String, format: :email
field :url, String, format: :url
field :phone, String, format: :phone_number
field :ssn, String, format: /^\d{3}-\d{2}-\d{4}$/  # Custom regex
```

#### Predefined Formats

```crystal
:email          # Valid email address
:url            # Valid URL (http/https)
:uri            # Valid URI
:uuid           # Valid UUID v4
:phone_number   # International phone format
:ip_address     # IPv4 or IPv6
:ipv4           # IPv4 only
:ipv6           # IPv6 only
:credit_card    # Credit card number (Luhn check)
:slug           # URL-safe slug
:alpha          # Letters only
:numeric        # Numbers only
:alphanumeric   # Letters and numbers
```

### Numeric Validators

```crystal
field :age, Int32, min: 18, max: 120
field :price, Float64, min: 0.01, max: 999999.99
field :quantity, Int32, min: 1
field :percentage, Float64, min: 0.0, max: 100.0
```

### Enum Validators

```crystal
field :status, String, enum: ["active", "inactive", "pending"]
field :role, String, enum: UserRoles::ALL
field :priority, Int32, enum: [1, 2, 3, 4, 5]
```

### Array Validators

```crystal
field :tags, Array(String), min_items: 1, max_items: 10
field :categories, Array(Int32), unique: true
field :emails, Array(String), each: {format: :email}
```

## Conditional Validations

### When Field Has Value

```crystal
class OrderSchema < Amber::Schema::Definition
  field :payment_method, String, enum: ["card", "paypal", "bitcoin"]

  # Only validate card fields when payment is "card"
  when_field :payment_method, "card" do
    field :card_number, String, required: true, format: :credit_card
    field :cvv, String, required: true, length: 3..4
    field :expiry, String, required: true, format: /^\d{2}\/\d{2}$/
  end

  when_field :payment_method, "paypal" do
    field :paypal_email, String, required: true, format: :email
  end
end
```

### When Field Present

```crystal
when_present :coupon_code do
  validate :valid_coupon
  validate :not_expired
end
```

### Field Dependencies

```crystal
# All must be present together
requires_together :address, :city, :state, :zip

# Exactly one must be present
requires_one_of :email, :phone, :username

# At least one must be present
requires_any_of :home_phone, :work_phone, :mobile_phone
```

## Custom Validators

### Instance Method Validators

```crystal
class RegistrationSchema < Amber::Schema::Definition
  field :password, String, required: true, min_length: 8
  field :password_confirmation, String, required: true
  field :age, Int32, required: true

  validate :password_matches
  validate :age_appropriate

  private def password_matches
    if password != password_confirmation
      errors.add(:password_confirmation, "doesn't match password")
    end
  end

  private def age_appropriate
    if age < 13
      errors.add(:age, "must be 13 or older")
    elsif age < 18
      warnings.add(:age, "parental consent required")
    end
  end
end
```

### Validator Classes

Create reusable validators:

```crystal
class EmailUniquenessValidator < Amber::Schema::Validator
  def validate(value : String, field : Field, schema : Schema)
    if User.exists?(email: value)
      schema.errors.add(field.name, "is already taken")
    end
  end
end

class SignupSchema < Amber::Schema::Definition
  field :email, String, required: true, format: :email,
        validator: EmailUniquenessValidator.new
end
```

## Validation Contexts

Run different validations based on context:

```crystal
class UserSchema < Amber::Schema::Definition
  field :email, String, required: true, format: :email
  field :password, String, required: true, min_length: 8, on: :create
  field :current_password, String, required: true, on: :update

  validate :password_complexity, on: :create
  validate :current_password_correct, on: :update
  validate :email_domain_allowed  # Runs in all contexts
end

# Usage
schema = UserSchema.new(data, context: :create)
schema = UserSchema.new(data, context: :update)
```

## Custom Error Messages

```crystal
field :age, Int32,
      required: {message: "is required for registration"},
      min: {value: 18, message: "must be 18 or older to register"}

field :email, String,
      format: {value: :email, message: "doesn't look like a valid email"}
```

## Error Handling

### Error Response Formatting

```crystal
class ValidationErrorResponse < Amber::Schema::Response
  def initialize(error : Amber::Schema::ValidationError)
    @errors = error.errors
    @message = "Validation failed"
  end

  def to_json
    {
      message: @message,
      errors: @errors,
      error_code: "VALIDATION_ERROR"
    }.to_json
  end
end
```

### In Controller

```crystal
def create
  case result = CreateUserSchema.validate(request)
  when Amber::Schema::Success
    user = User.create!(result.data)
    respond_with 201, user.to_json
  when Amber::Schema::Failure
    respond_with 400, {
      message: "Validation failed",
      errors: result.error.errors
    }.to_json
  end
end
```

## Validation Flow

The validation process follows this order:

1. **Parse** - Extract data from request based on content type
2. **Coerce** - Convert string values to proper types
3. **Validate** - Run all validators in order
4. **Transform** - Apply any transformations
5. **Return** - Success with typed data or Failure with errors


---

## Parsers

Canonical page: https://amberframework.org/docs/v2/guides/schema-api/parsers

# Parsers

## Where the examples go

Parser and field declarations belong inside schema classes under
`src/schemas/`. Blocks labeled as example requests are HTTP request bodies, not
source files. Content negotiation belongs in the receiving controller under
`src/controllers/`, and the endpoint belongs in `config/routes.cr`. Multipart
file handling must also follow the application's upload-validation boundary.

Select a parser through the schema's content type. Amber provides explicit
parsers for the formats listed below.

## Supported Content Types

- `application/json` - JSON data
- `application/xml` - XML documents
- `application/x-www-form-urlencoded` - Form data
- `multipart/form-data` - File uploads and forms
- `text/csv` - CSV bulk operations
- `application/x-protobuf` - Protocol Buffers
- `application/msgpack` - MessagePack

## JSON Parser

The most common format for APIs:

```crystal
class CreateOrderSchema < Amber::Schema::Definition
  content_type "application/json"

  field :items, Array(OrderItemSchema), required: true
  field :shipping_address, AddressSchema
  field :billing_address, AddressSchema
  field :same_as_shipping, Bool, default: false

  validates_to OrderRequest, OrderValidationError
end
```

Example request:

```json
{
  "items": [
    {"product_id": 1, "quantity": 2},
    {"product_id": 3, "quantity": 1}
  ],
  "shipping_address": {
    "street": "123 Main St",
    "city": "Springfield",
    "zip": "12345"
  },
  "same_as_shipping": true
}
```

## XML Parser

For SOAP APIs or XML-based integrations:

```crystal
class CreateOrderXMLSchema < Amber::Schema::Definition
  content_type "application/xml"

  field :items, Array(OrderItemSchema), xpath: "//order/items/item"
  field :shipping_address, AddressSchema, xpath: "//order/shipping"
  field :billing_address, AddressSchema, xpath: "//order/billing"
  field :same_as_shipping, Bool, xpath: "//order/@sameAsShipping"

  validates_to OrderRequest, OrderValidationError
end
```

Example request:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<order sameAsShipping="true">
  <items>
    <item>
      <product_id>1</product_id>
      <quantity>2</quantity>
    </item>
  </items>
  <shipping>
    <street>123 Main St</street>
    <city>Springfield</city>
  </shipping>
</order>
```

## Form Parser

For traditional HTML forms:

```crystal
class CreateOrderFormSchema < Amber::Schema::Definition
  content_type "application/x-www-form-urlencoded"

  # Arrays use bracket notation: item_ids[]=1&item_ids[]=2
  field :item_ids, Array(Int32), repeated: true
  field :item_quantities, Array(Int32), repeated: true

  # Nested objects use bracket notation
  field :shipping_street, String, as: "shipping[street]"
  field :shipping_city, String, as: "shipping[city]"
  field :shipping_zip, String, as: "shipping[zip]"

  validates_to OrderRequest, OrderValidationError

  # Transform flat form data to nested structure
  def transform
    items = item_ids.zip(item_quantities).map do |id, qty|
      OrderItem.new(product_id: id, quantity: qty)
    end

    self.items = items
    self.shipping_address = Address.new(
      street: shipping_street,
      city: shipping_city,
      zip: shipping_zip
    )
  end
end
```

## Multipart Parser

For file uploads:

```crystal
class UploadSchema < Amber::Schema::Definition
  content_type "multipart/form-data"

  field :title, String, required: true
  field :description, String
  field :file, Amber::Schema::UploadedFile, required: true

  # File validation
  validates :file do
    max_size 10.megabytes
    allowed_types ["image/jpeg", "image/png", "application/pdf"]
  end

  validates_to UploadRequest, UploadValidationError
end
```

### Multiple Files

```crystal
class GalleryUploadSchema < Amber::Schema::Definition
  content_type "multipart/form-data"

  field :album_name, String, required: true
  field :images, Array(Amber::Schema::UploadedFile), max_items: 20

  validates :images do
    each do
      max_size 5.megabytes
      allowed_types ["image/jpeg", "image/png", "image/webp"]
    end
  end
end
```

## CSV Parser

For bulk operations:

```crystal
class BulkImportSchema < Amber::Schema::Definition
  content_type "text/csv"

  # Define expected columns
  csv_columns do
    column :email, String, required: true, format: :email
    column :name, String, required: true
    column :role, String, enum: ["admin", "user"]
  end

  # Row validation
  max_rows 1000
  skip_invalid_rows false

  validates_to BulkImportRequest, BulkImportError
end
```

## Multiple Content Types

Support multiple formats for the same endpoint:

```crystal
class CreateUserController < ApplicationController
  # Select schema based on content type
  SCHEMAS = {
    "application/json" => CreateUserJSONSchema,
    "application/xml" => CreateUserXMLSchema,
    "application/x-www-form-urlencoded" => CreateUserFormSchema
  }

  def create
    content_type = request.headers["Content-Type"]
    schema_class = SCHEMAS[content_type]?

    unless schema_class
      return respond_with 415, {error: "Unsupported content type"}.to_json
    end

    case result = schema_class.validate(request)
    when Amber::Schema::Success
      user = User.create!(result.data)
      respond_with 201, user.to_json
    when Amber::Schema::Failure
      respond_with 400, result.error.to_response.to_json
    end
  end
end
```

## Content Negotiation

Automatic schema selection:

```crystal
class UserSchema < Amber::Schema::Definition
  # Define multiple content types
  accepts "application/json", "application/xml", "application/x-www-form-urlencoded"

  field :email, String, required: true
  field :name, String, required: true

  validates_to UserRequest, UserValidationError
end
```

The parser will automatically handle the request based on the `Content-Type` header.


---

## OpenAPI Generation

Canonical page: https://amberframework.org/docs/v2/guides/schema-api/openapi

# OpenAPI Generation

## Where the examples go

- OpenAPI metadata belongs beside each schema under `src/schemas/`.
- Application-wide OpenAPI configuration belongs in `config/application.cr`;
  the generated entry point loads top-level `config/*` before application
  source.
- Endpoint declarations belong in `config/routes.cr`; response code belongs in
  the named controller under `src/controllers/`.
- Generated specifications belong under `public/` only when the application
  intentionally serves them as static files.

Blocks on this page use those destinations unless a closer label says
otherwise.

The Schema API can automatically generate OpenAPI (Swagger) specifications from your schema definitions.

## Basic OpenAPI Metadata

Add OpenAPI metadata to your schemas:

```crystal
class CreateUserSchema < Amber::Schema::Definition
  openapi do
    operation_id "createUser"
    tags ["Users", "Registration"]
    summary "Create a new user account"
    description "Creates a new user with the provided information"

    responses do
      success 201, "User created successfully"
      error 400, "Invalid request data"
      error 409, "Email already exists"
    end
  end

  field :email, String,
    required: true,
    format: :email,
    description: "User's email address",
    example: "user@example.com"

  field :name, String,
    required: true,
    description: "User's full name",
    example: "John Doe"

  field :role, String,
    enum: ["admin", "user", "guest"],
    default: "user",
    description: "User's role in the system"

  validates_to UserRequest, UserValidationError
end
```

## Field Documentation

Document each field for the API spec:

```crystal
field :email, String,
  required: true,
  format: :email,
  description: "User's email address",
  example: "user@example.com",
  deprecated: false

field :password, String,
  required: true,
  min_length: 8,
  description: "User's password (min 8 characters)",
  example: "securepassword123",
  write_only: true  # Won't appear in response schemas
```

## Generating the Spec

Generate the OpenAPI specification:

**File: `config/application.cr` — append this setup after `require "amber"`, or
call the generation portion from a dedicated build task if production has a
read-only filesystem.**

```crystal
OpenAPI.configure do |config|
  config.title = "My API"
  config.version = "2.0.0"
  config.description = "API documentation for My Application"

  config.servers = [
    {url: "https://api.example.com", description: "Production"},
    {url: "https://staging-api.example.com", description: "Staging"}
  ]

  config.contact = {
    name: "API Support",
    email: "support@example.com"
  }
end

# Generate spec
spec = OpenAPI.generate_from_schemas([
  CreateUserSchema,
  UpdateUserSchema,
  ListUsersSchema
])

File.write("public/openapi.json", spec.to_json)
```

## Route Integration

Connect schemas to routes:

```crystal
# config/routes.cr
routes :api do
  post "/users", UsersController, :create,
    schema: CreateUserSchema,
    response_schema: UserResponseSchema

  get "/users/:id", UsersController, :show,
    schema: GetUserSchema,
    response_schema: UserResponseSchema
end
```

## Response Schemas

Define response schemas:

```crystal
class UserResponseSchema < Amber::Schema::Response
  field :id, Int64
  field :email, String
  field :name, String
  field :role, String
  field :created_at, Time

  openapi do
    description "User object response"
  end
end

class ErrorResponseSchema < Amber::Schema::Response
  field :message, String
  field :errors, Hash(String, Array(String))
  field :error_code, String

  openapi do
    description "Error response with validation details"
  end
end
```

## Security Definitions

Define authentication schemes:

```crystal
OpenAPI.configure do |config|
  config.security_schemes = {
    "bearerAuth" => {
      type: "http",
      scheme: "bearer",
      bearer_format: "JWT"
    },
    "apiKey" => {
      type: "apiKey",
      in: "header",
      name: "X-API-Key"
    }
  }
end

# Apply to schema
class ProtectedSchema < Amber::Schema::Definition
  openapi do
    security ["bearerAuth"]
  end

  # ...fields
end
```

## Serving the Spec

Serve the OpenAPI spec and Swagger UI:

```crystal
# config/routes.cr
routes :api do
  # OpenAPI JSON spec
  get "/openapi.json", OpenAPIController, :spec

  # Swagger UI (if using swagger-ui assets)
  get "/docs", OpenAPIController, :swagger_ui
end
```

```crystal
# src/controllers/openapi_controller.cr
class OpenAPIController < ApplicationController
  def spec
    spec = OpenAPI.generate
    respond_with 200, spec.to_json, "application/json"
  end

  def swagger_ui
    render "openapi/swagger_ui.ecr"
  end
end
```

## Example Generated Spec

The generated OpenAPI spec looks like:

```json
{
  "openapi": "3.0.3",
  "info": {
    "title": "My API",
    "version": "2.0.0"
  },
  "paths": {
    "/users": {
      "post": {
        "operationId": "createUser",
        "tags": ["Users", "Registration"],
        "summary": "Create a new user account",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreateUser"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "User created successfully"
          },
          "400": {
            "description": "Invalid request data"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "CreateUser": {
        "type": "object",
        "required": ["email", "name"],
        "properties": {
          "email": {
            "type": "string",
            "format": "email",
            "description": "User's email address",
            "example": "user@example.com"
          },
          "name": {
            "type": "string",
            "description": "User's full name",
            "example": "John Doe"
          },
          "role": {
            "type": "string",
            "enum": ["admin", "user", "guest"],
            "default": "user"
          }
        }
      }
    }
  }
}
```


---

## System Tests

Canonical page: https://amberframework.org/docs/v2/guides/testing/system-tests

# System Tests

**Setting Up System Specs**

We have made it as simple as possible to have your system specs. Before running your specs ensure you have installed the `chromedriver` and that `selenium-server standalone` is in your system path.

**Mac OS**

You can install the chromedriver and selenium standalone server with `brew`

```bash
brew install selenium-server-standalone
brew install chromedriver
```

This will install the chrome driver on the system path `/usr/local/bin/chromedriver`

If you're running in a different OS such as Linux you can specify the chromedriver path as such

```crystal
module GarnetSpec
  DRIVER = :chrome
  PATH = "/usr/local/bin/chromedriver"
end
```

System tests allows test user interactions with your application, running tests in either a real chrome browser. System tests use the Selenium Standalone Server.

For creating Amber system tests, you use the spec/system directory in your application. Here's how a system test looks like:

```crystal
class SomeFeature < GarnetSpec::System::Test
  scenario "user visits amber framework and sees getting started button" do
    visit "http://www.amberframework.org"
    timeout 1000
    click_on(:css, "header a.btn.btn-primary")
    wait 2000
    element(:tag_name, "body").text.should contain "Introduction"
  end

  scenario "user visits amberframwork homepage and sees logo" do
    visit "http://www.amberframework.org"
    wait 2000
    element(:class_name, "img-amber-logo").attribute("src").should match(
      %r(https://www.amberframework.org/assets/img/amber-logo-t-bg.png)
    )
  end
end
```

Run your specs with `crystal spec`

{% hint style="warning" %}
System Test currently only work with the Chrome Browser
{% endhint %}


---

## File Attachments

Canonical page: https://amberframework.org/docs/v2/guides/uploads/attachments

# File Attachments

> **Preview ecosystem guide:** Gemma is not part of the Amber 2.0.0-beta.4
> core web-app release gate. Its package version, API, and platform support may
> change independently. Confirm a compatible official release before adding it
> to an application.

## Where the examples go

Attachment declarations, lifecycle callbacks, and uploader selection belong in
the matching Grant model under `src/models/`. Upload assignment and direct
upload handling belong in the receiving controller under `src/controllers/`.
Form and display markup belongs in the matching ECR files under `src/views/`.
Reusable uploader classes belong under `src/uploaders/`; direct storage work
belongs in a job or service with focused specs.

Gemma's `Attachable` module adds single- and multiple-file attachment declarations
to Grant models.

## Setup

Include the `Attachable` module in your Grant model:

```crystal
require "gemma/grant"

class User < Grant::Base
  include Gemma::Grant::Attachable

  column id : Int64, primary: true
  column name : String

  # Column to store attachment metadata (JSON)
  column avatar_data : JSON::Any?

  # Declare the attachment
  has_one_attached :avatar
end
```

## Single File Attachments

### Declaration

Use `has_one_attached` to attach a single file:

```crystal
class User < Grant::Base
  include Gemma::Grant::Attachable

  column id : Int64, primary: true
  column profile_picture_data : JSON::Any?
  column resume_data : JSON::Any?

  has_one_attached :profile_picture
  has_one_attached :resume
end
```

The column name must be `{attachment_name}_data` with type `JSON::Any?`.

### Attaching Files

```crystal
# From IO object
user.avatar = File.open("avatar.jpg")

# From uploaded file in controller
user.avatar = params.files["avatar"].file

# Clear attachment
user.avatar = nil
```

### Accessing Attachments

```crystal
# Get the UploadedFile object
file = user.avatar

# Check if attached
if user.avatar
  puts "Avatar attached!"
end

# Get URL
url = user.avatar_url

# With URL options
url = user.avatar_url(host: "https://cdn.example.com")

# Check if changed (before save)
user.avatar_changed?  # => true/false
```

### File Metadata

```crystal
file = user.avatar

file.id                # Unique identifier
file.original_filename # Original upload name
file.extension         # File extension
file.size              # Size in bytes
file.mime_type         # MIME type
file.metadata          # All metadata hash
```

### Working with File Content

```crystal
# Open for reading
user.avatar.open do |io|
  content = io.gets_to_end
end

# Download to tempfile
user.avatar.download do |tempfile|
  # tempfile is a File object
  system("convert", tempfile.path, "thumbnail.jpg")
end

# Stream to destination
io = IO::Memory.new
user.avatar.stream(io)
```

## Multiple File Attachments

### Declaration

Use `has_many_attached` for multiple files:

```crystal
class Post < Grant::Base
  include Gemma::Grant::Attachable

  column id : Int64, primary: true
  column title : String
  column images_data : JSON::Any?
  column attachments_data : JSON::Any?

  has_many_attached :images
  has_many_attached :attachments
end
```

### Attaching Multiple Files

```crystal
# Replace all files
post.images = [
  File.open("photo1.jpg"),
  File.open("photo2.jpg"),
  File.open("photo3.jpg")
]

# From controller with multiple file upload
post.images = params.files.select { |f| f.field == "images" }.map(&.file)
```

### Managing Collections

```crystal
# Get all files (Array of UploadedFile)
files = post.images

# Iterate
post.images.each do |image|
  puts image.url
end

# Count
post.images.size

# Add single file (singular form of attachment name)
post.add_image(File.open("new_photo.jpg"))

# Remove specific file
post.remove_image(post.images.first)

# Clear all files
post.clear_images

# Check if changed
post.images_changed?
```

## Lifecycle Callbacks

Gemma automatically hooks into Grant's lifecycle:

```crystal
class Document < Grant::Base
  include Gemma::Grant::Attachable

  column file_data : JSON::Any?
  has_one_attached :file

  # Gemma registers these automatically:
  # before_save  - promotes cached files to store
  # after_save   - persists attachment data
  # after_destroy - cleans up attached files
end
```

### Custom Processing

Add your own callbacks for additional processing:

```crystal
class Photo < Grant::Base
  include Gemma::Grant::Attachable

  column image_data : JSON::Any?
  column thumbnail_data : JSON::Any?

  has_one_attached :image
  has_one_attached :thumbnail

  after_save :generate_thumbnail

  private def generate_thumbnail
    return unless image && image_changed?

    image.download do |tempfile|
      # Generate thumbnail using ImageMagick
      thumb_path = "/tmp/thumb_#{id}.jpg"
      system("convert", tempfile.path, "-thumbnail", "100x100^", thumb_path)

      self.thumbnail = File.open(thumb_path)
      save! if thumbnail_changed?

      File.delete(thumb_path)
    end
  end
end
```

## Custom Uploaders

Create custom uploaders for specialized behavior:

```crystal
class AvatarUploader < Gemma
  # Custom file location
  def generate_location(io, metadata, context, **options)
    user = context[:model]
    filename = metadata["filename"]? || "avatar"
    extension = File.extname(filename)

    "users/#{user.id}/avatar#{extension}"
  end
end

class User < Grant::Base
  include Gemma::Grant::Attachable

  column avatar_data : JSON::Any?

  # Use custom uploader
  has_one_attached :avatar, uploader: AvatarUploader
end
```

### Uploader with Plugins

```crystal
require "gemma/plugins/determine_mime_type"
require "gemma/plugins/store_dimensions"

class ImageUploader < Gemma
  load_plugin(
    Gemma::Plugins::DetermineMimeType,
    analyzer: Gemma::Plugins::DetermineMimeType::Tools::File
  )

  load_plugin(
    Gemma::Plugins::StoreDimensions,
    analyzer: Gemma::Plugins::StoreDimensions::Tools::FastImage
  )

  finalize_plugins!
end

# Now metadata includes width/height
image.metadata["width"]   # => 1920
image.metadata["height"]  # => 1080
image.metadata["mime_type"]  # => "image/jpeg"
```

## Form Integration

### ECR Template

```erb
<form action="/users" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="avatar">Avatar</label>
    <input type="file" name="avatar" id="avatar" accept="image/*">
  </div>

  <% if @user.avatar %>
    <div class="current-avatar">
      <img src="<%= @user.avatar_url %>" alt="Current avatar">
      <label>
        <input type="checkbox" name="remove_avatar" value="1">
        Remove avatar
      </label>
    </div>
  <% end %>

  <button type="submit">Save</button>
</form>
```

### Controller Handling

```crystal
class UsersController < ApplicationController
  def update
    user = User.find!(params["id"])

    # Handle file upload
    if file = params.files["avatar"]?
      user.avatar = file.file
    end

    # Handle removal
    if params["remove_avatar"]? == "1"
      user.avatar = nil
    end

    if user.save
      redirect_to "/users/#{user.id}"
    else
      render "users/edit.ecr"
    end
  end
end
```

## Direct Uploads

For large files, upload directly to storage:

```crystal
# Controller
def presign
  # Generate presigned URL for direct S3 upload
  storage = Gemma.find_storage("cache").as(Gemma::Storage::S3)

  # Return presigned URL to client
  json({
    url:    storage.presigned_url(key),
    fields: storage.presigned_fields(key)
  })
end

def create
  user = User.new(user_params)

  # Accept cached file data from client
  if cached_data = params["avatar_data"]?
    user.avatar = JSON.parse(cached_data).as_h
  end

  user.save
end
```

## Best Practices

### 1. Always Use `JSON::Any?` Column Type

```crystal
# Correct
column avatar_data : JSON::Any?

# Wrong - will fail
column avatar_data : String?
```

### 2. Check for Attachment Before Accessing URL

```crystal
# Safe
url = user.avatar_url if user.avatar

# Or use the helper that returns nil
url = user.avatar_url  # => nil if no attachment
```

### 3. Clean Up Orphaned Files

```crystal
# Files are automatically deleted on destroy
user.destroy  # Avatar file is deleted

# For manual cleanup
user.avatar.try(&.delete)
user.update!(avatar_data: nil)
```

### 4. Use Appropriate Storage per Environment

```crystal
Gemma.configure do |config|
  if ENV["AMBER_ENV"] == "production"
    config.storages["store"] = Gemma::Storage::S3.new(...)
  else
    config.storages["store"] = Gemma::Storage::FileSystem.new("uploads")
  end
end
```


---

## Storage Backends

Canonical page: https://amberframework.org/docs/v2/guides/uploads/storage

# Storage Backends

> **Preview ecosystem guide:** Gemma is not part of the Amber 2.0.0-beta.4
> core web-app release gate. Its package version, API, and platform support may
> change independently. Confirm a compatible official release before adding it
> to an application.

Gemma supports multiple storage backends for flexibility across different environments. All storages implement the same interface, allowing you to switch backends without changing application code.

These are runtime uploads, not application assets. Logos, stylesheets,
JavaScript, fonts, and other release-owned files belong in [Asset
Pipeline](../assets/) and its build manifest. Never run user-controlled uploads
through an asset build or cache them under an immutable authored-asset URL.

## Where the examples go

Storage construction and Gemma-wide configuration belong in
`config/uploads.cr`. The generated application entry point loads top-level
`config/*` files before application source. Direct upload, URL, and metadata
operations belong in the controller, job, service, or spec that owns the file
operation. Test-only memory storage belongs in `spec/spec_helper.cr`. Directory
trees on this page describe runtime output, not source files to create by hand.

## Configuration

**File: `config/uploads.cr` — create this setup. Keep one `Gemma.configure`
block and extend it as storage needs grow.**

```crystal
require "gemma"

Gemma.configure do |config|
  # Temporary storage (for uploads in progress)
  config.storages["cache"] = Gemma::Storage::FileSystem.new(
    "uploads",
    prefix: "cache"
  )

  # Permanent storage
  config.storages["store"] = Gemma::Storage::FileSystem.new("uploads")
end
```

**File: the application entry point, for example `src/my_app.cr` — retain
`require "../config/*"` before controllers and models.** If a migrated app does
not use that generated wildcard, explicitly require `../config/uploads`.

## FileSystem Storage

Store files on the local filesystem for development or a deliberately
single-host deployment with a persistent mounted disk, backups, and an explicit
delivery route. A container's writable layer and a release directory replaced
during deployment are not durable upload storage.

### Basic Configuration

```crystal
Gemma::Storage::FileSystem.new(
  "uploads"  # Base directory
)
```

### Full Configuration

```crystal
Gemma::Storage::FileSystem.new(
  "uploads",                    # Base directory
  prefix: "attachments",        # Subdirectory prefix
  permissions: 0o644,           # File permissions (default)
  directory_permissions: 0o755, # Directory permissions (default)
  clean: true                   # Auto-clean empty directories (default)
)
```

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `directory` | String | Required | Base directory for file storage |
| `prefix` | String? | `nil` | Subdirectory within base directory |
| `permissions` | Int | `0o644` | UNIX permissions for files |
| `directory_permissions` | Int | `0o755` | UNIX permissions for directories |
| `clean` | Bool | `true` | Remove empty parent directories on delete |

### URL Generation

The filesystem directory and the browser URL are separate configuration
decisions. Project-root `uploads/` is private by default because Amber's
generated static route serves only `public/`. The following public-directory
example is appropriate only for uploads that are intentionally public and have
already passed validation:

```crystal
storage = Gemma::Storage::FileSystem.new("public/uploads", prefix: "files")

# URLs are relative paths
storage.url("abc123.jpg")
# => "/files/abc123.jpg"

# With host
storage.url("abc123.jpg", host: "https://cdn.example.com")
# => "https://cdn.example.com/files/abc123.jpg"
```

Request the returned URL in a deployment smoke test. If it does not correspond
to the configured Amber route, use an authenticated download action or the
storage backend's own URL instead of guessing a prefix.

### Directory Structure

```
uploads/                  # private, persistent runtime storage
├── cache/                # temporary files (prefix: "cache")
│   └── abc123.jpg
└── store/                # permanent files (prefix: "store")
    └── def456.pdf
```

Do not place the temporary cache under `public/`. If permanent uploads are
public, use an unpredictable immutable key or an authorization layer; never
trust the original filename as a safe path.

## S3 Storage

Store files in Amazon S3 or S3-compatible services (DigitalOcean Spaces, MinIO, etc.).

### Basic Configuration

```crystal
require "gemma"

client = Awscr::S3::Client.new(
  region: "us-east-1",
  aws_access_key: ENV["AWS_ACCESS_KEY_ID"],
  aws_secret_key: ENV["AWS_SECRET_ACCESS_KEY"]
)

Gemma::Storage::S3.new(
  bucket: "my-app-uploads",
  client: client
)
```

### Full Configuration

```crystal
storage = Gemma::Storage::S3.new(
  bucket: "my-app-uploads",
  client: client,
  prefix: "attachments",        # Key prefix in bucket
  public: false,                # Set public ACL on upload
  upload_options: {             # Default upload options
    "x-amz-acl" => "private",
    "Cache-Control" => "private, no-store"
  }
)
```

For a genuinely public object whose key changes with its contents, a long
`public, max-age=31536000, immutable` policy can be appropriate. Mutable object
keys need short revalidation. Private and presigned objects need a policy
appropriate to their access controls; do not copy the authored-asset cache
policy blindly.

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `bucket` | String | Required | S3 bucket name |
| `client` | Awscr::S3::Client | Required | S3 client instance |
| `prefix` | String? | `nil` | Key prefix for all objects |
| `public` | Bool | `false` | Make uploads publicly readable |
| `upload_options` | Hash | `{}` | Default headers for uploads |

### S3-Compatible Services

#### DigitalOcean Spaces

```crystal
client = Awscr::S3::Client.new(
  region: "nyc3",
  aws_access_key: ENV["SPACES_ACCESS_KEY"],
  aws_secret_key: ENV["SPACES_SECRET_KEY"],
  endpoint: "https://nyc3.digitaloceanspaces.com"
)

storage = Gemma::Storage::S3.new(
  bucket: "my-space",
  client: client,
  public: true  # Spaces URLs are typically public
)
```

#### MinIO

```crystal
client = Awscr::S3::Client.new(
  region: "us-east-1",
  aws_access_key: ENV["MINIO_ACCESS_KEY"],
  aws_secret_key: ENV["MINIO_SECRET_KEY"],
  endpoint: "http://localhost:9000"
)

storage = Gemma::Storage::S3.new(
  bucket: "uploads",
  client: client
)
```

### URL Generation

S3 storage generates presigned URLs:

```crystal
# Presigned URL (default, time-limited)
storage.url("abc123.jpg")
# => "https://bucket.s3.amazonaws.com/abc123.jpg?X-Amz-..."

# For public buckets, you may want direct URLs
# Configure your application to generate these
```

### Public Access

```crystal
# Make all uploads public
storage = Gemma::Storage::S3.new(
  bucket: "public-assets",
  client: client,
  public: true  # Sets x-amz-acl: public-read
)

# Or per-upload via upload_options
storage.upload(file, "key", upload_options: {"x-amz-acl" => "public-read"})
```

## Memory Storage

In-memory storage for testing. Files are not persisted.

```crystal
Gemma::Storage::Memory.new
```

### Testing Configuration

```crystal
# spec/spec_helper.cr
Gemma.configure do |config|
  config.storages["cache"] = Gemma::Storage::Memory.new
  config.storages["store"] = Gemma::Storage::Memory.new
end
```

## Environment-Based Configuration

Configure different storages per environment:

**File: `config/uploads.cr` — replace the earlier `Gemma.configure` block
with this environment-aware version; do not define both.**

```crystal
require "gemma"

Gemma.configure do |config|
  # Cache storage (same for all environments)
  config.storages["cache"] = Gemma::Storage::FileSystem.new(
    "uploads",
    prefix: "cache"
  )

  # Store storage (varies by environment)
  case ENV["AMBER_ENV"]?
  when "production"
    client = Awscr::S3::Client.new(
      region: ENV["AWS_REGION"],
      aws_access_key: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )

    config.storages["store"] = Gemma::Storage::S3.new(
      bucket: ENV["S3_BUCKET"],
      client: client,
      prefix: "uploads"
    )

  when "test"
    config.storages["store"] = Gemma::Storage::Memory.new

  else # development
    config.storages["store"] = Gemma::Storage::FileSystem.new(
      "uploads",
      prefix: "store"
    )
  end
end
```

## Storage Interface

All storages implement these methods:

```crystal
# Upload a file
storage.upload(io, "path/to/file.jpg")

# Check if file exists
storage.exists?("path/to/file.jpg")  # => true/false

# Get file URL
storage.url("path/to/file.jpg")  # => "https://..."

# Open file for reading
storage.open("path/to/file.jpg")  # => IO

# Delete file
storage.delete("path/to/file.jpg")

# Get full path/key
storage.path("path/to/file.jpg")  # => "uploads/path/to/file.jpg"
```

## Direct Usage

You can use storages directly without models:

```crystal
# Upload file
storage = Gemma.find_storage("store")
storage.upload(File.open("document.pdf"), "documents/report.pdf")

# Or via Gemma class
uploaded_file = Gemma.upload(File.open("photo.jpg"), "store")

# Access the file
uploaded_file.url       # URL to file
uploaded_file.exists?   # Check existence
uploaded_file.delete    # Remove file
```

## Custom Metadata

Pass metadata during upload:

```crystal
Gemma.upload(
  file,
  "store",
  metadata: {
    "filename" => "report.pdf",
    "mime_type" => "application/pdf",
    "size" => file.size.to_s
  }
)
```

For S3, metadata is used for Content-Disposition:

```crystal
# Sets Content-Disposition: inline; filename="report.pdf"
storage.upload(
  file,
  "key",
  metadata: {"filename" => "report.pdf"}
)
```

## Best Practices

### 1. Separate Cache and Store

Always configure both storages:

```crystal
config.storages["cache"] = ...  # Temporary uploads
config.storages["store"] = ...  # Permanent storage
```

### 2. Use Environment Variables

Never hardcode credentials:

```crystal
client = Awscr::S3::Client.new(
  region: ENV["AWS_REGION"],
  aws_access_key: ENV["AWS_ACCESS_KEY_ID"],
  aws_secret_key: ENV["AWS_SECRET_ACCESS_KEY"]
)
```

### 3. Set Appropriate Permissions

For FileSystem, restrict access:

```crystal
Gemma::Storage::FileSystem.new(
  "uploads",
  permissions: 0o600,           # Owner read/write only
  directory_permissions: 0o700  # Owner full access only
)
```

### 4. Configure delivery for production

Prefer a URL produced by the configured storage backend. It can preserve
signatures, expiry, host, and key encoding. Do not form a CDN URL by concatenating
an arbitrary hostname with a path returned for a different origin.

```crystal
# The configured backend owns URL generation.
avatar_url = user.avatar.try(&.url)
```

For public objects behind a CDN, configure the storage/CDN origin and public
host together, then test one upload, one fetch, one replacement, and one delete.
For private objects, use authenticated application delivery or time-limited
presigned URLs.

### 5. Clean Up Cache Periodically

Cached files should be temporary. Clean them periodically:

```crystal
# Cron job or scheduled task
Dir.glob("uploads/cache/**/*").each do |path|
  if File.file?(path) && File.info(path).modification_time < 1.day.ago
    File.delete(path)
  end
end
```


---

## File Validation

Canonical page: https://amberframework.org/docs/v2/guides/uploads/validation

# File Validation

> **Preview ecosystem guide:** Gemma is not part of the Amber 2.0.0-beta.4
> core web-app release gate. Its package version, API, and platform support may
> change independently. Confirm a compatible official release before adding it
> to an application.

## Where the examples go

Attachment validation declarations, conditions, and custom validator methods
belong in the matching Grant model under `src/models/`. Analyzer and plugin
configuration belongs in `config/uploads.cr`. Error rendering belongs in
the matching ECR file under `src/views/`. Virus scanning and expensive file
inspection belong in a dedicated job or service after inexpensive limits have
run.

Gemma provides validation helpers for Grant models to ensure uploaded files meet your requirements.

## Setup

Include the `AttachmentValidators` module alongside `Attachable`:

```crystal
require "gemma/grant"

class User < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column id : Int64, primary: true
  column avatar_data : JSON::Any?

  has_one_attached :avatar

  # Add validations
  validate_file_size_of :avatar, maximum: 5.megabytes
  validate_content_type_of :avatar, accept: ["image/jpeg", "image/png", "image/gif"]
end
```

## File Size Validation

Limit the size of uploaded files:

```crystal
# Maximum size only
validate_file_size_of :avatar, maximum: 5.megabytes

# Minimum size only
validate_file_size_of :document, minimum: 1.kilobyte

# Both minimum and maximum
validate_file_size_of :video, minimum: 100.kilobytes, maximum: 100.megabytes

# Custom error message
validate_file_size_of :avatar,
  maximum: 2.megabytes,
  message: "must be smaller than 2MB"
```

### Size Helpers

Crystal provides convenient size methods:

```crystal
1.kilobyte   # 1024 bytes
1.megabyte   # 1024 * 1024 bytes
1.gigabyte   # 1024 * 1024 * 1024 bytes

# Or use raw bytes
validate_file_size_of :avatar, maximum: 5_242_880  # 5MB in bytes
```

## Content Type Validation

Restrict allowed file types:

### Accept List

```crystal
# Single type
validate_content_type_of :avatar, accept: "image/jpeg"

# Multiple types
validate_content_type_of :avatar, accept: ["image/jpeg", "image/png", "image/gif"]

# Wildcard matching
validate_content_type_of :document, accept: ["application/pdf", "image/*"]
```

### Reject List

```crystal
# Block specific types
validate_content_type_of :upload, reject: ["application/x-executable", "application/x-msdownload"]

# Block category with wildcard
validate_content_type_of :document, reject: "video/*"
```

### Custom Message

```crystal
validate_content_type_of :avatar,
  accept: ["image/jpeg", "image/png"],
  message: "must be a JPEG or PNG image"
```

### Common Content Types

| Category | Types |
|----------|-------|
| Images | `image/jpeg`, `image/png`, `image/gif`, `image/webp`, `image/svg+xml` |
| Documents | `application/pdf`, `application/msword`, `application/vnd.openxmlformats-officedocument.*` |
| Video | `video/mp4`, `video/webm`, `video/quicktime` |
| Audio | `audio/mpeg`, `audio/wav`, `audio/ogg` |
| Archives | `application/zip`, `application/x-tar`, `application/gzip` |

## Presence Validation

Require an attachment to be present:

```crystal
class Profile < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column photo_data : JSON::Any?
  has_one_attached :photo

  # Photo is required
  validate_presence_of :photo

  # Custom message
  validate_presence_of :photo, message: "Please upload a profile photo"
end
```

## Dimension Validation

Validate image dimensions (requires StoreDimensions plugin):

```crystal
require "fastimage"
require "gemma/plugins/store_dimensions"

class ImageUploader < Gemma
  load_plugin(
    Gemma::Plugins::StoreDimensions,
    analyzer: Gemma::Plugins::StoreDimensions::Tools::FastImage
  )
  finalize_plugins!
end

class Photo < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column image_data : JSON::Any?
  has_one_attached :image, uploader: ImageUploader

  # Exact dimensions
  validate_dimensions_of :image, width: 800, height: 600

  # Range of dimensions
  validate_dimensions_of :image,
    width: 100..2000,
    height: 100..2000

  # Only width constraint
  validate_dimensions_of :image, width: 800..1920

  # Only height constraint
  validate_dimensions_of :image, height: 600..1080
end
```

## Collection Size Validation

For `has_many_attached`, validate the number of files:

```crystal
class Post < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column images_data : JSON::Any?
  has_many_attached :images

  # Require at least one image
  validate_collection_size_of :images, minimum: 1

  # Maximum 10 images
  validate_collection_size_of :images, maximum: 10

  # Between 1 and 5 images
  validate_collection_size_of :images, minimum: 1, maximum: 5

  # Custom message
  validate_collection_size_of :images,
    maximum: 5,
    message: "You can upload at most 5 images"
end
```

## Combining Validations

Apply multiple validations to the same attachment:

```crystal
class Document < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column file_data : JSON::Any?
  has_one_attached :file

  # Must be present
  validate_presence_of :file

  # Size between 1KB and 10MB
  validate_file_size_of :file,
    minimum: 1.kilobyte,
    maximum: 10.megabytes

  # Must be PDF or Word document
  validate_content_type_of :file,
    accept: [
      "application/pdf",
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ]
end
```

## Conditional Validation

Use standard Grant validation conditions:

```crystal
class User < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column avatar_data : JSON::Any?
  column is_premium : Bool = false

  has_one_attached :avatar

  # Premium users can upload larger avatars
  validate :avatar_size_for_user_type

  private def avatar_size_for_user_type
    return unless avatar

    max_size = is_premium ? 10.megabytes : 2.megabytes

    if (size = avatar.size) && size > max_size
      errors.add(:avatar, "is too large for your account type")
    end
  end
end
```

## Custom Validators

Create custom validation logic:

```crystal
class Photo < Grant::Base
  include Gemma::Grant::Attachable

  column image_data : JSON::Any?
  has_one_attached :image

  validate :image_aspect_ratio

  private def image_aspect_ratio
    return unless image

    width = image.metadata["width"]?.try(&.to_i)
    height = image.metadata["height"]?.try(&.to_i)

    return unless width && height

    ratio = width.to_f / height.to_f

    # Require 16:9 aspect ratio (with tolerance)
    unless (1.7..1.8).includes?(ratio)
      errors.add(:image, "must have a 16:9 aspect ratio")
    end
  end
end
```

### Virus Scanning

```crystal
class Upload < Grant::Base
  include Gemma::Grant::Attachable

  column file_data : JSON::Any?
  has_one_attached :file

  validate :scan_for_viruses

  private def scan_for_viruses
    return unless file && file_changed?

    file.download do |tempfile|
      result = `clamscan --no-summary #{tempfile.path}`
      status = $?.exit_code

      if status != 0
        errors.add(:file, "failed virus scan")
      end
    end
  end
end
```

## Error Messages

Access validation errors:

```crystal
user = User.new(name: "Alice")
user.avatar = large_file

unless user.valid?
  user.errors[:avatar].each do |error|
    puts error  # => "is too large (maximum is 5242880 bytes)"
  end
end
```

### Display in Views

```ecr
<% if @user.errors[:avatar].any? %>
  <div class="alert alert-danger">
    <% @user.errors[:avatar].each do |error| %>
      <p>Avatar <%= error %></p>
    <% end %>
  </div>
<% end %>
```

## MIME Type Detection

For accurate content type validation, use the DetermineMimeType plugin:

```crystal
require "gemma/plugins/determine_mime_type"

class SecureUploader < Gemma
  load_plugin(
    Gemma::Plugins::DetermineMimeType,
    analyzer: Gemma::Plugins::DetermineMimeType::Tools::File
  )
  finalize_plugins!
end

class Document < Grant::Base
  include Gemma::Grant::Attachable
  include Gemma::Grant::AttachmentValidators

  column file_data : JSON::Any?
  has_one_attached :file, uploader: SecureUploader

  # Now validates against actual file content, not just extension
  validate_content_type_of :file, accept: "application/pdf"
end
```

### Analyzer Options

| Analyzer | Description |
|----------|-------------|
| `File` | Uses system `file` command (most accurate) |
| `Mime` | Uses Crystal's `MIME.from_filename` |
| `ContentType` | Uses HTTP Content-Type header (least secure) |

## Best Practices

### 1. Always Validate Content Type

Don't trust file extensions alone:

```crystal
# Use File analyzer for security
load_plugin(
  Gemma::Plugins::DetermineMimeType,
  analyzer: Gemma::Plugins::DetermineMimeType::Tools::File
)

validate_content_type_of :upload, accept: [...]
```

### 2. Set Reasonable Size Limits

Prevent resource exhaustion:

```crystal
# Avatars: 2-5 MB
validate_file_size_of :avatar, maximum: 5.megabytes

# Documents: 10-50 MB
validate_file_size_of :document, maximum: 50.megabytes

# Videos: Set based on your infrastructure
validate_file_size_of :video, maximum: 500.megabytes
```

### 3. Validate Before Processing

Check files before expensive operations:

```crystal
class Video < Grant::Base
  validate_content_type_of :file, accept: "video/*"
  validate_file_size_of :file, maximum: 500.megabytes

  after_save :transcode_video

  private def transcode_video
    # Only runs if validations pass
    # Safe to process the file
  end
end
```

### 4. Provide Helpful Error Messages

Guide users to fix issues:

```crystal
validate_file_size_of :avatar,
  maximum: 5.megabytes,
  message: "must be smaller than 5MB. Try compressing your image."

validate_content_type_of :avatar,
  accept: ["image/jpeg", "image/png"],
  message: "must be a JPEG or PNG file. Other formats are not supported."
```


---

## Basic View Helpers

Canonical page: https://amberframework.org/docs/v2/guides/views/basic-view-helpers

# Basic View Helpers

The [Jasper::Helpers](https://github.com/amberframework/jasper-helpers) library provides a common set of helper methods that can simplify the development of the views.

## Links

A `link_to` helper is available:

```text
== link_to "Home", "/"
```

Produces the following HTML

```markup
<a href="/">Home</a>
```

## Buttons

A `button_to` helper is available:

```text
== button_to "Logout", "/logout"
```

Produces the following HTML

```markup
<form action="/logout" class="button" method="post">
  <button type="submit">Logout</button>
</form>
```

For more complex forms, see section below.

## Forms

The form helpers listed below are very basic helpers that are included by default. For a more complete form building experience we strongly recommend using [FormBuilder.cr](form-builder.md)

The following methods provide simple HTML form elements:

* `form`
* `text_field`
* `label`
* `hidden_field`
* `select_field`
* `text_area`
* `check_box`
* `submit`

Use `amber generate scaffold [Resource] [field:type] ...` to get the most up-to-date examples of using helpers for resources.

### form

```text
== form(action: "/posts", method: :post) do
  == csrf_tag
  == submit("Create Post")

/ When using `method: :patch`, it add the hidden '_method' field for you
== form(action: "/posts", method: :patch) do
  == csrf_tag
  == submit("Update Post")
```

Produces the following HTML

```markup
<form action="/posts" method="post">
  <input type="hidden" name="<csrf-name-here>" value="<csrf-token-here>" />
  <input type="submit" value="Create Post" id="create_post">
</form>

<form action="/posts" method="post">
  <input type="hidden" name="_method" id="_method" value="patch">
  <input type="hidden" name="<csrf-name-here>" value="<csrf-token-here>" />
  <input type="submit" value="Update Post" id="update_post">
</form>
```

### text\_field

```text
== text_field name: "title", value: "", placeholder: "Title"
```

Produces the following HTML

```markup
<input type="text" name="title" id="title" value="" placeholder="Title">
```

### label

```text
== label :title
```

Produces the following HTML

```markup
<label for="title" id="title_label">Title</label>
```

### text\_area

```text
== text_area name: "body", content: "", placeholder: "Body", size: "30x10"
```

Produces the following HTML

```markup
<textarea name="body" id="body" placeholder="Body" cols="30" rows="10"></textarea>
```

### hidden\_field

```text
== hidden_field name: "secret", content: "Super Secret"
```

Produces the following HTML

```markup
<input type="hidden" name="secret" id="secret" content="Super Secret">
```

### select\_field

```text
/ Array of Arrays
== select_field name: "ranking", collection: [[1, "First"], [2, "Second"]], selected: 1

/ Array of Hashes
== select_field name: "ranking", collection: [{ 1 => "First" }, { 2 => "Second" }], selected: 1

/ Hash
== select_field name: "ranking", collection: { 1 => "First", 2 => "Second" }, selected: 1
```

All the previous code samples produce the following HTML

```markup
<select name="ranking">
  <option value="1" selected="selected">First</option>
  <option value="2">Second</option>
</select>
```

### check\_box

```text
== check_box(:published, checked: false)
```

Produces the following HTML

```markup
<input type="checkbox" name="published" id="published" value="1" checked="false">
```

### All together

```text
== form(action: "/posts", method: :post) do
  == csrf_tag

  == hidden_field name: "secret", content: "Super Secret"

  == label :title
  == text_field name: "title", value: "", placeholder: "Title"

  == label :body
  == text_area name: "body", content: "", placeholder: "Body", size: "30x10"

  == label :ranking
  == select_field name: "ranking", collection: [[1, "First"], [2, "Second"]], selected: 1

  == label(:published)
  == check_box(:published, checked: false)

  == submit("Create Post")
```

Produces the following HTML

```markup
<form action="/posts" method="post">
  <input type="hidden" name="<csrf-name-here>" value="<csrf-token-here>" />

  <input type="hidden" name="secret" id="secret" content="Super Secret">

  <label for="title" id="title_label">Title</label>
  <input type="text" name="title" id="title" value="" placeholder="Title">

  <label for="body" id="body_label">Body</label>
  <textarea name="body" id="body" placeholder="Body" cols="30" rows="10"></textarea>

  <label for="ranking" id="ranking_label">Ranking</label>
  <select name="ranking">
    <option value="1" selected="selected">First</option>
    <option value="2">Second</option>
  </select>

  <label for="published" id="published_label">Published</label>
  <input type="hidden" name="published" id="published" value="0"><input type="checkbox" name="published" id="published" value="1" checked="false">
  <input type="submit" value="Create Post" id="create_post">
</form>
```


---

## Channels

Canonical page: https://amberframework.org/docs/v2/guides/websockets/channels

# Channels

## Introduction

All messages are routed through channels, and channel topics are where clients subscribe to listen for new messages. Channels define 3 public methods that can be used:

* `handle_joined` - Called when a user joins a channel.
* `handle_message` - Called when a user sends a message to a channel.  A common message handler will simply rebroadcast the message to the other subscribers with `rebroadcast!` method.
* `handle_leave` - Called when a user leaves the channel.

## Example Usage

A channel can be generated by calling `amber g channel ChatRoom`.

```crystal
class ChatRoomChannel < Amber::Websockets::Channel

  # optional
  # Authorization can happen here  
  def handle_joined(client_socket, message)
    # channel join related functionality
    # if client_socket.session[:user_id] != message["payload"]["user_id"]
    #   client_socket.disconnect!
    # end
  end

  # required
  def handle_message(client_socket, msg)
    rebroadcast!(msg)
  end

  # optional
  def handle_leave(client_socket)
    # channel leave functionality    
  end
end
```

## What happens when a user joins?

The `handle_joined` method is invoked when a user lands on a web page that has a `new Amber.Socket` established through the JavaScript on it.
This method allows you to run any logic needed to authorize who should be connected to a channel. This is also a great 
way to send out a `#{name} has joined the chat!` message to all those currently listening to the channel.

## How are messages broadcasted?

Whenever a user sends a message that is broadcasted through the JavaScript `channel.push` function, the `handle_message` method is invoked. 
Here the message is then rebroadcasted to all those who are connected to the channel. The message is then transmitted through the 
`channel.on('message_new')` listener in the JavaScript. Before the message gets broadcast, here is where you would want to insert records into your 
database, if you wanted to keep a history of messages sent or received.

## What happens when a user leaves?

When a user leaves the web page that currently has an established socket connection, the connection breaks and triggers a message to be sent 
on the servers side. The `handle_leave` method handles this in the channels class. Here is where a message such as `#{name} has left the chat!` could 
be sent out to all connected clients.


---

## Sockets

Canonical page: https://amberframework.org/docs/v2/guides/websockets/sockets

# Sockets

A client socket represents one WebSocket connection and maps topic patterns to
channel classes. Amber CLI V2 generates channels, while the socket boundary is
currently hand-authored.

**Run from: the application root.**

```bash
amber generate channel ChatRoom --topics=chat_room
```

**File: `src/sockets/chat_socket.cr` — create this socket struct, then ensure
the application requires `src/sockets/**` before routes compile.**

```crystal
struct ChatSocket < Amber::WebSockets::ClientSocket
  channel "chat_room:*", ChatRoomChannel

  def on_connect : Bool
    # `session`, `cookies`, and validated `params` are available here.
    !!session[:current_user_id]?
  end
end
```

**File: `config/routes.cr` — add the handshake route inside the existing
`routes :web` block.**

```crystal
Amber::Server.configure do
  routes :web do
    websocket "/chat", ChatSocket
  end
end
```

Return `false` from `on_connect` to reject the connection. Override
`on_disconnect`, `on_reconnect`, or `on_error` when the application needs
connection lifecycle behavior.

**File: the controller or service that owns the event, under `src/controllers/`
or `src/services/` — broadcast after the application operation succeeds.**

```crystal
ChatSocket.broadcast(
  "message",
  "chat_room:123",
  "message_new",
  {"message" => "A new visitor!"}
)
```

The V1 `amber g socket` shortcut is not a command in the standalone V2 CLI.
Create the socket struct explicitly, generate channels with `amber generate
channel`, and cover the handshake and authorization behavior with specs.


---

## Webpack to ESM Migration

Canonical page: https://amberframework.org/docs/v2/migration-guide/webpack-to-esm

# Migrating from Webpack to ESM

Amber V2 does not require Webpack, Node.js, npm, or a JavaScript framework. A
server-rendered application can use browser-native ESM and import maps. Removing
a working build tool is still a migration, not a prerequisite for upgrading the
Amber runtime.

> **Release boundary:** Amber `2.0.0-beta.4`, Amber CLI `2.0.5`, and
> asset_pipeline `0.37.0` support the manifest contract below. Keep the existing
> build whenever the application still needs Sass,
> TypeScript, JSX, Vue single-file components, PostCSS, or another compiler.

## Decide what Webpack currently owns

Before changing files, record:

- every JavaScript entry point and dynamic chunk;
- every imported stylesheet, image, font, and source map;
- TypeScript, JSX, Sass, PostCSS, or other transformations;
- environment-variable substitutions and compile-time flags;
- development proxy and hot-module behavior;
- public paths, CSP requirements, and CDN behavior; and
- the command and artifact used by the current production deployment.

Run the existing test, build, and browser smoke checks and keep that result as
the rollback baseline. Do not delete `package.json`, the lockfile, Webpack
configuration, or the last known-good artifact yet.

## Choose the smallest migration

| Existing application | First move |
|---|---|
| Browser-ready JavaScript and CSS | Move them to the authored asset tree and use the manifest compiler |
| A few replaceable npm packages | Prefer local reviewed ESM, or pin deliberate external ESM URLs |
| TypeScript, JSX, Sass, or PostCSS | Keep that compiler; send its browser-ready output into the asset tree |
| A large SPA | Keep its build and migrate server-rendered Amber pages independently |

The Asset Pipeline build is fast and deterministic, but it is still a build.
Its job is content addressing and reference rewriting, not source-language
transpilation.

## Target file map

```text
my_app/
├── shard.yml
├── config/assets.cr
├── scripts/build_assets.cr                        # only for older CLI build environments
├── app/assets/
│   ├── stylesheets/app.css
│   ├── javascript/
│   │   ├── app.js
│   │   └── controllers/hello_controller.js
│   ├── images/
│   └── fonts/
├── public/assets/manifest.json                    # generated
└── src/views/layouts/application.ecr
```

Source control owns `app/assets/`. The compiler owns `public/assets/`. Runtime
uploads belong in neither location.

## 1. Add the released compiler

**File: `shard.yml` — add the compatible official Asset Pipeline release under
the existing `dependencies:` key.**

```yaml
dependencies:
  asset_pipeline:
    github: amberframework/asset_pipeline
    version: 0.37.0
```

**Run from: the application root.**

```bash
shards install
```

## 2. Configure the resolver and optional build wrapper

**File: `config/assets.cr` — create the runtime resolver configuration.**

```crystal
Amber::Assets.configure(
  manifest_path: "public/assets/manifest.json"
)
```

**File: `scripts/build_assets.cr` — create this complete file only when the
build environment cannot run Amber CLI `2.0.5`.**

```crystal
require "asset_pipeline/static_assets"

AssetPipeline::StaticAssets::Compiler.new(
  source_root: Path["app/assets"],
  output_root: Path["public/assets"],
  public_path: "/assets"
).build
```

Amber CLI `2.0.5` exposes the same compiler as `amber assets build` and verifies
its output with `amber assets check`. Do not load compiler construction from
`config/assets.cr`; the running app needs the resolver, not build tooling.

## 3. Move one vertical slice

Start with one page rather than every asset.

**Before: for example `src/assets/javascripts/hello_controller.js`.**

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  greet() {
    this.element.textContent = "Hello!"
  }
}
```

**After: `app/assets/javascript/controllers/hello_controller.js` — move the
browser-ready module here without changing its behavior.**

If it imports a local module with `./` or `../`, keep that relative import. The
compiler fingerprints the dependency and rewrites static imports, exports,
dynamic imports, and source-map references. Bare names such as
`@hotwired/stimulus` remain for the import map.

**File: `app/assets/javascript/app.js` — create the browser entry point that
starts Stimulus and registers the migrated controller.**

```javascript
import { Application } from "@hotwired/stimulus"
import HelloController from "hello-controller"

const application = Application.start()
application.register("hello", HelloController)
```

**File: `app/assets/stylesheets/app.css` — move browser-ready CSS here.**

```css
@font-face {
  font-family: "Manrope";
  src: url("../fonts/Manrope-Variable.woff2") format("woff2");
  font-display: swap;
}

.hero {
  background: url("../images/hero.webp") center / cover no-repeat;
}
```

Place the real font and image at the referenced relative paths. Local CSS
`url(...)` and `@import` values are rewritten to fingerprinted URLs while query
strings and fragments are preserved. Root-relative, external, protocol-relative,
fragment, `data:`, and `blob:` references remain unchanged.

Asset Pipeline does not invent responsive images. Generate real widths and
formats first, store each variant under `app/assets/images/`, and write a
`srcset` or `<picture>` that names real logical files.

**Run from: the application root after the source files and every referenced
font and image exist.**

```bash
amber assets build
amber assets check
```

Stop on a missing-reference error. Do not replace it with a raw path merely to
make the build pass.

## 4. Load the configuration and update the layout

**File: the application entry point, for example `src/my_app.cr` — keep the
generated configuration wildcard or explicitly require the asset file.**

```crystal
require "../config/*"
```

Creating `config/assets.cr` is not enough if a migrated entry point never
requires it. The configuration wildcard must appear before controllers and
models; otherwise require `../config/assets` after the file that loads Amber.

**File: `src/views/layouts/application.ecr` — replace the selected page's raw
asset tags with manifest-aware helpers.**

```ecr
<head>
  <%= stylesheet_link_tag("stylesheets/app.css") %>
  <%= javascript_importmap_tag(
    {
      "app" => "javascript/app.js",
      "hello-controller" => "javascript/controllers/hello_controller.js",
      "@hotwired/stimulus" => "https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3.2.2/+esm"
    },
    preload: [
      "javascript/app.js",
      "javascript/controllers/hello_controller.js"
    ]
  ) %>
</head>
<body>
  <%= content %>
  <script type="module">import "app";</script>
</body>
```

Use only one import map. Local values are strict logical manifest paths;
external URLs pass through. Prefer a reviewed self-hosted copy under
`app/assets/javascript/vendor/` when availability or privacy cannot depend on a
third party.

## 5. Keep necessary source compilers

When Webpack still compiles TypeScript, Sass, or another source language, keep
that stage and give it a separate intermediate directory outside
`public/assets/`. Then copy or generate the browser-ready result into
`app/assets/` before the manifest build.

For example, a release sequence may be:

```bash
npm ci
npm run build:browser-source
amber assets build
amber assets check
crystal spec
shards build my_app --release
```

The exact npm script is application-owned. Pin its toolchain and check its
output; do not claim “no Node” until no retained source file requires it.

## 6. Verify before removing Webpack

**Run from: the application root.**

```bash
amber assets build
amber assets check
crystal spec
amber watch
```

For every migrated page verify:

1. the manifest contains its JavaScript, CSS, images, fonts, and other files;
2. all HTML and rewritten CSS/JavaScript references use fingerprinted paths;
3. response bytes and content types are correct;
4. CSP, module imports, source maps, interactions, and reduced-motion behavior
   still work;
5. editing each asset class changes its URL after a rebuild;
6. the runtime succeeds with the release directory read-only; and
7. the prior complete release can still be started.

Only after all Webpack-owned transformations have replacements should you
remove its tags, configuration, dependency manifest, lockfile, and generated
directory in one reviewable change. Keep the repository history and prior
release artifact as rollback evidence.

## Deploy and roll back atomically

Build assets before the application binary. Package the binary, configuration,
`public/assets/manifest.json`, and every emitted asset as one release. Publish
the manifest last during a build, but switch traffic only after the whole
release verifies.

Fingerprint URLs may receive `public, max-age=31536000, immutable`. HTML,
manifest files, and unhashed legacy URLs must revalidate. Do not delete the
prior release's assets while clients may still request its HTML.

Rollback means switching to the complete prior release—not rendering an old
layout against a new manifest. During a staged migration, routing separate pages
to their existing Webpack tags and new manifest tags is safer than a runtime
conditional that mixes two asset graphs in one document.

## Troubleshooting

### A logical asset is missing

Compare the helper or import-map value with the path relative to `app/assets/`,
then rebuild. Do not paste a generated digest or raw `/assets/` URL into source.

### A local import fails

Use a relative specifier (`./` or `../`) for a local module imported by another
source module, or map a bare name in the one document import map. Confirm the
emitted JavaScript contains the dependency's fingerprinted URL.

### A font or background image fails

Resolve the source URL relative to the CSS file, not the project root. Confirm
the target is inside `app/assets/`, present in the manifest, and served with the
manifest's content type.

### A remote module reports CORS or CSP errors

Fix the selected provider and application security policy, or self-host the
reviewed ESM artifact. Do not add a blanket cross-origin response header to all
self-hosted assets; same-origin modules do not need one.


---

## Granite to Grant Migration

Canonical page: https://amberframework.org/docs/v2/migration-guide/granite-to-grant

# Migrating from Granite to Grant

Grant is the default model layer in new Amber CLI `2.0.5` web applications.
That does not make an ORM replacement part of the Amber 1-to-2 framework
upgrade. First prove that the existing application can run on Amber
`2.0.0-beta.4` with its current persistence stack. Start this guide only when
moving to Grant is an explicit second decision.

## Establish the safety boundary

Before editing a model:

1. Record the current Crystal, Amber, Granite, driver, and database versions.
2. Run the complete test suite and compile the application binary.
3. Back up the database and restore that backup into a disposable environment.
4. Capture representative reads, writes, validations, associations,
   transactions, callbacks, and error behavior.
5. Choose one low-risk model boundary for the first migration.

Do not run two migration systems against the same schema without one explicit
owner. Amber CLI uses Micrate SQL under `db/migrations/`; keep the application's
existing migration history and decide where new versions will be recorded
before applying anything.

## Pin Grant and one driver

**File: `shard.yml` — add the same reviewed Grant source used by a generated
Amber CLI `2.0.5` application plus the application's database driver.**

```yaml
dependencies:
  grant:
    github: crimson-knight/grant
    commit: 2665a978b43ac608c68cde9243821f8f8f053372
  pg:
    github: will/crystal-pg
    version: 0.30.0
```

The example uses PostgreSQL. Use the SQLite or MySQL dependency from a freshly
generated `2.0.5` app when that is the database being migrated. Do not add all
three drivers.

## Register the Grant connection

**File: `config/database.cr` — register a connection loaded by the app's
existing `require "../config/*"` entry point.**

```crystal
require "grant"
require "grant/adapter/pg"

Grant::Connections << Grant::Adapter::Pg.new(
  name: "primary",
  url: ENV["DATABASE_URL"]? || Amber.settings.database_url
)
```

Use `Grant::Adapter::Sqlite` with `require "grant/adapter/sqlite"` or
`Grant::Adapter::Mysql` with `require "grant/adapter/mysql"` for those drivers.

## Translate one model without changing its table

**Existing Granite file: `src/models/user.cr`.**

```crystal
class User < Granite::Base
  connection pg
  table users

  column id : Int64, primary: true
  column email : String
  column name : String?
  column admin : Bool = false
  column created_at : Time?
  column updated_at : Time?
end
```

**Grant replacement: `src/models/user.cr`.**

```crystal
class User < Grant::Base
  connection primary
  table users

  column id : Int64, primary: true
  column email : String
  column name : String?
  column admin : Bool = false

  timestamps
end
```

Keep `connection primary` and `table users` explicit during a migration. This
matches the supported generator and prevents an inference change from silently
pointing at another connection or table. `timestamps` maps the conventional
`created_at` and `updated_at` columns; verify their exact database types before
removing the previous declarations.

## Preserve schema before changing behavior

An ORM migration does not inherently require a database schema migration. If
the existing table already matches the Grant columns, first make the new model
read and write the existing schema. Add Micrate SQL only for an intentional
schema change.

Write a focused spec against the restored disposable database:

```crystal
user = User.new
user.email = "migration@example.com"
user.admin = false
user.save.should be_true

persisted = User.find(user.id)
persisted.should_not be_nil
persisted.not_nil!.email.should eq("migration@example.com")
```

Then prove update and destroy, required and nullable values, unique constraints,
timestamps, and the error paths used by the application.

## Translate application operations deliberately

Do not perform a global search-and-replace. Convert one behavior at a time and
keep a spec beside it.

```crystal
# Collection
users = User.all.to_a

# Primary-key lookup
user = User.find(params[:id])

# Typed assignment and persistence
user = User.new
user.email = schema.email.not_nil!
user.name = schema.name
user.save

# Delete
user.destroy
```

For filtering, associations, validations, callbacks, transactions, and
security APIs, follow the matching [Grant guides](../guides/models/grant/) and
verify the behavior against the pinned commit. Do not assume a similarly named
Granite method has identical return types, callback order, transaction scope,
or error semantics.

## Decide whether the ORMs may coexist

Coexistence can be useful for a staged migration, but it is not automatic.
Before running Granite and Grant together, prove:

- their connection pools do not compete for lifecycle ownership;
- only one migration system advances the schema;
- a transaction does not falsely imply atomicity across different pools;
- callbacks and validations are not executed twice;
- two classes writing one table agree on types, defaults, timestamps, and
  optimistic-locking behavior;
- application code names which ORM owns each model.

If those conditions are not testable, migrate in a maintenance window or a
separate deployment rather than carrying two active writers.

## Completion gates

For every migrated model, keep evidence for:

- schema compatibility and reversible migration SQL when schema changed;
- representative create, read, update, and destroy operations;
- nullable and required fields on new records;
- validations and database constraints;
- associations and query counts;
- callback order and external side effects;
- transaction rollback behavior;
- production-shaped performance for critical queries.

Only remove Granite after no application file, job, task, or maintenance script
requires it and a restored production backup passes the Grant-backed suite.


---

## Redis to Adapters Migration

Canonical page: https://amberframework.org/docs/v2/migration-guide/redis-to-adapters

# Migrating from Redis to Adapters

Amber V2 removes Redis as a mandatory framework dependency. The framework ships
in-memory session and pub/sub adapters; it does **not** ship a first-party Redis
implementation. Applications that still need Redis must implement and register
adapters against the Amber interfaces.

This migration changes how Amber reaches the storage or message broker. It does
not require you to stop using Redis.

## Where the examples go

- built-in adapter names go in `config/environments/development.yml`,
  `test.yml`, or the environment being changed;
- application adapter classes go under `src/adapters/`, for example
  `src/adapters/redis_session_adapter.cr`;
- adapter registration belongs in `config/application.cr` before Amber builds
  its session or pub/sub services; and
- commands and specs run from the application root beside `shard.yml`.

## Choose the target behavior

| Requirement | Suitable direction |
|---|---|
| Local development and tests | Built-in memory adapters |
| One application process where losing process-local state is acceptable | Built-in memory adapters after explicit verification |
| Sessions shared across processes or hosts | Registered external session adapter |
| WebSocket broadcasts shared across processes or hosts | Registered external pub/sub adapter |
| Existing Redis-backed production behavior | Custom Redis adapters or another verified shared backend |

The memory adapters are process-local. Do not use them as a silent replacement
for shared Redis state in a horizontally scaled deployment.

## Inventory the Amber 1.x contract

Before changing configuration, record:

- the session cookie name, signing or encryption behavior, expiration, and
  rotation rules;
- the Redis key and channel namespaces;
- the serialized session and pub/sub payload formats;
- whether users or broadcasts must survive a process restart;
- every application process that reads sessions or subscribes to broadcasts;
- cleanup jobs, Redis ACLs, TLS settings, and monitoring tied to the old keys.

Keep a deployable copy of the current configuration while the replacement is
tested.

## Built-in memory configuration

The clean V2 application selects the built-in adapters by name:

```yaml
# config/environments/development.yml
session:
  key: "my_app.session"
  store: "signed_cookie"
  adapter: "memory"
  expires: 3600

pubsub:
  adapter: "memory"
```

Use this path for development, tests, or a deployment whose process-local state
is an intentional constraint. Restart the application during testing to prove
that the resulting state loss is acceptable.

## Keep Redis through a custom session adapter

A shared session backend implements `Amber::Adapters::SessionAdapter`:

```crystal
abstract class Amber::Adapters::SessionAdapter
  abstract def get(session_id : String, key : String) : String?
  abstract def set(session_id : String, key : String, value : String) : Nil
  abstract def delete(session_id : String, key : String) : Nil
  abstract def destroy(session_id : String) : Nil
  abstract def exists?(session_id : String, key : String) : Bool
  abstract def keys(session_id : String) : Array(String)
  abstract def values(session_id : String) : Array(String)
  abstract def to_hash(session_id : String) : Hash(String, String)
  abstract def empty?(session_id : String) : Bool
  abstract def expire(session_id : String, seconds : Int32) : Nil
  abstract def batch_set(session_id : String, values : Hash(String, String)) : Nil
  abstract def batch(session_id : String, &block : Amber::Adapters::SessionBatchOperations ->) : Nil
end
```

Register the application implementation before Amber builds the session store:

```crystal
# config/application.cr
require "amber"
require "../src/adapters/redis_session_adapter"

Amber::Adapters::AdapterFactory.register_session_adapter("redis") do
  RedisSessionAdapter.new(redis_client)
end
```

Then select the registered name in the environment configuration:

```yaml
session:
  key: "my_app.session"
  store: "signed_cookie"
  adapter: "redis"
  expires: 86400
```

The [Session Adapters guide](../../guides/adapters/sessions/) documents the complete
interface and registration contract. Compile and contract-test the application
adapter against the exact Redis shard version it uses.

## Keep cross-process broadcasts through a custom pub/sub adapter

A shared message backend implements `Amber::Adapters::PubSubAdapter`:

```crystal
abstract class Amber::Adapters::PubSubAdapter
  abstract def publish(topic : String, sender_id : String, message : JSON::Any) : Nil
  abstract def subscribe(topic : String, &block : (String, JSON::Any) -> Nil) : Nil
  abstract def unsubscribe(topic : String) : Nil
  abstract def unsubscribe_all : Nil
  abstract def close : Nil
end
```

Register and select the application implementation:

```crystal
# config/application.cr
require "amber"
require "../src/adapters/redis_pubsub_adapter"

Amber::Adapters::AdapterFactory.register_pubsub_adapter("redis") do
  RedisPubSubAdapter.new(redis_client)
end
```

```yaml
pubsub:
  adapter: "redis"
```

The [PubSub Adapters guide](../../guides/adapters/pubsub/) covers registration and
multi-process behavior. Test with at least two application processes; a
single-process browser test cannot prove cross-process delivery.

## Preserve or retire existing sessions deliberately

Changing a session backend can invalidate every active session. Choose one of
these policies before deployment:

- preserve the existing Redis key namespace and serialization in the new
  adapter;
- deploy a temporary dual-read migration that moves a session after a
  successful old-format read;
- schedule a coordinated logout and communicate it as an intentional product
  change.

Do not assume that forcing every user to sign in again is harmless. Account
recovery, long-running work, carts, CSRF state, and administrative sessions may
make session loss operationally significant.

## Cutover sequence

1. Add the adapter implementation and its dependency without removing the old
   Redis configuration.
2. Contract-test every adapter method, expiration behavior, malformed payload,
   connection failure, and reconnect path.
3. Exercise login, logout, session rotation, and WebSocket broadcasts in a
   staging deployment that matches the production process count.
4. Apply the chosen active-session migration policy.
5. Switch the Amber configuration to the registered adapter name.
6. Monitor adapter errors, Redis connections, session failures, and broadcast
   delivery through the rollback window.

## Removing Redis after the cutover

Remove Redis only after confirming that no application process, job worker,
cache, rate limiter, session store, or pub/sub subscriber still uses it. Inspect
the shard dependencies, environment variables, deployment manifests, secrets,
monitoring, and infrastructure configuration before retiring the service.

Keep the previous configuration and deployment artifact available until the
replacement has passed its production verification window.

## Verification checklist

- [ ] Session create, read, update, delete, destroy, and expiration behavior pass.
- [ ] Login, logout, rotation, and invalid-cookie behavior pass.
- [ ] Restart behavior matches the chosen state policy.
- [ ] Broadcasts reach subscribers in a second application process.
- [ ] Redis authentication, TLS, ACLs, timeouts, and reconnect behavior are tested when Redis remains.
- [ ] The active-session migration or coordinated logout is documented.
- [ ] The previous configuration can be restored without a code rewrite.
