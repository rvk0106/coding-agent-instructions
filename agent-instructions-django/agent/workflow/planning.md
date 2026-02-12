# Planning
> Tags: plan, architecture, phases, ticket, django
> Scope: How to create a phased plan from a ticket
> Trigger: `plan architecture for TICKET-ID`

## Rules
- NO code during planning
- Phases must be small (~10 min each), reversible, independently verifiable
- Output goes to `docs/TICKET-ID-plan.md`
- STOP after plan is written -- wait for human approval

## Planning Steps
1. **Fetch ticket** -> see `workflow/ticket-access.md`
2. **Classify task type** -> new endpoint? bug fix? model change? Celery task? refactor? etc.
3. **Load context via router** -> read `workflow/context-router.md` PLANNING section, load ONLY the files listed for your task type
4. **Analyze codebase** -> check relevant project files (see below)
5. **Check if changes needed** -> can existing code fulfill requirements?
6. **Plan for reuse** -> identify existing models/views/serializers to leverage
7. **Write phased plan** -> save to `docs/TICKET-ID-plan.md`
8. **List context loaded** -> include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new endpoint, bug fix, model change, Celery task, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (Django)
After loading instruction context, check these project files as relevant:
- `manage.py` -> project entry point
- `project/settings.py` (or `settings/base.py`) -> configuration, installed apps
- `project/urls.py` -> root URL configuration
- `apps/*/models.py` -> data models, relationships (if DB-related)
- `apps/*/views.py` -> view/viewset patterns (if endpoint-related)
- `apps/*/serializers.py` -> serialization patterns (if API-related)
- `apps/*/urls.py` -> app-level routing (if endpoint-related)
- `apps/*/permissions.py` -> permission classes (if auth-related)
- `apps/*/tests/` -> test patterns, fixtures (if writing tests)
- `features/[name].md` -> related feature docs (if modifying existing feature)
- `requirements.txt` or `pyproject.toml` -> dependencies

## Danger Zones (must flag in plan)
- Custom user model changes
- Database migrations (especially data migrations)
- Security settings (SECRET_KEY, ALLOWED_HOSTS, CORS, CSRF)
- Production configuration / secrets
- Data scoping / user isolation boundaries
- Celery tasks affecting data integrity

## Plan Output Format
```
docs/TICKET-ID-plan.md:

## Context Loaded                       <- list exactly which files were read
- architecture/api-design.md
- architecture/error-handling.md
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
