# Planning
> Tags: plan, architecture, phases, ticket
> Scope: How to create a phased plan from a ticket
> Trigger: `plan gem for TICKET-ID`

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
6. **Plan for reuse** → identify existing methods/modules to leverage
7. **Write phased plan** → save to `docs/TICKET-ID-plan.md`
8. **List context loaded** → include "Context Loaded" section in plan output

## Context Loading
DO NOT read all instruction files. Instead:
1. Read `workflow/context-router.md`
2. Find your task type (new feature, bug fix, refactor, etc.)
3. Load ONLY the files listed under LOAD
4. Load conditional files only IF the condition applies
5. SKIP everything else

## Codebase Analysis (Ruby Gem)
After loading instruction context, check these project files as relevant:
- `*.gemspec` → gem configuration, dependencies, version constraints
- `lib/gem_name.rb` → main entry point, requires, top-level API
- `lib/gem_name/` → source structure, module layout
- `lib/gem_name/version.rb` → current version
- `spec/` → test patterns, existing coverage
- `.rubocop.yml` → style configuration
- `CHANGELOG.md` → versioning history
- `README.md` → documented public API and examples

## Danger Zones (must flag in plan)
- Public API changes (breaking changes)
- Dependency additions/removals
- Ruby version support changes
- Gemspec metadata changes
- Publishing to RubyGems

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
