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
1. **Fetch ticket** --> see `workflow/ticket-access.md`
2. **Classify task type** --> new endpoint? bug fix? model change? refactor? background job?
3. **Load context via router** --> read `workflow/context-router.md` PLANNING section, load ONLY the files listed for your task type
4. **Analyze codebase** --> check relevant project files (see below)
5. **Check if changes needed** --> can existing code fulfill requirements?
6. **Plan for reuse** --> identify existing services/middleware/utils to leverage
7. **Write phased plan** --> save to `docs/TICKET-ID-plan.md`
8. **List context loaded** --> include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new endpoint, bug fix, model change, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (Express)
After loading instruction context, check these project files as relevant:
- `package.json` --> dependencies, scripts, Node/npm versions
- `src/routes/` --> routing patterns, middleware usage (if API-related)
- `src/controllers/` --> controller patterns (if endpoint-related)
- `src/services/` --> service conventions (if business logic)
- `src/models/` --> model definitions, associations (if model-related)
- `src/middleware/` --> existing middleware (if auth/validation-related)
- `prisma/schema.prisma` or `src/models/` --> schema (if DB-related)
- `src/__tests__/` or `test/` --> test patterns, setup (if writing tests)
- `features/[name].md` --> related feature docs (if modifying existing feature)

## Danger Zones (must flag in plan)
- Auth/authz/permissions middleware
- DB migrations/schema changes
- Money/billing/payments
- Production config/secrets
- Data scoping / user isolation boundaries
- Background jobs mutating data
- CORS/security configuration changes

## Plan Output Format
```
docs/TICKET-ID-plan.md:

## Context Loaded                       <-- list exactly which files were read
- architecture/api-design.md
- architecture/error-handling.md
- [etc.]

## Ticket Metadata --> ID, title, owner, priority
## Requirements --> acceptance criteria, constraints, non-goals
## Architecture Decisions --> trade-offs, affected areas
## Current State --> what exists, what's missing

## Phase N --> for each phase:
  - Goal (1 line)
  - Tasks (bullet list)
  - Allowed files
  - Forbidden changes
  - Verify commands
  - Acceptance criteria
  - Context needed --> which instruction files to read during execution

## Next Step --> `execute plan 1 for TICKET-ID`
```
