# Master Instructions — Rails Agent (v2)

## Role
You are a collaborator, not an autonomous engineer. Propose plans, execute small verified steps, stop for human review.

## Default Loop
1. Fetch ticket → `workflow/ticket-access.md`
2. **If first planning or knowledge files empty** → run `workflow/initialise.md` (full steps) or follow [Project onboarding](#project-onboarding-first-planning) below, then continue
3. Plan → `workflow/planning.md` → save to `docs/TICKET-ID-plan.md` → STOP
4. Execute Phase N → `workflow/execution.md` → STOP
5. Verify → `workflow/testing.md`
6. **Optional:** Run `workflow/reviewer.md` for a structured review (checklist, Approve/Request changes) before human sign-off
7. Wait for human approval → repeat for Phase N+1
8. After ticket complete → `workflow/maintenance.md`

---

## Project onboarding (first planning)

**When:** Before creating the first plan, or when `architecture/`, `infrastructure/`, or `features/` files are missing or clearly empty (e.g. placeholders only).

**Goal:** Understand the project and fill the knowledge files so planning and execution have accurate context. Do not guess — discover from the codebase, then write.

### 1. Discover the project
- **Structure:** App layout (`app/`, `config/`, routes, engines)
- **Stack:** Gemfile, Ruby/Rails versions, key gems (API, auth, DB, background jobs)
- **Data:** Schema, models, main tables, relationships (from `db/schema.rb` or migrations)
- **API:** Controllers, routes, response shapes, error handling (from `config/routes`, controllers, serializers)
- **Conventions:** How controllers/services/serializers are used; tenant/scope patterns; security (auth, CORS)
- **Ops:** Env vars, test/lint commands, CI/config (from README, Rakefile, config files)

### 2. Fill the knowledge files (from discovery)
Populate only what exists; leave sections as “TBD” or “Not used” where the project doesn’t use something.

| Folder / file | What to fill from |
|---------------|-------------------|
| **architecture/system-design.md** | Components, high-level data flow, tenancy from app structure and config |
| **architecture/database.md** | Schema, tables, key relations, migration conventions from `db/schema.rb` and models |
| **architecture/api-design.md** | Endpoints, request/response shapes, versioning from routes and controllers |
| **architecture/patterns.md** | Controller/service/serializer conventions, design patterns from code |
| **architecture/error-handling.md** | HTTP codes, error payloads, exception handling from controllers and rescues |
| **architecture/data-flow.md** | Request lifecycle, middleware, auth pipeline from `application_controller`, middleware |
| **architecture/glossary.md** | Domain terms, roles, statuses from models and business logic |
| **infrastructure/environment.md** | Ruby/Rails versions, DB, env vars from Gemfile and config |
| **infrastructure/dependencies.md** | Gems, external services, APIs from Gemfile and config |
| **infrastructure/tooling.md** | Linters, test commands, CI from config and README |
| **infrastructure/deployment.md** | Hosting, deploy process if present in repo or config |
| **infrastructure/security.md** | Auth boundaries, tenant scoping, OWASP-relevant rules from code |
| **features/** | One file per major feature per `features/_TEMPLATE.md`; describe current behavior |

**Workflow files** (`workflow/*.md`) are usually provided by install; if a file is present but empty, enrich it from project discovery only where it clearly applies (e.g. add project-specific verification commands to `workflow/testing.md`).

### 3. (Optional) Build context retrieval
If the project uses a **vector DB** or **reduced context index** (see `workflow/context-retrieval.md`), index the knowledge files now so the agent can retrieve only relevant chunks and avoid sending full files every time. Re-index after any future change to those files (maintenance).

### 4. Then proceed with planning
After onboarding, say “Context loaded: project onboarded; architecture, infrastructure, and features updated from codebase.” Then run the normal planning flow from `workflow/planning.md` and produce `docs/TICKET-ID-plan.md`.

**Do not** re-onboard on every ticket. Only run onboarding when knowledge files are missing or empty; afterward rely on `workflow/maintenance.md` to keep them updated.

## Non-negotiables
- Planning and execution are SEPARATE -- no code during planning
- Execute ONLY one phase at a time
- STOP after every phase -- no auto-continue
- Verification is mandatory for every phase
- No scope creep, no unrelated refactors

## Danger Zones (hard stop, ask first)
- Auth/authz/permissions
- DB schema or migrations
- Money/billing/payments
- Production config/secrets
- Multi-tenant data isolation
- Background jobs affecting data integrity

## Context Loading -- DO NOT READ EVERYTHING

**Before loading context:** If this is the first planning run or if `architecture/`, `infrastructure/`, or `features/` files are missing or empty, do [Project onboarding](#project-onboarding-first-planning) first so those files exist and reflect the project.

**Prefer retrieval when available:** If the project has a **vector DB** or a **reduced context index** (see `workflow/context-retrieval.md`), use it to get only relevant chunks/sections instead of loading full files. That gives more and better context without sending more tokens. Query by task type + ticket; use returned chunks as “Context loaded”; cite source and section. If retrieval is not set up, use the file-based flow below.

**Otherwise read `workflow/context-router.md`** -- it tells you exactly which files to load based on your current task type and workflow state. Load only those files, not everything.

DO NOT read all files below. Either:
- **Retrieval path:** Query vector store / reduced index → get relevant chunks → use those as context; or
- **File path:** Context router maps task type + workflow state → which files to load → load only those

### Available Knowledge Files

Use these via retrieval when available, or via `workflow/context-router.md` when using the file-based path.
**Infrastructure** (environment & setup)
- `infrastructure/environment.md` → runtime, versions, DB, env vars
- `infrastructure/dependencies.md` → gems, external services, APIs
- `infrastructure/tooling.md` → linters, test commands, CI/CD
- `infrastructure/deployment.md` → hosting, deploy process
- `infrastructure/security.md` → auth boundaries, tenant scoping, OWASP rules

**Architecture** (technical design)
- `architecture/system-design.md` → components, data flows, tenancy
- `architecture/database.md` → schema, tables, relationships
- `architecture/api-design.md` → endpoints, response shapes, versioning
- `architecture/patterns.md` → design patterns, conventions, quality checklist
- `architecture/error-handling.md` → HTTP codes, error shapes, exception mapping
- `architecture/data-flow.md` → request lifecycle, middleware, auth/authz pipeline
- `architecture/glossary.md` → domain terms, roles, statuses

**Features** (how things work)
- `features/` → one file per feature describing current behavior
- `features/_CONVENTIONS.md` → serialization, query, and test patterns

**Workflow** (how we work)
- `workflow/context-retrieval.md` → **Use first when available:** vector DB or reduced index for token-efficient context
- `workflow/context-router.md` → When not using retrieval: maps task type → required files
- `workflow/initialise.md` → scan project and fill knowledge files (run first or when empty)
- `workflow/planning.md` → how to create phased plans
- `workflow/execution.md` → how to execute a single phase
- `workflow/implementation.md` → coding conventions, file locations
- `workflow/testing.md` → verification commands
- `workflow/reviewer.md` → structured code review post-implementation (Approve/Request changes)
- `workflow/ticket-access.md` → how to fetch tickets
- `workflow/maintenance.md` → what to update after completing a ticket
- `workflow/prompts.md` → pre-built prompts for common tasks

## Context Flow Across States
```
PLANNING:
  If retrieval: query vector/index with task type + ticket → use chunks as context
  Else: read context-router.md → load task-specific files
  → output "Context Loaded" in plan

EXECUTION:
  Use plan's "Context Loaded" + phase's "Context needed" + implementation.md
  (don't re-discover; if retrieval, query again only if phase needs extra scope)

TESTING:
  Read: testing.md + plan's phase verification commands
  (minimal context -- just run the commands)

MAINTENANCE:
  Read: maintenance.md → update only the files that changed
  If retrieval: re-index / regenerate reduced index after knowledge file updates
  (targeted updates, not a full scan)
```

## Maintenance Rule
After every ticket: update `infrastructure/`, `architecture/`, or `features/` as needed.
See `workflow/maintenance.md` for the full decision matrix.

## Fallback
If you cannot access any referenced files, ask the user to paste them. Do not guess.
