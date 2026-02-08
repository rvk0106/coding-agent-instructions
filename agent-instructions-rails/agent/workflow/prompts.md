# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns

## Quick Reference
| Task | Prompt |
|------|--------|
| Add API endpoint | `plan architecture for TICKET-ID` then use "New Endpoint" below |
| Fix bug | `plan architecture for TICKET-ID` then use "Bug Fix" below |
| Add model | Use "New Model" prompt below |
| Add background job | Use "New Job" prompt below |
| Refactor | Use "Refactor" prompt below |

---

## New Endpoint
```
Add a new REST endpoint:
- Resource: [name]
- Actions: [index/show/create/update/destroy]
- Path: /api/v1/[resource]
- Auth required: [yes/no]
- Admin only: [yes/no]

Before implementing, read:
- architecture/api-design.md for response shape
- architecture/error-handling.md for error patterns
- architecture/data-flow.md for request lifecycle
- architecture/patterns.md for controller/service conventions

Create: controller, strong params, service (if business logic), request specs, route.
Verify: bundle exec rspec spec/requests/... && bundle exec rubocop
```

## New Model
```
Add a new model:
- Model: [name]
- Table: [table_name]
- Columns: [list with types]
- Associations: [belongs_to, has_many, etc.]
- Validations: [presence, uniqueness, etc.]
- Indexes: [list]

Before implementing, read:
- architecture/database.md for schema conventions
- architecture/patterns.md for model patterns

Create: migration, model, model spec, factory.
Verify: rails db:migrate && bundle exec rspec spec/models/... && bundle exec rubocop
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/area if known]

Before implementing, read:
- features/[relevant-feature].md for how it should work
- architecture/error-handling.md if error-related
- architecture/data-flow.md if flow-related

Steps: reproduce → identify root cause → fix → add regression test.
Verify: bundle exec rspec [relevant specs] && bundle exec rubocop
```

## New Background Job
```
Add a background job:
- Job: [name]
- Trigger: [what causes it to run]
- Action: [what it does]
- Idempotent: [must be safe to retry]
- Queue: [default/critical/low]

Before implementing, read:
- architecture/data-flow.md for job flow
- architecture/patterns.md for job conventions

Create: job class, job spec, enqueue from service/controller.
Verify: bundle exec rspec spec/jobs/... && bundle exec rubocop
```

## Add Authorization Policy
```
Add authorization:
- Resource: [model name]
- Actions: [which actions need authorization]
- Roles: [who can do what]

Before implementing, read:
- architecture/data-flow.md for auth flow
- architecture/glossary.md for role definitions

Create: policy class, policy spec, add authorize call in controller.
Verify: bundle exec rspec spec/policies/... && bundle exec rubocop
```

## Refactor
```
Refactor:
- Target: [file/class/method]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read:
- architecture/patterns.md for target patterns
- features/[relevant].md to understand current behavior

Steps: ensure test coverage → refactor → verify tests still pass.
Verify: bundle exec rspec && bundle exec rubocop
```

## Database Migration
```
Add migration:
- Change: [add column/table/index/rename/remove]
- Table: [name]
- Details: [columns, types, constraints]
- Rollback plan: [how to undo]

Before implementing, read:
- architecture/database.md for schema conventions
- DANGER ZONE: get human approval before running

Create: migration file, update model if needed, update specs.
Verify: rails db:migrate && rails db:rollback STEP=1 && rails db:migrate
```
