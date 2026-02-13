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
1. **Fetch ticket** -> see `workflow/ticket-access.md`
2. **Classify task type** -> new page? new form? bug fix? model change? Turbo feature? refactor? etc.
3. **Load context via router** -> read `workflow/context-router.md` PLANNING section, load ONLY the files listed for your task type
4. **Analyze codebase** -> check relevant project files (see below)
5. **Check if changes needed** -> can existing code fulfill requirements?
6. **Plan for reuse** -> identify existing methods/services/partials to leverage
7. **Write phased plan** -> save to `docs/TICKET-ID-plan.md`
8. **List context loaded** -> include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new page, new form, bug fix, model change, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (Rails Full-Stack)
After loading instruction context, check these project files as relevant:
- `db/schema.rb` -> current schema (if DB-related)
- `config/routes.rb` -> routing patterns (if adding routes/pages)
- `app/controllers/` -> controller patterns (if modifying controllers)
- `app/models/` -> associations, validations (if model-related)
- `app/services/` -> service conventions (if business logic)
- `app/views/` -> view structure, partials, layouts (if view-related)
- `app/views/layouts/` -> layout structure (if page-related)
- `app/helpers/` -> helper patterns (if adding view helpers)
- `app/javascript/controllers/` -> Stimulus controllers (if interactive behavior)
- `spec/` -> test patterns, factories (if writing tests)
- `features/[name].md` -> related feature docs (if modifying existing feature)

## Danger Zones (must flag in plan)
- Auth/authz/permissions
- DB migrations/schema changes
- Money/billing/payments
- Production config/secrets
- Data scoping / user isolation boundaries
- Background jobs mutating data
- JavaScript changes affecting multiple pages

## Plan Output Format
```
docs/TICKET-ID-plan.md:

## Context Loaded                       <- list exactly which files were read
- architecture/views.md
- architecture/routing.md
- [etc.]

## Ticket Metadata -> ID, title, owner, priority
## Requirements -> acceptance criteria, constraints, non-goals
## Architecture Decisions -> trade-offs, affected areas
## Current State -> what exists, what's missing

## Phase N -> for each phase:
  - Goal (1 line)
  - Tasks (bullet list)
  - Allowed files
  - Forbidden changes
  - Verify commands
  - Acceptance criteria
  - Context needed -> which instruction files to read during execution

## Next Step -> `execute plan 1 for TICKET-ID`
```
