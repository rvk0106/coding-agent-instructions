# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the Java library project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this Java library repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess — discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `src/main/java/`, `src/test/java/`, `src/main/resources/`
- **Entry points:** `pom.xml` or `build.gradle`, `module-info.java` (if present), main API classes
- **Key config:** `config/checkstyle/`, `.github/workflows/`, `spotbugs-exclude.xml`

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | pom.xml / build.gradle | Java version, runtime deps, dev deps, plugins |
| **Structure** | src/main/java/ | Package hierarchy, module layout, class organization |
| **Public API** | api/ package, public classes/interfaces | Entry points, method signatures, return types |
| **Errors** | exception/ package | Exception hierarchy, exception classes |
| **Configuration** | config/ package, builder classes | Options, defaults, validation |
| **Testing** | src/test/java/, pom.xml plugins | JUnit 5 version, Mockito, AssertJ, coverage tools |
| **Ops** | README, .github/, pom.xml profiles | Test command, lint command, CI, release process |

### 3. Fill knowledge files
Populate from discovery. Create or update only these:

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Package structure, components, data flow from src/ |
| **architecture/public-api.md** | Public classes/methods, signatures, return types from source |
| **architecture/patterns.md** | Coding conventions, design patterns from code |
| **architecture/error-handling.md** | Exception classes, error hierarchy from source |
| **architecture/data-flow.md** | Call flow, thread safety, hooks from code |
| **architecture/glossary.md** | Domain terms, concepts from models and business logic |
| **infrastructure/environment.md** | Java versions, JDK support from pom.xml/build.gradle |
| **infrastructure/dependencies.md** | Runtime and dev deps from pom.xml/build.gradle |
| **infrastructure/tooling.md** | Build commands, linters, CI from config and README |
| **infrastructure/publishing.md** | Release process, pom.xml/build.gradle config |
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
