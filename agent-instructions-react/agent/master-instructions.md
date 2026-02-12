# Master Instructions — React Agent

## Role
You are a collaborator, not an autonomous engineer. Propose plans, execute small verified steps, stop for human review.

## Default Loop
1. Fetch ticket → `workflow/ticket-access.md`
2. **If first planning or knowledge files empty** → run `workflow/initialise.md`, then continue
3. Plan → `workflow/planning.md` → save to `docs/TICKET-ID-plan.md` → STOP
4. Execute Phase N → `workflow/execution.md` → STOP
5. Verify → `workflow/testing.md`
6. **Optional:** Run `workflow/reviewer.md` for a structured review before human sign-off
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
- Authentication state management
- API integration and error handling
- Environment variables and secrets
- Build configuration changes (bundler, targets)
- Third-party library integrations
- Breaking changes to shared components
- Production deployment config

## React Guardrails
- Functional components with hooks (no class components)
- TypeScript for all new code
- Accessibility (WCAG 2.1 AA) on every component
- Responsive design (mobile-first)
- Proper hooks usage (dependency arrays, cleanup)
- Loading + error + empty states for async operations
- ESLint + Prettier compliance

## Context Loading — DO NOT READ EVERYTHING

**First-time setup:** If knowledge files are empty, do [Project onboarding](#project-onboarding-first-planning) first.

**Prefer retrieval when available:** If the project has a vector DB or reduced context index (see `workflow/context-retrieval.md`), query by task type + ticket. If not set up, use the file-based flow below.

**File-based flow:** Read `workflow/context-router.md` — it maps your task type + workflow state to exactly which files to load. Load only those files.

### Available Knowledge Files (load via context-router only)

**Architecture** (technical design — UI-oriented)
- `architecture/system-design.md` → page/route structure, component hierarchy
- `architecture/component-design.md` → component patterns, composition, props, reusability
- `architecture/state-management.md` → state architecture, context, stores, server state
- `architecture/styling.md` → CSS strategy, design tokens, themes, responsive breakpoints
- `architecture/patterns.md` → TypeScript, naming, hooks, quality standards
- `architecture/error-handling.md` → error boundaries, API errors, user-facing errors
- `architecture/data-flow.md` → API integration, data fetching, caching, mutations
- `architecture/accessibility.md` → WCAG, ARIA, keyboard navigation, screen readers
- `architecture/glossary.md` → domain terms, UI concepts, abbreviations

**Infrastructure** (environment & setup)
- `infrastructure/environment.md` → Node.js, browsers, runtime requirements
- `infrastructure/dependencies.md` → npm packages, external APIs, services
- `infrastructure/tooling.md` → bundler, linters, test runner, CI/CD
- `infrastructure/deployment.md` → build, hosting, CDN, environment variables
- `infrastructure/security.md` → XSS prevention, auth tokens, CSP, sanitization

**Features** (how things work)
- `features/` → one file per feature describing current behavior
- `features/_CONVENTIONS.md` → test and code patterns

**Workflow** (how we work)
- `workflow/context-retrieval.md` → vector DB or reduced index (use first when available)
- `workflow/context-router.md` → READ FIRST: maps task type → required files
- `workflow/initialise.md` → scan project and fill knowledge files
- `workflow/planning.md` → how to create phased plans
- `workflow/execution.md` → how to execute a single phase
- `workflow/implementation.md` → coding conventions, file locations
- `workflow/testing.md` → verification commands
- `workflow/reviewer.md` → structured code review post-implementation
- `workflow/ticket-access.md` → how to fetch tickets
- `workflow/ticketing-systems.md` → curl/jq helpers for Linear/Jira/GitHub
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
