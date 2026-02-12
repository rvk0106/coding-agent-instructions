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

### New Public Function / Class
```
LOAD:
  - architecture/public-api.md        -> API surface, signatures, type hints, semver rules
  - architecture/patterns.md          -> coding conventions, naming
  - architecture/error-handling.md    -> exception classes, error patterns
  - architecture/glossary.md          -> domain terms
  - infrastructure/security.md        -> input validation, safe coding
LOAD IF feature has external calls:
  - architecture/data-flow.md         -> call lifecycle, external service patterns
  - infrastructure/dependencies.md    -> runtime deps
SKIP:
  - infrastructure/environment.md, publishing.md, tooling.md
  - workflow/* (you already know the planning workflow)
```

### New Module
```
LOAD:
  - architecture/system-design.md     -> module structure, component layout
  - architecture/patterns.md          -> namespacing, conventions
  - architecture/glossary.md          -> domain terms
  - infrastructure/security.md        -> safe coding rules
LOAD IF module is part of public API:
  - architecture/public-api.md        -> API surface conventions
  - architecture/error-handling.md    -> error classes
SKIP:
  - architecture/data-flow.md (not needed for module-only changes)
  - infrastructure/environment.md, publishing.md
```

### Bug Fix
```
LOAD:
  - features/[affected-feature].md   -> how it should work
  - architecture/error-handling.md   -> if error-related
  - architecture/data-flow.md        -> if flow-related
  - architecture/glossary.md         -> if domain logic unclear
LOAD IF touches public API:
  - architecture/public-api.md
LOAD IF touches external calls:
  - infrastructure/dependencies.md
SKIP:
  - Everything not related to the bug's domain
```

### Configuration Change
```
LOAD:
  - architecture/patterns.md          -> configuration pattern conventions
  - architecture/public-api.md        -> backward compatibility rules
  - architecture/glossary.md          -> domain terms
LOAD IF config affects external service:
  - architecture/data-flow.md
  - infrastructure/dependencies.md
SKIP:
  - Most infrastructure files
```

### Dependency Change
```
LOAD:
  - infrastructure/dependencies.md    -> CRITICAL: dependency philosophy, justification
  - infrastructure/security.md        -> dependency auditing
  - architecture/public-api.md        -> backward compatibility (if dep change affects API)
SKIP:
  - Most architecture files
  - infrastructure/environment.md (unless Python version affected)
```

### Error Handling Change
```
LOAD:
  - architecture/error-handling.md    -> CRITICAL: exception hierarchy, patterns
  - architecture/public-api.md        -> breaking change rules
  - architecture/patterns.md          -> error conventions
SKIP:
  - infrastructure/* (unless adding error for external service)
```

### Refactor (no behavior change)
```
LOAD:
  - architecture/patterns.md          -> target conventions
  - features/[affected-feature].md   -> current behavior (must not change)
SKIP:
  - Most other files (refactor = same behavior, different structure)
```

### Version Bump / Release
```
LOAD:
  - infrastructure/publishing.md      -> CRITICAL: release process, semver rules
  - architecture/public-api.md        -> what changed determines version bump
SKIP:
  - Most other files
```

---

## EXECUTION STATE

When executing a phase from an approved plan:
```
ALWAYS LOAD:
  - The plan itself: docs/TICKET-ID-plan.md
  - workflow/implementation.md          -> coding conventions, file locations

LOAD from plan's "Context loaded:" section:
  - Only the files that were loaded during planning
  - The plan explicitly lists which context was used

LOAD IF writing tests:
  - features/_CONVENTIONS.md            -> test data patterns, fixture templates
  - workflow/testing.md                 -> verification commands
```

---

## TESTING STATE

When verifying a phase:
```
ALWAYS LOAD:
  - workflow/testing.md                 -> verification commands
  - The plan: docs/TICKET-ID-plan.md   -> phase-specific verify commands

LOAD IF public API changes:
  - features/_CONVENTIONS.md            -> test patterns

SKIP:
  - All architecture/ files (already used during planning)
  - All infrastructure/ files (except tooling.md if unsure about commands)
```

---

## MAINTENANCE STATE

After ticket is complete:
```
ALWAYS LOAD:
  - workflow/maintenance.md             -> decision matrix for what to update

THEN load only the files that need updating based on what changed:
  - Module structure changed -> architecture/system-design.md
  - Public API changed -> architecture/public-api.md
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
- architecture/public-api.md
- architecture/error-handling.md
- architecture/patterns.md
- features/_CONVENTIONS.md
- infrastructure/security.md
```

This section is carried forward to execution -- the agent loads these same files when implementing.
