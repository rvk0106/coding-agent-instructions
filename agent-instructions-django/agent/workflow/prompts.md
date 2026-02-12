# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts, django
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New API Endpoint | `plan architecture for TICKET-ID` then use "New API Endpoint" below |
| Bug Fix | `plan architecture for TICKET-ID` then use "Bug Fix" below |
| New Model / DB Change | Use "New Model / DB Change" prompt below |
| Celery Task | Use "Celery Task" prompt below |
| Auth / Permissions Change | Use "Auth / Permissions Change" prompt below |
| Refactor | Use "Refactor" prompt below |
| Migration Only | Use "Migration Only" prompt below |

---

## New API Endpoint
```
Add a new REST endpoint:
- Resource: [name]
- Actions: [list/retrieve/create/update/partial_update/destroy]
- Path: /api/v1/[resource]/
- Auth required: [yes/no]
- Admin only: [yes/no]
- Filters: [fields to filter on]

Before implementing, read context-router.md -> "New API Endpoint" for full file list.

Create: serializer, viewset, URL route, permission class (if needed), tests.
Verify: pytest apps/app_name/tests/test_views.py && flake8 apps/app_name/
```

## New Model / DB Change
```
Add a new model:
- Model: [name]
- App: [app_name]
- Fields: [list with types, e.g. name: CharField(max_length=255)]
- Relationships: [ForeignKey, ManyToMany, OneToOne]
- Indexes: [list]
- Constraints: [unique, check, etc.]

Before implementing, read context-router.md -> "New Model / DB Change" for full file list.

Create: model, migration, factory, model tests.
Verify: python manage.py makemigrations --check && pytest apps/app_name/tests/test_models.py && flake8 apps/app_name/
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [app/file if known]

Before implementing, read context-router.md -> "Bug Fix" for full file list.

Steps: reproduce -> identify root cause -> fix -> add regression test.
Verify: pytest apps/[app]/tests/ && flake8 apps/[app]/
```

## Celery Task
```
Add a Celery task:
- Task: [name]
- Trigger: [what causes it to run -- signal, view action, schedule]
- Action: [what it does]
- Idempotent: [must be safe to retry]
- Queue: [default/critical/low]
- Retry: [max retries, backoff strategy]

Before implementing, read context-router.md -> "Celery Task" for full file list.

Create: task in tasks.py, task tests, enqueue from view/signal.
Verify: pytest apps/app_name/tests/test_tasks.py && flake8 apps/app_name/
```

## Auth / Permissions Change
```
Add authorization:
- Resource: [model name]
- Actions: [which actions need authorization]
- Roles: [who can do what]
- Permission class: [custom or DRF built-in]

Before implementing, read context-router.md -> "Auth / Permissions Change" for full file list.

Create: permission class, permission tests, apply to viewset.
Verify: pytest apps/app_name/tests/test_permissions.py && flake8 apps/app_name/
```

## Refactor
```
Refactor:
- Target: [file/class/function]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md -> "Refactor" for full file list.

Steps: ensure test coverage -> refactor -> verify tests still pass.
Verify: pytest && flake8
```

## Migration Only
```
Add migration:
- Change: [add column/model/index/rename/remove]
- App: [app_name]
- Details: [fields, types, constraints]
- Rollback plan: [how to undo]

Before implementing, read context-router.md -> "Migration Only" for full file list.
DANGER ZONE: get human approval before running.

Create: migration file, update model if needed, update tests.
Verify: python manage.py migrate && python manage.py migrate app_name zero && python manage.py migrate
```
