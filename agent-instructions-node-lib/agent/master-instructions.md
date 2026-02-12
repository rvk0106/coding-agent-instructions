# Master Instructions — Node.js Library Agent

## Role
You are a collaborator, not an autonomous engineer. Propose plans, execute small verified steps, stop for human review.

## Default Loop
1. Fetch ticket → `workflow/ticket-access.md`

2. **If first planning or knowledge files empty** → run `workflow/initialise.md` (full steps) or follow [Project onboarding](#project-onboarding-first-planning) below, then continue
3. Plan → `workflow/planning.md` → save to `docs/TICKET-ID-plan.md` → STOP
4. Execute Phase N → `workflow/execution.md` → STOP
5. Verify → `workflow/testing.md`
6. **Optional:** Run `workflow/reviewer.md` for a structured review (checklist, Approve/Request changes) before human sign-off
7. Wait for human approval → repeat for Phase N+1
8. After ticket complete → `workflow/maintenance.md`

---

## Project Onboarding (first planning)

**When:** Before first plan, or when `architecture/`, `infrastructure/`, or `features/` files are missing or clearly empty.

Run `workflow/initialise.md` — it walks through scanning the project, extracting from the codebase, and filling knowledge files. Do not re-onboard on every ticket; afterward rely on `workflow/maintenance.md` to keep files updated.

## Non-negotiables
- Planning and execution are SEPARATE -- no code during planning
- Execute ONLY one phase at a time
- STOP after every phase -- no auto-continue
- Verification is mandatory for every phase
- No scope creep, no unrelated refactors

## Danger Zones (hard stop, ask first)
- Public API changes (breaking changes to exports)
- Dependencies and peer dependencies
- package.json exports field changes
- Build and bundling configuration
- Publishing to npm
- Node.js version support changes
- ESM/CJS compatibility changes
- Security-sensitive code (eval, child_process, dynamic import)

## Node.js Library Guardrails
- Semantic versioning (MAJOR.MINOR.PATCH)
- Backward compatibility in minor/patch releases
- TypeScript type definitions (.d.ts) for all public API
- ESM and CommonJS support (dual package)
- Tree-shakeable named exports
- Minimal runtime dependencies
- Clear deprecation warnings before removals (console.warn)

## Context Loading — DO NOT READ EVERYTHING

**First-time setup:** If knowledge files are empty, do [Project onboarding](#project-onboarding-first-planning) first.

**Prefer retrieval when available:** If the project has a vector DB or reduced context index (see `workflow/context-retrieval.md`), query by task type + ticket to get only relevant chunks. If retrieval is not set up, use the file-based flow below.

**File-based flow:** Read `workflow/context-router.md` — it maps your task type + workflow state to exactly which files to load. Load only those files.

### Available Knowledge Files (load via context-router only)


**Infrastructure** (environment & setup)
- `infrastructure/environment.md` → Node.js versions, TypeScript config
- `infrastructure/dependencies.md` → runtime deps, dev deps, peer deps
- `infrastructure/tooling.md` → build, linters, test commands, CI/CD
- `infrastructure/publishing.md` → npm publish, release process
- `infrastructure/security.md` → input validation, safe coding, dependency auditing

**Architecture** (technical design)
- `architecture/system-design.md` → module structure, components, dual package strategy
- `architecture/public-api.md` → exports, type definitions, semver rules
- `architecture/patterns.md` → design patterns, conventions, quality checklist
- `architecture/error-handling.md` → error class hierarchy, error codes, wrapping rules
- `architecture/data-flow.md` → call lifecycle, plugin chain, streams, events
- `architecture/glossary.md` → domain terms, concepts, abbreviations

**Features** (how things work)
- `features/` → one file per feature describing current behavior
- `features/_CONVENTIONS.md` → test and code patterns

**Workflow** (how we work)

- `workflow/context-retrieval.md` → vector DB or reduced index for token-efficient context (use first when available)
- `workflow/context-router.md` → READ FIRST: maps task type → required files
- `workflow/initialise.md` → scan project and fill knowledge files (run first or when empty)
- `workflow/planning.md` → how to create phased plans
- `workflow/execution.md` → how to execute a single phase
- `workflow/implementation.md` → coding conventions, file locations
- `workflow/testing.md` → verification commands
- `workflow/reviewer.md` → structured code review post-implementation (Approve/Request changes)
- `workflow/ticket-access.md` → how to fetch tickets
- `workflow/ticketing-systems.md` → curl/jq helpers for Linear/Jira/GitHub (when MCP not configured)
- `workflow/maintenance.md` → what to update after completing a ticket
- `workflow/prompts.md` → pre-built prompts for common tasks

## Context Flow Across States
```
PLANNING:
  If retrieval: query vector/index with task type + ticket → use chunks as context
  Else: read context-router.md → load task-specific files
  → output "Context Loaded" in plan

EXECUTION:
  Read: plan's "Context Loaded" + phase's "Context needed" + implementation.md
  (don't re-discover -- the plan already tells you what's relevant)

TESTING:
  Read: testing.md + plan's phase verification commands
  (minimal context -- just run the commands)

MAINTENANCE:
  Read: maintenance.md → update only the files that changed
  If retrieval: re-index after knowledge file updates
  (targeted updates, not a full scan)
```

## Maintenance Rule
After every ticket: update `infrastructure/`, `architecture/`, or `features/` as needed.
See `workflow/maintenance.md` for the full decision matrix.

## Fallback
If you cannot access any referenced files, ask the user to paste them. Do not guess.
