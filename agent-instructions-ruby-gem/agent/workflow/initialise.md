# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the gem project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this gem repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess — discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `lib/`, `spec/`, `bin/`, `exe/` if present
- **Entry points:** `lib/gem_name.rb`, `gem_name.gemspec`, Gemfile, README
- **Key config:** `.rubocop.yml`, `.github/workflows/`, `.rspec`

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | gemspec, Gemfile | Ruby version, runtime deps, dev deps |
| **Structure** | lib/gem_name/ | Module hierarchy, namespace layout, class organization |
| **Public API** | lib/gem_name.rb, public methods | Entry points, method signatures, return types |
| **Errors** | lib/gem_name/errors.rb (or similar) | Exception hierarchy, error classes |
| **Configuration** | Configuration class / DSL | Options, defaults, validation |
| **Testing** | spec/spec_helper.rb, .rspec, Gemfile | RSpec version, matchers, coverage tools |
| **Ops** | README, Rakefile, .github, gemspec | Test command, lint command, CI, release process |

### 3. Fill knowledge files
Populate from discovery. Create or update only these:

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Module structure, components, data flow from lib/ |
| **architecture/public-api.md** | Public methods, signatures, return types from source |
| **architecture/patterns.md** | Coding conventions, module patterns from code |
| **architecture/error-handling.md** | Exception classes, error hierarchy from source |
| **architecture/data-flow.md** | Call flow, middleware, hooks from code |
| **architecture/glossary.md** | Domain terms, concepts from models and business logic |
| **infrastructure/environment.md** | Ruby versions, platform support from gemspec |
| **infrastructure/dependencies.md** | Runtime and dev deps from gemspec/Gemfile |
| **infrastructure/tooling.md** | Linters, test commands, CI from config and README |
| **infrastructure/publishing.md** | Release process, gemspec config |
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

Next: Run `plan gem for TICKET-ID` when ready.
```

## After Initialise
- Do not re-run on every ticket. Use `workflow/maintenance.md` to keep knowledge files updated after each ticket.
- Re-run initialise only when knowledge files are missing, empty, or the project has changed significantly.
