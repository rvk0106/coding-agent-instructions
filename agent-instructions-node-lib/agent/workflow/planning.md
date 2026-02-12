# Planning
> Tags: plan, architecture, phases, ticket
> Scope: How to create a phased plan from a ticket
> Trigger: `plan library for TICKET-ID`

## Rules
- NO code during planning
- Phases must be small, reversible, independently verifiable
- Output goes to `docs/TICKET-ID-plan.md`
- STOP after plan is written -- wait for human approval

## Planning Steps
1. **Fetch ticket** → see `workflow/ticket-access.md`
2. **Classify task type** → new feature? bug fix? refactor? dependency change? etc.
3. **Load context via router** → read `workflow/context-router.md` PLANNING section, load ONLY the files listed for your task type
4. **Analyze codebase** → check relevant project files (see below)
5. **Check if changes needed** → can existing code fulfill requirements?
6. **Plan for reuse** → identify existing functions/modules to leverage
7. **Write phased plan** → save to `docs/TICKET-ID-plan.md`
8. **List context loaded** → include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new feature, bug fix, refactor, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (Node.js Library)
After loading instruction context, check these project files as relevant:
- `package.json` → exports, dependencies, scripts, version, engines
- `src/index.ts` (or `.js`) → main entry point, re-exports, top-level API
- `src/` → source structure, module layout
- `dist/` → build output (ESM + CJS + .d.ts)
- `tsconfig.json` → TypeScript configuration
- `tests/` or `__tests__/` → test patterns, existing coverage
- Bundler config (`tsup.config.ts`, `rollup.config.js`, etc.)
- `eslint.config.js` / `.eslintrc.*` → style configuration
- `CHANGELOG.md` → versioning history
- `README.md` → documented public API and examples

## Danger Zones (must flag in plan)
- Public API / exports changes (breaking changes)
- Dependency additions/removals
- Node.js version support changes
- ESM/CJS compatibility changes
- Build configuration changes
- package.json `exports` field changes
- Publishing to npm

## Plan Output Format
```
docs/TICKET-ID-plan.md:

## Context Loaded                       ← list exactly which files were read
- architecture/public-api.md
- architecture/patterns.md
- [etc.]

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
  - Context needed → which instruction files to read during execution

## Next Step → `execute plan 1 for TICKET-ID`
```
