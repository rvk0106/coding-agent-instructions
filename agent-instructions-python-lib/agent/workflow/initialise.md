# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the Python package project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this package repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess -- discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `src/`, `tests/`, `docs/`, `scripts/` if present
- **Entry points:** `src/package_name/__init__.py`, `pyproject.toml`, `setup.py`, `setup.cfg`, README
- **Key config:** `pyproject.toml` (all tool sections), `tox.ini`, `.github/workflows/`, `mypy.ini`

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | pyproject.toml, setup.py | Python version, runtime deps, dev deps, build backend |
| **Structure** | src/package_name/ | Module hierarchy, package layout, private vs public modules |
| **Public API** | __init__.py, __all__ | Entry points, function signatures, class interfaces, type hints |
| **Errors** | exceptions.py (or similar) | Exception hierarchy, error classes |
| **Configuration** | Config dataclass / configure function | Options, defaults, validation |
| **Testing** | conftest.py, pyproject.toml [tool.pytest] | pytest config, fixtures, markers, coverage |
| **Ops** | README, pyproject.toml, .github/, tox.ini | Test command, lint command, CI, release process |

### 3. Fill knowledge files
Populate from discovery. Create or update only these:

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Module structure, components, data flow from src/ |
| **architecture/public-api.md** | Public functions, signatures, type hints, __all__ from source |
| **architecture/patterns.md** | Coding conventions, module patterns from code |
| **architecture/error-handling.md** | Exception classes, error hierarchy from source |
| **architecture/data-flow.md** | Call flow, hooks, external calls from code |
| **architecture/glossary.md** | Domain terms, concepts from modules and business logic |
| **infrastructure/environment.md** | Python versions, platform support from pyproject.toml |
| **infrastructure/dependencies.md** | Runtime and dev deps from pyproject.toml |
| **infrastructure/tooling.md** | Linters, test commands, CI from config and README |
| **infrastructure/publishing.md** | Release process, pyproject.toml config |
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
