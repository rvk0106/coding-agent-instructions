# Context Router
> Tags: context, routing, tokens, optimization
> Scope: READ THIS FIRST -- tells you exactly which files to load for each task
> Purpose: Minimize token usage by loading only relevant context

## How to Use
1. Agent reads THIS file first (small, fast)
2. Identify the TASK TYPE and WORKFLOW STATE
3. Load ONLY the files listed for that combination
4. Include "Context loaded:" in your output so human can verify

---

## PLANNING STATE

### New API Endpoint
```
LOAD:
  - architecture/api-design.md        -> response shapes, naming, versioning
  - architecture/error-handling.md     -> HTTP codes, error patterns
  - architecture/data-flow.md         -> request lifecycle, DRF pipeline
  - architecture/patterns.md          -> view/serializer conventions
  - architecture/glossary.md          -> domain terms
  - features/_CONVENTIONS.md          -> serialization, query, test patterns
  - infrastructure/security.md        -> auth boundaries, query scoping
LOAD IF admin endpoint:
  - architecture/database.md          -> schema context
SKIP:
  - infrastructure/environment.md, deployment.md, tooling.md
  - workflow/* (you already know the planning workflow)
```

### New Model / DB Change
```
LOAD:
  - architecture/database.md          -> schema, models, relationships, migration rules
  - architecture/patterns.md          -> model conventions
  - architecture/glossary.md          -> domain terms, status definitions
  - infrastructure/security.md        -> query scoping rules
LOAD IF model has API:
  - architecture/api-design.md        -> endpoint conventions
  - architecture/error-handling.md    -> validation error patterns
SKIP:
  - architecture/data-flow.md (not needed for model-only changes)
  - infrastructure/environment.md, deployment.md
```

### Bug Fix
```
LOAD:
  - features/[affected-feature].md    -> how it should work
  - architecture/error-handling.md    -> if error-related
  - architecture/data-flow.md         -> if flow/middleware-related
  - architecture/glossary.md          -> if domain logic unclear
LOAD IF touches auth:
  - infrastructure/security.md
LOAD IF touches DB:
  - architecture/database.md
SKIP:
  - Everything not related to the bug's domain
```

### Celery Task
```
LOAD:
  - architecture/data-flow.md         -> Celery task flow, transaction rules
  - architecture/patterns.md          -> task conventions (idempotency)
  - architecture/glossary.md          -> domain terms
LOAD IF task touches external service:
  - infrastructure/dependencies.md    -> service integration details
LOAD IF task modifies data:
  - architecture/database.md          -> schema context
  - infrastructure/security.md        -> query scoping
SKIP:
  - architecture/api-design.md (tasks don't serve API directly)
  - infrastructure/deployment.md
```

### Auth / Permissions Change
```
LOAD:
  - infrastructure/security.md        -> CRITICAL: all security rules
  - architecture/data-flow.md         -> DRF auth/permission pipeline
  - architecture/glossary.md          -> role definitions
  - architecture/patterns.md          -> permission class conventions
LOAD IF adds endpoint:
  - architecture/api-design.md
  - architecture/error-handling.md
SKIP:
  - architecture/database.md (unless adding permissions model)
```

### Refactor (no behavior change)
```
LOAD:
  - architecture/patterns.md          -> target conventions
  - features/[affected-feature].md    -> current behavior (must not change)
SKIP:
  - Most other files (refactor = same behavior, different structure)
```

### Migration Only
```
LOAD:
  - architecture/database.md          -> schema conventions, migration rules
  - infrastructure/security.md        -> query scoping (if applicable)
SKIP:
  - Everything else
```

---

## EXECUTION STATE

When executing a phase from an approved plan:
```
ALWAYS LOAD:
  - The plan itself: docs/TICKET-ID-plan.md
  - workflow/implementation.md         -> coding conventions, file locations

LOAD from plan's "Context loaded:" section:
  - Only the files that were loaded during planning
  - The plan explicitly lists which context was used

LOAD IF writing tests:
  - features/_CONVENTIONS.md           -> test data patterns, test templates
  - workflow/testing.md                -> verification commands
```

---

## TESTING STATE

When verifying a phase:
```
ALWAYS LOAD:
  - workflow/testing.md                -> verification commands
  - The plan: docs/TICKET-ID-plan.md  -> phase-specific verify commands

LOAD IF API changes:
  - features/_CONVENTIONS.md           -> API test patterns

SKIP:
  - All architecture/ files (already used during planning)
  - All infrastructure/ files (except tooling.md if unsure about commands)
```

---

## MAINTENANCE STATE

After ticket is complete:
```
ALWAYS LOAD:
  - workflow/maintenance.md            -> decision matrix for what to update

THEN load only the files that need updating based on what changed:
  - DB changed -> architecture/database.md
  - API changed -> architecture/api-design.md
  - New pattern -> architecture/patterns.md
  - Error handling changed -> architecture/error-handling.md
  - Feature behavior changed -> features/[feature].md
  - Infra changed -> infrastructure/[relevant].md
```

---

## PLAN OUTPUT FORMAT

Every plan must include a "Context loaded" section so execution knows what was read:
```
## Context Loaded
- architecture/api-design.md
- architecture/error-handling.md
- architecture/patterns.md
- features/_CONVENTIONS.md
- infrastructure/security.md
```

This section is carried forward to execution -- the agent loads these same files when implementing.
