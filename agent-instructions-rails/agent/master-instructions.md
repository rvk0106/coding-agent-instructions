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

## Context Loading -- DO NOT READ EVERYTHING

**Read `workflow/context-router.md` FIRST** -- it tells you exactly which files to load
based on your current task type and workflow state.

DO NOT read all files below. The context router maps:
- Task type (new endpoint, bug fix, model change...) → which files to load
- Workflow state (planning, execution, testing, maintenance) → which files to load

### Available Knowledge Files (load via context-router only)

**Infrastructure** (environment & setup)
- `infrastructure/environment.md` → runtime, versions, DB, env vars
- `infrastructure/dependencies.md` → gems, external services, APIs
- `infrastructure/tooling.md` → linters, test commands, CI/CD
- `infrastructure/deployment.md` → hosting, deploy process
- `infrastructure/security.md` → auth, tenant scoping, headers, CSRF, rate limiting

**Architecture** (technical design)
- `architecture/system-design.md` → components, data flows, tenancy
- `architecture/database.md` → schema, tables, relationships
- `architecture/api-design.md` → endpoints, response shapes, versioning
- `architecture/patterns.md` → design patterns, conventions, quality checklist
- `architecture/error-handling.md` → HTTP codes, error shapes, exception mapping
- `architecture/data-flow.md` → request lifecycle, middleware, transactions
- `architecture/glossary.md` → domain terms, roles, statuses

**Features** (how things work)
- `features/` → one file per feature describing current behavior
- `features/_CONVENTIONS.md` → serialization, query, and test patterns

**Workflow** (how we work)
- `workflow/context-router.md` → READ FIRST: maps task type → required files
- `workflow/planning.md` → how to create phased plans
- `workflow/execution.md` → how to execute a single phase
- `workflow/implementation.md` → coding conventions, file locations
- `workflow/testing.md` → verification commands
- `workflow/ticket-access.md` → how to fetch tickets
- `workflow/ticketing-systems.md` → curl/jq helpers for Linear/Jira/GitHub (when MCP not configured)
- `workflow/maintenance.md` → what to update after completing a ticket
- `workflow/prompts.md` → pre-built prompts for common tasks

## Context Flow Across States
```
PLANNING:
  Read: context-router.md → load task-specific files → output "Context Loaded" in plan

EXECUTION:
  Read: plan's "Context Loaded" + phase's "Context needed" + implementation.md
  (don't re-discover -- the plan already tells you what's relevant)

TESTING:
  Read: testing.md + plan's phase verification commands
  (minimal context -- just run the commands)

MAINTENANCE:
  Read: maintenance.md → update only the files that changed
  (targeted updates, not a full scan)
```

## Maintenance Rule
After every ticket: update `infrastructure/`, `architecture/`, or `features/` as needed.
See `workflow/maintenance.md` for the full decision matrix.

## Fallback
If you cannot access any referenced files, ask the user to paste them. Do not guess.
