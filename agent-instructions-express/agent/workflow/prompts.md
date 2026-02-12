# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common Express.js tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New API Endpoint | `plan architecture for TICKET-ID` then use "New API Endpoint" below |
| Bug Fix | `plan architecture for TICKET-ID` then use "Bug Fix" below |
| New Model / DB Change | Use "New Model / DB Change" prompt below |
| Background Job | Use "Background Job" prompt below |
| Auth / Permissions Change | Use "Auth / Permissions Change" prompt below |
| Refactor | Use "Refactor" prompt below |
| Migration Only | Use "Migration Only" prompt below |

---

## New API Endpoint
```
Add a new REST endpoint:
- Resource: [name]
- Actions: [list/get/create/update/delete]
- Path: /api/v1/[resource]
- Auth required: [yes/no]
- Admin only: [yes/no]

Before implementing, read context-router.md --> "New API Endpoint" for full file list.

Create: route file, controller, service (if business logic), validation middleware, Supertest specs.
Verify: npm test -- --testPathPattern=... && npm run lint
```

## New Model / DB Change
```
Add a new model:
- Model: [name]
- Table: [table_name]
- Columns: [list with types]
- Associations: [belongsTo, hasMany, etc.]
- Validations: [required fields, unique constraints]
- Indexes: [list]

Before implementing, read context-router.md --> "New Model / DB Change" for full file list.

Create: migration, model definition, model/service tests.
Verify (Sequelize): npx sequelize-cli db:migrate && npm test && npm run lint
Verify (Prisma): npx prisma migrate dev && npm test && npm run lint
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/area if known]

Before implementing, read context-router.md --> "Bug Fix" for full file list.

Steps: reproduce --> identify root cause --> fix --> add regression test.
Verify: npm test -- --testPathPattern=[relevant] && npm run lint
```

## Background Job
```
Add a background job:
- Job: [name]
- Trigger: [what causes it to run]
- Action: [what it does]
- Idempotent: [must be safe to retry]
- Queue: [default/critical/low]

Before implementing, read context-router.md --> "Background Job" for full file list.

Create: worker file, job processor, job tests.
Verify: npm test -- --testPathPattern=jobs && npm run lint
```

## Auth / Permissions Change
```
Add authorization:
- Resource: [model name]
- Actions: [which actions need authorization]
- Roles: [who can do what]

Before implementing, read context-router.md --> "Auth / Permissions Change" for full file list.

Create: auth middleware (or update existing), role-checking middleware, middleware tests, update route to use middleware.
Verify: npm test -- --testPathPattern=auth && npm run lint
```

## Refactor
```
Refactor:
- Target: [file/module/function]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md --> "Refactor" for full file list.

Steps: ensure test coverage --> refactor --> verify tests still pass.
Verify: npm test && npm run lint
```

## Migration Only
```
Add migration:
- Change: [add column/table/index/rename/remove]
- Table: [name]
- Details: [columns, types, constraints]
- Rollback plan: [how to undo]

Before implementing, read context-router.md --> "Migration Only" for full file list.
DANGER ZONE: get human approval before running.

Create: migration file, update model if needed.
Verify (Sequelize): npx sequelize-cli db:migrate && npx sequelize-cli db:migrate:undo && npx sequelize-cli db:migrate
Verify (Prisma): npx prisma migrate dev && npx prisma migrate reset
```
