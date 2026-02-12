# Planning
> Tags: plan, architecture, phases, ticket
> Scope: How to create a phased plan from a ticket
> Trigger: `plan frontend for TICKET-ID`

## Rules
- NO code during planning
- Phases must be small, reversible, independently verifiable
- Output goes to `docs/TICKET-ID-plan.md`
- STOP after plan is written -- wait for human approval

## Planning Steps
1. **Fetch ticket** → see `workflow/ticket-access.md`
2. **Classify task type** → new component? new page? bug fix? styling? state change? etc.
3. **Load context via router** → read `workflow/context-router.md` PLANNING section, load ONLY the files listed for your task type
4. **Analyze codebase** → check relevant project files (see below)
5. **Check for design assets** → Figma links, mockups, wireframes in ticket
6. **Plan for reuse** → identify existing components/hooks to leverage
7. **Write phased plan** → save to `docs/TICKET-ID-plan.md`
8. **List context loaded** → include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new component, new page, bug fix, styling, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (React)
After loading instruction context, check these project files as relevant:
- `package.json` → dependencies, scripts, React version
- `src/components/` → existing component patterns, naming
- `src/pages/` or `src/views/` → route/page structure
- `src/hooks/` → custom hooks, reusable logic
- `src/context/` or `src/store/` → state management
- `src/services/` or `src/api/` → API integration patterns
- `src/types/` → TypeScript definitions
- `src/styles/` → global styles, design tokens, theme
- `tsconfig.json` → TypeScript configuration
- `.eslintrc*` → lint rules
- Test files → existing test patterns

## Danger Zones (must flag in plan)
- Authentication state changes
- API integration and error handling changes
- Environment variable changes
- Build configuration changes (bundler, targets)
- Third-party library integrations
- Breaking changes to shared components

## Phase Planning for UI Work
When planning UI features, consider this phase order:
1. **Types & interfaces** → define TypeScript types for the feature
2. **Data layer** → hooks for data fetching/state (if needed)
3. **Component structure** → create components with basic rendering
4. **Styling** → apply styles, responsive design
5. **Interactivity** → event handlers, form logic, animations
6. **Accessibility** → ARIA, keyboard, screen reader
7. **Tests** → unit tests, integration tests
8. **Polish** → loading states, error states, edge cases

## Plan Output Format
```
docs/TICKET-ID-plan.md:

## Context Loaded
- architecture/component-design.md
- architecture/patterns.md
- [etc.]

## Ticket Metadata → ID, title, owner, priority
## Requirements → acceptance criteria, constraints, non-goals
## Design References → Figma/mockup links, screenshots
## Architecture Decisions → component structure, state approach
## Current State → what exists, what's missing

## Phase N → for each phase:
  - Goal (1 line)
  - Tasks (bullet list)
  - Allowed files
  - Forbidden changes
  - Verify commands
  - Acceptance criteria
  - Context needed → which instruction files to read during execution

## Next Step → `execute plan 1 for TICKET-ID`
```
