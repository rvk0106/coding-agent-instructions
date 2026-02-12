# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the Node.js package and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this package repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess — discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `src/`, `dist/`, `tests/` or `__tests__/`, `types/`
- **Entry points:** `package.json`, `src/index.ts` or `src/index.js`, README
- **Key config:** `tsconfig.json`, bundler config, `eslint.config.js`, `.github/workflows/`

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | package.json | Node version, runtime deps, dev deps, engines |
| **Structure** | src/ | Module layout, directory organization, entry points |
| **Public API** | src/index.ts, package.json exports | Named exports, function signatures, types |
| **Errors** | src/errors/ (or similar) | Error class hierarchy, error codes |
| **Configuration** | Factory functions, options types | Options, defaults, validation |
| **Testing** | tests/, jest.config.* or vitest.config.* | Test framework, patterns, coverage |
| **Build** | tsup.config.*, rollup.config.*, tsconfig.json | Build tool, output formats, targets |
| **Ops** | README, .github, package.json scripts | Test command, lint command, CI, release process |

### 3. Fill knowledge files
Populate from discovery. Create or update only these:

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Module structure, components, data flow from src/ |
| **architecture/public-api.md** | Exports, function signatures, types from source + package.json |
| **architecture/patterns.md** | Coding conventions, module patterns from code |
| **architecture/error-handling.md** | Error classes, error codes from source |
| **architecture/data-flow.md** | Call flow, plugin chain, event patterns from code |
| **architecture/glossary.md** | Domain terms, concepts from modules and business logic |
| **infrastructure/environment.md** | Node versions, TypeScript config from package.json + tsconfig |
| **infrastructure/dependencies.md** | Runtime, dev, and peer deps from package.json |
| **infrastructure/tooling.md** | Build tool, linters, test commands, CI from config and README |
| **infrastructure/publishing.md** | Release process, package.json fields, npm config |
| **infrastructure/security.md** | Input validation patterns, safe coding from code |
| **features/** | One file per major feature per `features/_TEMPLATE.md` |

**Workflow files:** If a workflow file is present but empty, add only project-specific content (e.g. actual test/lint commands). Do not overwrite process instructions.

### 4. (Optional) Build context retrieval
If the project uses a **vector DB** or **reduced context index**, index the knowledge files now. See `workflow/context-retrieval.md` for when and how to re-index.

### 5. Output
Produce a short summary:
```
Initialise complete.

Context loaded from project. Files created/updated:
- architecture/system-design.md
- architecture/public-api.md
- [list others]

Optional: Vector index updated (if applicable).

Next: Run `plan library for TICKET-ID` when ready.
```

## After Initialise
- Do not re-run on every ticket. Use `workflow/maintenance.md` to keep knowledge files updated after each ticket.
- Re-run initialise only when knowledge files are missing, empty, or the project has changed significantly.
