# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New API Endpoint | `plan api for TICKET-ID` then use "New API Endpoint" below |
| New Entity / DB Change | Use "New Entity / DB Change" prompt below |
| Bug Fix | `plan api for TICKET-ID` then use "Bug Fix" below |
| Background Job | Use "Background Job" prompt below |
| Auth / Permissions Change | Use "Auth / Permissions Change" prompt below |
| Refactor | Use "Refactor" prompt below |
| Migration Only | Use "Migration Only" prompt below |
| Dependency Change | Use "Dependency Change" prompt below |

---

## New API Endpoint
```
Add a new REST endpoint:
- Resource: [name]
- Actions: [GET list / GET by ID / POST create / PUT update / DELETE]
- Path: /api/v1/[resource]
- Auth required: [yes/no]
- Admin only: [yes/no]

Before implementing, read context-router.md --> "New API Endpoint" for full file list.

Create: controller, request/response DTOs, service, repository (if new entity), integration tests.
Verify: ./mvnw test -Dtest=...ControllerTest && ./mvnw checkstyle:check
```

## New Entity / DB Change
```
Add a new entity:
- Entity: [name]
- Table: [table_name]
- Columns: [list with types]
- Relationships: [@ManyToOne, @OneToMany, etc.]
- Validations: [@NotNull, @Size, @Email, etc.]
- Indexes: [list]

Before implementing, read context-router.md --> "New Model / DB Change" for full file list.

Create: entity class, repository, migration (Flyway/Liquibase), repository test.
Verify: ./mvnw test -Dtest=...RepositoryTest && ./mvnw clean compile
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/class if known]

Before implementing, read context-router.md --> "Bug Fix" for full file list.

Steps: reproduce --> identify root cause --> fix --> add regression test.
Verify: ./mvnw test -Dtest=[relevant tests] && ./mvnw checkstyle:check
```

## Background Job
```
Add a background/async task:
- Task: [name]
- Trigger: [what causes it to run -- @Scheduled, event, message]
- Action: [what it does]
- Idempotent: [must be safe to retry]
- Queue/topic: [if using message broker]

Before implementing, read context-router.md --> "Background Job / Async Task" for full file list.

Create: @Async method or @Scheduled task or message listener, unit tests.
Verify: ./mvnw test -Dtest=...TaskTest && ./mvnw checkstyle:check
```

## Auth / Permissions Change
```
Add authorization:
- Resource: [entity/endpoint name]
- Actions: [which actions need authorization]
- Roles: [who can do what -- ROLE_ADMIN, ROLE_USER, etc.]

Before implementing, read context-router.md --> "Auth / Permissions Change" for full file list.

Create: @PreAuthorize annotations or SecurityFilterChain rules, integration tests for 403 scenarios.
Verify: ./mvnw test -Dtest=...SecurityTest && ./mvnw checkstyle:check
```

## Refactor
```
Refactor:
- Target: [class/package/method]
- Reason: [why -- too large, duplicated, violates SRP, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md --> "Refactor" for full file list.

Steps: ensure test coverage --> refactor --> verify tests still pass.
Verify: ./mvnw clean verify
```

## Migration Only
```
Add database migration:
- Change: [add column/table/index/rename/remove]
- Table: [name]
- Details: [columns, types, constraints]
- Rollback plan: [how to undo]

Before implementing, read context-router.md --> "Migration Only" for full file list.
DANGER ZONE: get human approval before running.

Create: Flyway/Liquibase migration file, update entity if needed, update tests.
Verify: ./mvnw flyway:migrate && ./mvnw flyway:info (or Liquibase equivalent)
```

## Dependency Change
```
Add/update dependency:
- Dependency: [groupId:artifactId]
- Version: [version or Spring Boot managed]
- Purpose: [why needed]
- Breaking changes: [any known issues]

Steps: add to pom.xml/build.gradle --> verify build --> update infrastructure/dependencies.md.
Verify: ./mvnw clean verify
```
