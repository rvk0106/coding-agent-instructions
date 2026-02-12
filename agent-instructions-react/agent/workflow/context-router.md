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

### New Component
```
LOAD:
  - architecture/component-design.md   → component patterns, composition, file structure
  - architecture/patterns.md           → TypeScript, naming, hooks rules
  - architecture/styling.md            → CSS strategy, responsive breakpoints
  - architecture/accessibility.md      → WCAG, ARIA, keyboard navigation
  - architecture/glossary.md           → domain terms
LOAD IF component fetches data:
  - architecture/data-flow.md          → API integration, fetching patterns
  - architecture/state-management.md   → server state, where data lives
LOAD IF component needs error handling:
  - architecture/error-handling.md     → error boundaries, API error display
SKIP:
  - infrastructure/* (not needed for component work)
```

### New Page / Route
```
LOAD:
  - architecture/system-design.md      → route structure, page layout, component hierarchy
  - architecture/component-design.md   → page vs feature vs common components
  - architecture/patterns.md           → TypeScript, naming conventions
  - architecture/styling.md            → responsive breakpoints, layout
  - architecture/accessibility.md      → page-level a11y requirements
  - architecture/data-flow.md          → data fetching for the page
LOAD IF page has forms:
  - architecture/error-handling.md     → form validation, error display
LOAD IF page has state management:
  - architecture/state-management.md
SKIP:
  - infrastructure/* (except security.md if auth-related)
```

### Styling / Theme Change
```
LOAD:
  - architecture/styling.md            → CRITICAL: design tokens, themes, breakpoints
  - architecture/accessibility.md      → color contrast, visual requirements
  - architecture/component-design.md   → component file structure for styles
SKIP:
  - architecture/data-flow.md, state-management.md (no data changes)
  - infrastructure/* (no infra changes)
```

### State Management Change
```
LOAD:
  - architecture/state-management.md   → CRITICAL: state categories, patterns
  - architecture/patterns.md           → hooks rules, custom hooks
  - architecture/data-flow.md          → if server state involved
LOAD IF affecting components:
  - architecture/component-design.md
SKIP:
  - architecture/styling.md, accessibility.md (no visual changes)
  - infrastructure/*
```

### Bug Fix
```
LOAD:
  - features/[affected-feature].md    → how it should work
  - architecture/error-handling.md    → if error-related
  - architecture/data-flow.md         → if data/API-related
  - architecture/state-management.md  → if state-related
  - architecture/glossary.md          → if domain logic unclear
SKIP:
  - Everything not related to the bug's domain
```

### API Integration / Data Fetching Change
```
LOAD:
  - architecture/data-flow.md          → CRITICAL: API client, fetching patterns, caching
  - architecture/error-handling.md     → API error handling, loading states
  - architecture/state-management.md   → server state management
  - infrastructure/security.md         → auth tokens, env vars
LOAD IF affects components:
  - architecture/component-design.md
SKIP:
  - architecture/styling.md (no visual changes)
```

### Accessibility Fix / Improvement
```
LOAD:
  - architecture/accessibility.md      → CRITICAL: WCAG, ARIA, keyboard, focus
  - architecture/component-design.md   → semantic HTML, component patterns
  - architecture/styling.md            → if color/contrast related
SKIP:
  - architecture/data-flow.md, state-management.md
  - infrastructure/*
```

### Dependency Change
```
LOAD:
  - infrastructure/dependencies.md     → CRITICAL: dependency philosophy, bundle impact
  - infrastructure/security.md         → dependency auditing
LOAD IF dependency affects build:
  - infrastructure/tooling.md
SKIP:
  - Most architecture files
```

### Performance Optimization
```
LOAD:
  - architecture/patterns.md           → memoization, lazy loading patterns
  - architecture/component-design.md   → component splitting
  - architecture/data-flow.md          → if caching/fetching related
  - infrastructure/deployment.md       → performance budget (if defined)
SKIP:
  - infrastructure/environment.md, security.md
```

### Refactor (no behavior change)
```
LOAD:
  - architecture/patterns.md           → target conventions
  - features/[affected-feature].md    → current behavior (must not change)
SKIP:
  - Most other files (refactor = same behavior, different structure)
```

---

## EXECUTION STATE

When executing a phase from an approved plan:
```
ALWAYS LOAD:
  - The plan itself: docs/TICKET-ID-plan.md
  - workflow/implementation.md          → coding conventions, file locations

LOAD from plan's "Context loaded:" section:
  - Only the files that were loaded during planning
  - The plan explicitly lists which context was used

LOAD IF writing tests:
  - features/_CONVENTIONS.md            → test patterns, component test templates
  - workflow/testing.md                 → verification commands
```

---

## TESTING STATE

When verifying a phase:
```
ALWAYS LOAD:
  - workflow/testing.md                 → verification commands
  - The plan: docs/TICKET-ID-plan.md   → phase-specific verify commands

LOAD IF UI changes:
  - architecture/accessibility.md       → a11y checklist
  - features/_CONVENTIONS.md            → test patterns

SKIP:
  - All architecture/ files (already used during planning)
  - All infrastructure/ files
```

---

## MAINTENANCE STATE

After ticket is complete:
```
ALWAYS LOAD:
  - workflow/maintenance.md             → decision matrix for what to update

THEN load only the files that need updating based on what changed:
  - Route/page structure → architecture/system-design.md
  - Component patterns → architecture/component-design.md
  - State approach → architecture/state-management.md
  - Styling/theme → architecture/styling.md
  - Error handling → architecture/error-handling.md
  - API integration → architecture/data-flow.md
  - Feature behavior → features/[feature].md
  - Infra changed → infrastructure/[relevant].md
```

---

## PLAN OUTPUT FORMAT

Every plan must include a "Context loaded" section:
```
## Context Loaded
- architecture/component-design.md
- architecture/patterns.md
- architecture/styling.md
- architecture/accessibility.md
- features/_CONVENTIONS.md
```

This section is carried forward to execution.
