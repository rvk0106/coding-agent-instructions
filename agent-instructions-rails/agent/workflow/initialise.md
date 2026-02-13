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
- **Layout:** `app/`, `config/`, `db/`, `spec/`, `lib/`, `app/views/`, `app/javascript/`, engines if present
- **Entry points:** `config/routes.rb`, `config/application.rb`, Gemfile, README, `Procfile.dev`
- **Key config:** database.yml, environments, initialisers relevant to architecture
- **Frontend:** `app/views/layouts/`, `app/assets/`, `app/javascript/controllers/` (Stimulus)

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | Gemfile, config | Ruby/Rails versions, key gems (auth, DB, jobs, Turbo, CSS) |
| **Schema** | db/schema.rb, app/models | Tables, relationships, indexes, migration conventions |
| **Routes** | config/routes.rb | URL structure, namespaces, resource routes, named paths |
| **Views** | app/views/, app/helpers/ | Template engine, layout structure, partial conventions, Turbo usage |
| **Frontend** | app/javascript/, config/importmap.rb, package.json | JS bundling, Stimulus controllers, CSS framework |
| **Conventions** | app/controllers, app/services, app/models | Controller thin? Services where? View patterns? |
| **Auth / tenant** | application_controller, policies, Devise config | Auth mechanism, tenant/scope patterns |
| **Testing** | spec/spec_helper.rb, spec/rails_helper.rb, Gemfile | RSpec version, Capybara, factories, coverage |
| **Ops** | README, Rakefile, config, .github | Test command, lint command, CI, deploy hints |

### 3. Fill knowledge files
Populate from discovery. Create or update only these; leave workflow files as provided by install unless clearly empty and project-specific.

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Components, data flow, frontend stack, tenancy from app structure and config |
| **architecture/database.md** | Schema, tables, relations, migration rules from db/schema.rb and models |
| **architecture/views.md** | Layouts, partials, helpers, Turbo/Stimulus patterns from app/views and app/javascript |
| **architecture/routing.md** | Routes, URL design, namespaces from config/routes.rb |
| **architecture/patterns.md** | Controller/service/view conventions from code |
| **architecture/error-handling.md** | Flash patterns, error pages, rescue chains from controllers |
| **architecture/data-flow.md** | Request lifecycle, Turbo flow, middleware from application_controller |
| **architecture/glossary.md** | Domain terms, roles, statuses from models and business logic |
| **infrastructure/environment.md** | Ruby/Rails versions, DB, asset pipeline, env vars from Gemfile and config |
| **infrastructure/dependencies.md** | Gems, external services from Gemfile and config |
| **infrastructure/tooling.md** | Linters, test commands, CI from config, README, and spec helpers |
| **infrastructure/deployment.md** | Hosting, deploy process if present |
| **infrastructure/security.md** | Auth boundaries, CSRF, XSS, tenant scoping from code |
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
- architecture/views.md
- architecture/routing.md
- [list others]

Optional: Vector index updated (if applicable).

Next: Run `plan architecture for TICKET-ID` when ready.
```

## After Initialise
- Do not re-run on every ticket. Use `workflow/maintenance.md` to keep knowledge files updated after each ticket.
- Re-run initialise only when knowledge files are missing, empty, or the project has changed significantly.
