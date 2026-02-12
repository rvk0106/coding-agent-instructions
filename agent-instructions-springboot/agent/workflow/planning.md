# Planning
> Tags: plan, architecture, phases, ticket
> Scope: How to create a phased plan from a ticket
> Trigger: `plan api for TICKET-ID`

## Rules
- NO code during planning
- Phases must be small (~10 min each), reversible, independently verifiable
- Output goes to `docs/TICKET-ID-plan.md`
- STOP after plan is written -- wait for human approval

## Planning Steps
1. **Fetch ticket** --> see `workflow/ticket-access.md`
2. **Classify task type** --> new endpoint? bug fix? model change? refactor? background job? auth change?
3. **Load context via router** --> read `workflow/context-router.md` PLANNING section, load ONLY the files listed for your task type
4. **Analyze codebase** --> check relevant project files (see below)
5. **Check if changes needed** --> can existing code fulfill requirements?
6. **Plan for reuse** --> identify existing services, repositories, utilities to leverage
7. **Write phased plan** --> save to `docs/TICKET-ID-plan.md`
8. **List context loaded** --> include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new endpoint, bug fix, model change, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (Spring Boot)
After loading instruction context, check these project files as relevant:
- `pom.xml` / `build.gradle` --> dependencies, Spring Boot version, plugins
- `src/main/resources/application.yml` (or `.properties`) --> configuration, profiles, DB settings
- `src/main/java/.../controller/` --> REST controller patterns, endpoint conventions
- `src/main/java/.../service/` --> business logic patterns, @Transactional usage
- `src/main/java/.../repository/` --> data access patterns, custom queries
- `src/main/java/.../model/` (or `.../entity/`) --> JPA entity patterns, relationships
- `src/main/java/.../dto/` --> request/response DTO patterns, validation
- `src/main/java/.../config/` --> security config, CORS, OpenAPI config
- `src/main/java/.../exception/` --> exception hierarchy, @ControllerAdvice
- `src/test/` --> test patterns, test utilities, base test classes
- `features/[name].md` --> related feature docs (if modifying existing feature)

## Danger Zones (must flag in plan)
- Authentication/authorization/Spring Security configuration
- Database migrations (Flyway/Liquibase scripts)
- Money/billing/payment processing
- Production configuration/secrets (`application-prod.yml`)
- Multi-tenant data isolation
- Async processing / message queue consumers
- Background jobs mutating data

## Plan Output Format
```
docs/TICKET-ID-plan.md:

## Context Loaded                       <-- list exactly which files were read
- architecture/api-design.md
- architecture/error-handling.md
- [etc.]

## Ticket Metadata --> ID, title, owner, priority
## Requirements --> acceptance criteria, constraints, non-goals
## Architecture Decisions --> trade-offs, affected packages
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
