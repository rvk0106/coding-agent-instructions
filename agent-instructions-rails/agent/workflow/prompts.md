# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New Page / View | `plan architecture for TICKET-ID` then use "New Page / View" below |
| New Form | Use "New Form" prompt below |
| New Model / DB Change | Use "New Model / DB Change" prompt below |
| Bug Fix | `plan architecture for TICKET-ID` then use "Bug Fix" below |
| Background Job | Use "Background Job" prompt below |
| Auth / Permissions Change | Use "Auth / Permissions Change" prompt below |
| Turbo / Stimulus Feature | Use "Turbo / Stimulus Feature" prompt below |
| Mailer | Use "Mailer" prompt below |
| Refactor | Use "Refactor" prompt below |
| Migration Only | Use "Migration Only" prompt below |

---

## New Page / View
```
Add a new page:
- Page: [name/description]
- Route: /[path]
- Controller: [controller name]
- Auth required: [yes/no]
- Layout: [default/admin/custom]
- Turbo Frames: [yes/no — list frames if yes]

Before implementing, read context-router.md -> "New Page / View" for full file list.

Create: route, controller action, view template, partials (if needed), system spec.
Verify: bundle exec rspec spec/system/... && bundle exec rubocop
```

## New Form
```
Add a new form:
- Resource: [model name]
- Actions: [new/create or edit/update or both]
- Fields: [list with types]
- Validations: [presence, uniqueness, etc.]
- Turbo: [yes — Turbo Stream response / no — standard redirect]

Before implementing, read context-router.md -> "New Form" for full file list.

Create: controller actions, form partial, view templates, request/system specs.
Verify: bundle exec rspec spec/requests/... spec/system/... && bundle exec rubocop
```

## New Model / DB Change
```
Add a new model:
- Model: [name]
- Table: [table_name]
- Columns: [list with types]
- Associations: [belongs_to, has_many, etc.]
- Validations: [presence, uniqueness, etc.]
- Indexes: [list]

Before implementing, read context-router.md -> "New Model / DB Change" for full file list.

Create: migration, model, model spec, factory.
Verify: rails db:migrate && bundle exec rspec spec/models/... && bundle exec rubocop
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/area if known]

Before implementing, read context-router.md -> "Bug Fix" for full file list.

Steps: reproduce -> identify root cause -> fix -> add regression test.
Verify: bundle exec rspec [relevant specs] && bundle exec rubocop
```

## Background Job
```
Add a background job:
- Job: [name]
- Trigger: [what causes it to run]
- Action: [what it does]
- Idempotent: [must be safe to retry]
- Queue: [default/critical/low]

Before implementing, read context-router.md -> "Background Job" for full file list.

Create: job class, job spec, enqueue from service/controller.
Verify: bundle exec rspec spec/jobs/... && bundle exec rubocop
```

## Auth / Permissions Change
```
Add authorization:
- Resource: [model name]
- Actions: [which actions need authorization]
- Roles: [who can do what]

Before implementing, read context-router.md -> "Auth / Permissions Change" for full file list.

Create: policy class, policy spec, add authorize call in controller, update views if needed.
Verify: bundle exec rspec spec/policies/... spec/system/... && bundle exec rubocop
```

## Turbo / Stimulus Feature
```
Add Turbo/Stimulus interaction:
- Feature: [what the interaction does]
- Type: [Turbo Frame / Turbo Stream / Stimulus controller / combination]
- Trigger: [user action that starts it]
- Target: [DOM element(s) affected]

Before implementing, read context-router.md -> "Turbo / Stimulus Feature" for full file list.

Create: Turbo frame/stream templates, Stimulus controller (if needed), controller respond_to, system spec.
Verify: bundle exec rspec spec/system/... && bundle exec rubocop
```

## Mailer
```
Add mailer:
- Mailer: [name]
- Method: [action name]
- Trigger: [when is it sent]
- Template: [HTML + text]

Before implementing, read context-router.md -> "Mailer" for full file list.

Create: mailer class, mailer views, mailer spec, enqueue with deliver_later.
Verify: bundle exec rspec spec/mailers/... && bundle exec rubocop
```

## Refactor
```
Refactor:
- Target: [file/class/method]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md -> "Refactor" for full file list.

Steps: ensure test coverage -> refactor -> verify tests still pass.
Verify: bundle exec rspec && bundle exec rubocop
```

## Migration Only
```
Add migration:
- Change: [add column/table/index/rename/remove]
- Table: [name]
- Details: [columns, types, constraints]
- Rollback plan: [how to undo]

Before implementing, read context-router.md -> "Migration Only" for full file list.
DANGER ZONE: get human approval before running.

Create: migration file, update model if needed, update specs.
Verify: rails db:migrate && rails db:rollback STEP=1 && rails db:migrate
```
