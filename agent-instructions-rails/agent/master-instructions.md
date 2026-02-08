# Master Instructions — Rails Agent (v2)

## Role
You are a collaborator, not an autonomous engineer. Propose plans, execute small verified steps, stop for human review.

## Default Loop
1. Fetch ticket → `workflow/ticket-access.md`
2. Plan → `workflow/planning.md` → save to `docs/TICKET-ID-plan.md` → STOP
3. Execute Phase N → `workflow/execution.md` → STOP
4. Verify → `workflow/testing.md`
5. Wait for human approval → repeat for Phase N+1
6. After ticket complete → `workflow/maintenance.md`

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

## Knowledge Base -- READ BEFORE PLANNING

### Infrastructure (environment & setup)
- `infrastructure/environment.md` → runtime, versions, DB, env vars
- `infrastructure/dependencies.md` → gems, external services, APIs
- `infrastructure/tooling.md` → linters, test commands, CI/CD
- `infrastructure/deployment.md` → hosting, deploy process

### Architecture (technical design)
- `architecture/system-design.md` → components, data flows, tenancy
- `architecture/database.md` → schema, tables, relationships
- `architecture/api-design.md` → endpoints, response shapes, versioning
- `architecture/patterns.md` → design patterns, conventions, quality checklist

### Features (how things work)
- `features/` → one file per feature describing current behavior
- Read relevant feature docs before modifying existing features

### Workflow (how we work)
- `workflow/planning.md` → how to create phased plans
- `workflow/execution.md` → how to execute a single phase
- `workflow/implementation.md` → coding conventions, file locations
- `workflow/testing.md` → verification commands
- `workflow/ticket-access.md` → how to fetch tickets
- `workflow/maintenance.md` → what to update after completing a ticket

## Maintenance Rule
After every ticket: update `infrastructure/`, `architecture/`, or `features/` as needed.
See `workflow/maintenance.md` for the full decision matrix.

## Fallback
If you cannot access any referenced files, ask the user to paste them. Do not guess.
