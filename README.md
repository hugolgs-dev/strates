# Strates

A web app to create and share [Crystal](https://crystal-lang.org/) code snippets.

A *strate* is one saved snippet — a name, some Crystal source, and a target
Crystal version — addressed by an 8-character slug. Snippets are **immutable**(for now) and saving creates a *new* row that records its ancestor in
`forked_from`, so history accumulates in layers. The editor supports syntax highlighting, line numbers, and basic editing features. Snippets can be shared by URL, forked, and saved as new.

This app is inspired by [Ellie](https://ellie-app.com/), [Ellies Catalog](https://janiczek-ellies.builtwithdark.com/) and [Godbolt's Compiler Explorer](https://godbolt.org/).

> **Status:** Still work-in-progress. The editor, sharing, forking, and save-as-new all work. Running
> snippets is not implemented yet, hence why the `Run` button is deliberately disabled.

## Stack

| | |
|---|---|
| Language | Crystal `>= 1.20.0, < 2.0` |
| Framework | [Amber](https://amberframework.org/) `2.0.0-beta.4` (CLI `2.0.5`) |
| ORM | [Grant](https://github.com/crimson-knight/grant) |
| Database | SQLite (WAL mode), migrated with Micrate |
| Editor | [CodeMirror 6](https://codemirror.net/), bundled with esbuild |
| CSS | [Oat](https://oat.ink/) plus project styles |

## Requirements

- Crystal `>= 1.20`
- SQLite `>= 3.24.0` — Grant enforces this at connection time (`ON CONFLICT` support)
- Node `>= 20` (build-time only; not needed at runtime)

## Setup

```bash
shards install
npm ci
npm run build:js        # bundles CodeMirror -> app/assets/javascript/vendor/editor.js
amber assets build      # fingerprints app/assets -> public/assets + manifest.json
amber database migrate
```

**Order matters.** `npm run build:js` must run before `amber assets build`.
Both `app/assets/javascript/vendor/editor.js` and `public/assets/` are
gitignored build artifacts, so a fresh clone has neither. Amber's asset
resolver is strict by design — a missing manifest entry is a hard failure at
build time, not a silent 404 in the browser.

## Development

```bash
amber watch
```

Serves <http://127.0.0.1:3000>. The `watch` block in `.amber.yml` runs
`npm run build:js` before each Crystal rebuild and watches `frontend/`, so
editing the editor source rebuilds the bundle too.

To iterate on the editor with readable output and a sourcemap, run in a second
terminal:

```bash
npm run watch:js
```

## Tests

```bash
AMBER_ENV=test amber database migrate   # once, creates db/strates_test.db
AMBER_ENV=test crystal spec
```

`AMBER_ENV=test` is required. Without it the suite resolves the *development*
database URL, and the model specs truncate tables — `spec/models/snippet_spec.cr`
aborts with a message rather than let that happen.

Coverage: 
- The model: slug generation, forking, validations
- The version cache
- The request schema
- The HTTP layer: routing, pagination, search, content negotiation, error responses, XSS
escaping.

## Routes

| Method | Path | Action | Pipeline |
|---|---|---|---|
| `GET` | `/` | list, paginated, `?q=` search, `?page=` | `:web` |
| `GET` | `/:slug` | show — HTML, or JSON with `Accept: application/json` | `:web` |
| `POST` | `/strates` | create | `:api` |
| `POST` | `/:slug/save` | save as new, sets `forked_from` | `:api` |
| `POST` | `/:slug/fork` | copy a snippet, redirect to it | `:web` |

`:slug` is constrained to exactly 8 alphanumerics, so non-slug paths fall
through to the static pipeline and a real 404.

```bash
amber routes    # print the route table
```

### Use of AI

I believe it's important to be transparent on how AI agents are used in open-source projects nowadays. This section is here to describe what parts of the project were assisted by AI.

- Brainstorming and initial project roadmap (see CLAUDE.md).
- Tests
- Initial structure of the models and schemas. It turned out to be not great, so I changed a lot of things.
- Explaining some Crystal and Amber concepts to me, by referring to the official documentation and giving me examples.
- Review the code of `editor.js` and give me suggestions on how to improve it.

The Crystal LSP and the Ameba shard also helped.

Overall, I made sure to review and edit all the code coming from the agent. This is also a project I'm using to learn Crystal and Amber, so I wanted to make sure I understand everything that is being added to the project.

Everything else was not made with an AI assistant/agent. Just my hands and my brain.

## Contributing

1. Fork it (<https://github.com/hugolgs-dev/strates/fork>)
2. Make sure you read the whole README first.
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [hugolgs-dev](https://github.com/hugolgs-dev/) — creator and maintainer

## License

MIT — see [LICENSE](LICENSE).
