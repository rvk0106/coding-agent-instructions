# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge, django
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
- **Layout:** `apps/`, `project/`, `manage.py`, `requirements/`, `templates/` (if any)
- **Entry points:** `manage.py`, `project/urls.py`, `project/settings.py` (or `settings/base.py`), `requirements.txt` or `pyproject.toml`
- **Key config:** settings (INSTALLED_APPS, DATABASES, REST_FRAMEWORK, AUTH_USER_MODEL, MIDDLEWARE)

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | requirements.txt / pyproject.toml, settings | Python/Django/DRF versions, key packages (auth, DB, jobs, API docs) |
| **Schema** | apps/*/models.py, migrations | Models, relationships, indexes, migration conventions |
| **API** | project/urls.py, apps/*/urls.py, apps/*/views.py, apps/*/serializers.py | Endpoints, HTTP methods, response shapes, error handling |
| **Conventions** | apps/*/views.py, apps/*/serializers.py, apps/*/models.py | Fat models or services? Serializer patterns? ViewSet vs APIView? |
| **Auth / tenant** | settings (AUTH_USER_MODEL, REST_FRAMEWORK auth classes), apps/*/permissions.py | Auth mechanism, permission patterns, CORS settings |
| **Testing** | conftest.py / apps/*/tests/, requirements (pytest-django, factory-boy) | Test framework, fixtures/factories, coverage tool |
| **Ops** | README, Makefile/Procfile, .github/, Dockerfile | Test command, lint command, CI, deploy hints |

### 3. Fill knowledge files
Populate from discovery. Create or update only these; leave workflow files as provided by install unless clearly empty and project-specific.

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Components, data flow, project structure from settings and apps |
| **architecture/database.md** | Models, tables, relations, migration rules from models.py and migrations |
| **architecture/api-design.md** | Endpoints, request/response shapes, versioning from urls.py and views |
| **architecture/patterns.md** | View/serializer/model conventions from code |
| **architecture/error-handling.md** | HTTP codes, error payloads from views and custom exception handler |
| **architecture/data-flow.md** | Request lifecycle, middleware, DRF pipeline from settings and views |
| **architecture/glossary.md** | Domain terms, roles, statuses from models and business logic |
| **infrastructure/environment.md** | Python/Django versions, DB, env vars from requirements and settings |
| **infrastructure/dependencies.md** | Packages, external services from requirements and settings |
| **infrastructure/tooling.md** | Linters, test commands, CI from config, README, conftest |
| **infrastructure/deployment.md** | Hosting, deploy process if present |
| **infrastructure/security.md** | Auth boundaries, query scoping, CORS/CSRF from code and settings |
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
