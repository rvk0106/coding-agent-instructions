# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess — discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `app/`, `config/`, `db/`, `spec/`, `lib/`, engines if present
- **Entry points:** `config/routes.rb`, `config/application.rb`, Gemfile, README
- **Key config:** database.yml, environments, initialisers relevant to architecture

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | Gemfile, config | Ruby/Rails versions, key gems (API, auth, DB, jobs) |
| **Schema** | db/schema.rb, app/models | Tables, relationships, indexes, migration conventions |
| **API** | config/routes.rb, app/controllers, serializers | Endpoints, HTTP methods, response shapes, error handling |
| **Conventions** | app/controllers, app/services, app/models | Controller thin? Services where? Serializer patterns? |
| **Auth / tenant** | application_controller, policies, scopes | Auth mechanism, tenant/scope patterns, CORS |
| **Testing** | spec/spec_helper.rb, spec/rails_helper.rb, Gemfile | RSpec version, matchers (shoulda-matchers), factories (FactoryBot), coverage (SimpleCov), fixtures vs factories |
| **Ops** | README, Rakefile, config, .github | Test command, lint command, CI, deploy hints |

### 3. Fill knowledge files
Populate from discovery. Create or update only these; leave workflow files as provided by install unless clearly empty and project-specific.

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Components, data flow, tenancy from app structure and config |
| **architecture/database.md** | Schema, tables, relations, migration rules from db/schema.rb and models |
| **architecture/api-design.md** | Endpoints, request/response shapes, versioning from routes and controllers |
| **architecture/patterns.md** | Controller/service/serializer conventions from code |
| **architecture/error-handling.md** | HTTP codes, error payloads from controllers and rescues |
| **architecture/data-flow.md** | Request lifecycle, middleware, auth pipeline from application_controller |
| **architecture/glossary.md** | Domain terms, roles, statuses from models and business logic |
| **infrastructure/environment.md** | Ruby/Rails versions, DB, env vars from Gemfile and config |
| **infrastructure/dependencies.md** | Gems, external services from Gemfile and config |
| **infrastructure/tooling.md** | Linters, test commands, CI from config, README, and spec helpers |
| **infrastructure/deployment.md** | Hosting, deploy process if present |
| **infrastructure/security.md** | Auth boundaries, tenant scoping from code |
| **features/** | One file per major feature per `features/_TEMPLATE.md`; describe current behavior |

**Workflow files:** If `workflow/testing.md` (or another workflow file) is present but empty, add only project-specific content (e.g. actual test/lint commands). Do not overwrite process instructions.

### 4. (Optional) Build context retrieval
If the project uses a **vector DB** or **reduced context index**, index the knowledge files now. See `workflow/context-retrieval.md` for when and how to re-index.

### 5. Output
Produce a short summary:
```
Initialise complete.

Context loaded from project. Files created/updated:
- architecture/system-design.md
- architecture/database.md
- [list others]

Optional: Vector index updated (if applicable).

Next: Run `plan architecture for TICKET-ID` when ready.
```

## After Initialise
- Do not re-run on every ticket. Use `workflow/maintenance.md` to keep knowledge files updated after each ticket.
- Re-run initialise only when knowledge files are missing, empty, or the project has changed significantly.
