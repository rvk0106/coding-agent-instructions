# Planning
> Tags: plan, architecture, phases, ticket
> Scope: How to create a phased plan from a ticket
> Trigger: `plan architecture for TICKET-ID`

## Rules
- NO code during planning
- Phases must be small (~10 min each), reversible, independently verifiable
- Output goes to `docs/TICKET-ID-plan.md`
- STOP after plan is written -- wait for human approval

## Planning Steps
1. **Fetch ticket** → see `workflow/ticket-access.md`
2. **Read project knowledge** → scan `architecture/` and `infrastructure/` folders
3. **Analyze codebase** → check files listed in Pre-Analysis below
4. **Check if changes needed** → can existing code fulfill requirements?
5. **Plan for reuse** → identify existing methods/services to leverage
6. **Write phased plan** → save to `docs/TICKET-ID-plan.md`

## Pre-Analysis Checklist (Rails)
- `db/schema.rb` → current schema, plan DB changes
- `config/routes.rb` → routing patterns, namespaces
- `app/controllers/` → controller patterns, base classes
- `app/models/` → associations, validations, concerns
- `app/services/` → service object conventions
- `spec/` → test patterns, factories
- `.rubocop.yml` → lint rules
- `architecture/` → read `database.md`, `api-design.md`, `patterns.md`
- `features/` → read related feature docs if they exist

## Danger Zones (must flag in plan)
- Auth/authz/permissions
- DB migrations/schema changes
- Money/billing/payments
- Production config/secrets
- Multi-tenant data isolation
- Background jobs mutating data

## Plan Format
```
docs/TICKET-ID-plan.md:
## Ticket Metadata → ID, title, owner, priority
## Requirements → acceptance criteria, constraints, non-goals
## Architecture Decisions → trade-offs, affected areas
## Current State → what exists, what's missing
## Phase N → for each phase:
  - Goal (1 line)
  - Tasks (bullet list)
  - Allowed files
  - Forbidden changes
  - Verify commands
  - Acceptance criteria
## Next Step → `execute plan 1 for TICKET-ID`
```
