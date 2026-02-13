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

### New Page / View
```
LOAD:
  - architecture/views.md               -> layouts, partials, Turbo patterns
  - architecture/routing.md             -> URL design, named paths
  - architecture/error-handling.md      -> flash messages, form errors, Turbo errors
  - architecture/patterns.md            -> controller/view conventions
  - architecture/glossary.md            -> domain terms
  - features/_CONVENTIONS.md            -> view, form, test patterns
  - infrastructure/security.md          -> CSRF, XSS, auth boundaries
LOAD IF page has forms:
  - architecture/database.md            -> schema context for form fields
SKIP:
  - infrastructure/environment.md, deployment.md, tooling.md
  - workflow/* (you already know the planning workflow)
```

### New Model / DB Change
```
LOAD:
  - architecture/database.md            -> schema, tables, relationships, migration rules
  - architecture/patterns.md            -> model conventions
  - architecture/glossary.md            -> domain terms, status definitions
  - infrastructure/security.md          -> query scoping rules
LOAD IF model has views:
  - architecture/views.md              -> view patterns
  - architecture/routing.md            -> route conventions
  - architecture/error-handling.md     -> form error patterns
SKIP:
  - architecture/data-flow.md (not needed for model-only changes)
  - infrastructure/environment.md, deployment.md
```

### New Form
```
LOAD:
  - architecture/views.md               -> form patterns, Turbo compatibility
  - architecture/routing.md             -> form action URLs, nested routes
  - architecture/error-handling.md      -> validation errors, flash, Turbo errors
  - architecture/database.md            -> fields, validations, associations
  - architecture/patterns.md            -> controller conventions
  - features/_CONVENTIONS.md            -> form builder, test patterns
  - infrastructure/security.md          -> CSRF, strong params, XSS
SKIP:
  - architecture/data-flow.md, glossary.md (unless domain logic unclear)
  - infrastructure/environment.md, deployment.md
```

### Bug Fix
```
LOAD:
  - features/[affected-feature].md      -> how it should work
  - architecture/error-handling.md      -> if error-related
  - architecture/data-flow.md           -> if flow/middleware-related
  - architecture/glossary.md            -> if domain logic unclear
LOAD IF touches auth:
  - infrastructure/security.md
LOAD IF touches DB:
  - architecture/database.md
LOAD IF touches views:
  - architecture/views.md
SKIP:
  - Everything not related to the bug's domain
```

### Background Job
```
LOAD:
  - architecture/data-flow.md           -> job flow, retry patterns
  - architecture/patterns.md            -> job conventions (idempotency)
  - architecture/glossary.md            -> domain terms
LOAD IF job touches external service:
  - infrastructure/dependencies.md      -> service integration details
LOAD IF job modifies data:
  - architecture/database.md            -> schema context
  - infrastructure/security.md          -> query scoping
LOAD IF job sends Turbo broadcasts:
  - architecture/views.md              -> Turbo Stream broadcast patterns
SKIP:
  - architecture/routing.md (jobs don't serve routes)
  - infrastructure/deployment.md
```

### Auth / Permissions Change
```
LOAD:
  - infrastructure/security.md          -> CRITICAL: all security rules
  - architecture/data-flow.md           -> auth pipeline
  - architecture/glossary.md            -> role definitions
  - architecture/patterns.md            -> policy conventions
LOAD IF adds pages:
  - architecture/views.md
  - architecture/routing.md
  - architecture/error-handling.md
SKIP:
  - architecture/database.md (unless adding roles table)
```

### Turbo / Stimulus Feature
```
LOAD:
  - architecture/views.md               -> Turbo Frames/Streams, Stimulus conventions
  - architecture/data-flow.md           -> Turbo request lifecycle
  - architecture/error-handling.md      -> Turbo error handling
  - architecture/patterns.md            -> controller response conventions
  - features/_CONVENTIONS.md            -> system test patterns for Turbo
LOAD IF modifying routes:
  - architecture/routing.md
SKIP:
  - architecture/database.md (unless also changing models)
  - infrastructure/* (unless infra changes needed)
```

### Refactor (no behavior change)
```
LOAD:
  - architecture/patterns.md            -> target conventions
  - features/[affected-feature].md      -> current behavior (must not change)
SKIP:
  - Most other files (refactor = same behavior, different structure)
```

### Migration Only
```
LOAD:
  - architecture/database.md            -> schema conventions, migration rules
  - infrastructure/security.md          -> query scoping (if applicable)
SKIP:
  - Everything else
```

### Mailer
```
LOAD:
  - architecture/patterns.md            -> mailer conventions
  - architecture/views.md               -> mailer view/layout patterns
  - architecture/data-flow.md           -> mailer flow
LOAD IF mailer triggered by job:
  - architecture/data-flow.md           -> job flow
SKIP:
  - architecture/routing.md, database.md (unless also changing those)
```

---

## EXECUTION STATE

When executing a phase from an approved plan:
```
ALWAYS LOAD:
  - The plan itself: docs/TICKET-ID-plan.md
  - workflow/implementation.md           -> coding conventions, file locations

LOAD from plan's "Context loaded:" section:
  - Only the files that were loaded during planning
  - The plan explicitly lists which context was used

LOAD IF writing tests:
  - features/_CONVENTIONS.md             -> test data patterns, spec templates
  - workflow/testing.md                  -> verification commands
```

---

## TESTING STATE

When verifying a phase:
```
ALWAYS LOAD:
  - workflow/testing.md                  -> verification commands
  - The plan: docs/TICKET-ID-plan.md    -> phase-specific verify commands

LOAD IF view changes:
  - features/_CONVENTIONS.md             -> system test patterns

SKIP:
  - All architecture/ files (already used during planning)
  - All infrastructure/ files (except tooling.md if unsure about commands)
```

---

## MAINTENANCE STATE

After ticket is complete:
```
ALWAYS LOAD:
  - workflow/maintenance.md              -> decision matrix for what to update

THEN load only the files that need updating based on what changed:
  - DB changed -> architecture/database.md
  - Routes changed -> architecture/routing.md
  - Views changed -> architecture/views.md
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
- architecture/views.md
- architecture/routing.md
- architecture/error-handling.md
- architecture/patterns.md
- features/_CONVENTIONS.md
- infrastructure/security.md
```

This section is carried forward to execution -- the agent loads these same files when implementing.
