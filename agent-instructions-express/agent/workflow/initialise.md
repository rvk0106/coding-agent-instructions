# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess -- discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `src/`, `config/`, `prisma/` or `models/`, `test/` or `__tests__/`, `dist/`
- **Entry points:** `package.json`, `src/app.js` or `src/app.ts`, `src/server.js` or `src/server.ts`
- **Key config:** `tsconfig.json`, `.env.example`, ESLint config, Docker files

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | package.json | Node.js version, key deps (express, ORM, auth, testing) |
| **Schema** | prisma/schema.prisma, src/models/, migrations/ | Tables/collections, relationships, indexes |
| **API** | src/routes/, src/controllers/ | Endpoints, HTTP methods, response shapes, middleware |
| **Conventions** | src/controllers/, src/services/, src/middleware/ | Controller thin? Services where? Validation patterns? |
| **Auth** | src/middleware/auth*, package.json | Auth mechanism (JWT/session/passport), RBAC pattern |
| **Testing** | jest.config.js, vitest.config.ts, test/, package.json | Test framework, Supertest usage, test structure |
| **Ops** | package.json scripts, README, .github/, Dockerfile | Test command, lint command, CI, deploy hints |

### 3. Fill knowledge files
Populate from discovery. Create or update only these; leave workflow files as provided by install unless clearly empty and project-specific.

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Components, data flow from app structure and config |
| **architecture/database.md** | Schema, tables, relations, migration rules from models/prisma/migrations |
| **architecture/api-design.md** | Endpoints, request/response shapes, versioning from routes and controllers |
| **architecture/patterns.md** | Route/controller/service/middleware conventions from code |
| **architecture/error-handling.md** | HTTP codes, error payloads from error middleware and controllers |
| **architecture/data-flow.md** | Request lifecycle, middleware chain from app.js and middleware/ |
| **architecture/glossary.md** | Domain terms, roles, statuses from models and business logic |
| **infrastructure/environment.md** | Node/Express versions, DB, env vars from package.json and config |
| **infrastructure/dependencies.md** | npm packages, external services from package.json and config |
| **infrastructure/tooling.md** | Linters, test commands, CI from config, README, and package.json |
| **infrastructure/deployment.md** | Hosting, deploy process if present |
| **infrastructure/security.md** | Auth boundaries, query scoping, helmet/cors config from code |
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
