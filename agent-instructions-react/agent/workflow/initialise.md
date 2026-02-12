# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the React project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or before first plan when knowledge files are empty

## When to Run
- First time using agent instructions in this React project
- After cloning into a new project that has no populated knowledge files
- When the project has changed significantly and knowledge files are stale

## Rules
- Do not guess — discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `src/`, `public/`, project root config files
- **Entry points:** `src/App.tsx`, `src/main.tsx` or `src/index.tsx`, `package.json`
- **Key config:** `tsconfig.json`, `.eslintrc*`, `vite.config.ts` / `webpack.config.js`, `.prettierrc`

### 2. Extract from codebase
| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | package.json | React version, bundler, state lib, CSS approach, test framework |
| **Pages/Routes** | src/pages/, router config | Route structure, page list |
| **Components** | src/components/ | Component patterns, naming, file structure |
| **State** | src/context/, src/store/ | State management approach, providers |
| **Data fetching** | src/services/, src/hooks/ | API client, fetching patterns, caching |
| **Styling** | src/styles/, component CSS | CSS approach, tokens, themes, breakpoints |
| **Types** | src/types/ | TypeScript patterns, shared types |
| **Testing** | test files, jest/vitest config | Test framework, patterns, utilities |
| **Ops** | .github/, package.json scripts | CI, deploy, lint/test commands |

### 3. Fill knowledge files
| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Routes, page structure, component hierarchy |
| **architecture/component-design.md** | Component patterns, file structure |
| **architecture/state-management.md** | State approach, providers, hooks |
| **architecture/styling.md** | CSS strategy, tokens, themes, breakpoints |
| **architecture/patterns.md** | TypeScript config, naming, conventions |
| **architecture/error-handling.md** | Error boundaries, API error patterns |
| **architecture/data-flow.md** | API client, fetching patterns, caching |
| **architecture/accessibility.md** | Current a11y patterns, tools |
| **architecture/glossary.md** | Domain terms from the codebase |
| **infrastructure/environment.md** | Node, React, TypeScript versions, browser targets |
| **infrastructure/dependencies.md** | Key packages, their roles |
| **infrastructure/tooling.md** | Bundler, lint, test, CI commands |
| **infrastructure/deployment.md** | Build output, hosting, deploy process |
| **infrastructure/security.md** | Auth approach, env var patterns |
| **features/** | One file per major feature per `features/_TEMPLATE.md` |

### 4. Output
```
Initialise complete.
Files created/updated:
- architecture/system-design.md
- architecture/component-design.md
- [list others]

Next: Run `plan frontend for TICKET-ID` when ready.
```

## After Initialise
- Do not re-run on every ticket. Use `workflow/maintenance.md` to keep files updated.
- Re-run only when knowledge files are missing or the project has changed significantly.
