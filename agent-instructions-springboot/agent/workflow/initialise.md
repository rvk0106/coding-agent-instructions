# Initialise
> Tags: bootstrap, onboard, project, discovery, knowledge
> Scope: Read the project and populate agent instructions so the agent has accurate context
> Trigger: `initialise project` or `bootstrap agent instructions` (or before first plan when knowledge files are empty)

## When to Run
- First time using agent instructions in this repo (knowledge files missing or empty)
- After cloning into a new project that has no `architecture/`, `infrastructure/`, or `features/` content
- When the project has changed significantly and knowledge files are stale (re-run to refresh)

## Rules
- Do not guess -- discover from the codebase, then write
- Only document what exists; use "TBD" or "Not used" where the project does not use something
- Do not write code; only read and populate markdown knowledge files

## Steps

### 1. Scan project structure
Read and summarise:
- **Layout:** `src/main/java/`, `src/main/resources/`, `src/test/`, top-level build files
- **Entry points:** `pom.xml` or `build.gradle`, main `@SpringBootApplication` class, README
- **Key config:** `application.yml`/`application.properties`, profile-specific configs, security configuration classes

### 2. Extract from codebase
Gather facts (do not invent):

| Area | Source files | Extract |
|------|--------------|---------|
| **Stack** | pom.xml/build.gradle, application.yml | Java version, Spring Boot version, key starters (web, data-jpa, security, validation) |
| **Schema** | Entity classes, Flyway/Liquibase migrations | Tables, relationships, indexes, migration conventions |
| **API** | Controllers, DTOs, OpenAPI config | Endpoints, HTTP methods, response shapes, error handling |
| **Conventions** | Controllers, services, repositories | Controller thin? Services where? DTO patterns? |
| **Auth / tenant** | SecurityConfig, JWT filter, @PreAuthorize | Auth mechanism, tenant/scope patterns, CORS |
| **Testing** | Test classes, pom.xml test deps | JUnit 5, Mockito, MockMvc, Testcontainers, test utilities |
| **Ops** | README, CI config, Dockerfile, docker-compose | Test command, lint command, CI, deploy hints |

### 3. Fill knowledge files
Populate from discovery. Create or update only these; leave workflow files as provided by install unless clearly empty and project-specific.

| File | Fill from |
|------|-----------|
| **architecture/system-design.md** | Components, data flow, tenancy from app structure and config |
| **architecture/database.md** | Entities, relationships, migration strategy from model classes and migration files |
| **architecture/api-design.md** | Endpoints, request/response shapes, versioning from controllers and DTOs |
| **architecture/patterns.md** | Controller/service/repository conventions from code |
| **architecture/error-handling.md** | HTTP codes, error payloads from @ControllerAdvice and exception classes |
| **architecture/data-flow.md** | Request lifecycle, filter chain, transaction patterns from security config and services |
| **architecture/glossary.md** | Domain terms, roles, statuses from entities and business logic |
| **infrastructure/environment.md** | Java/Spring Boot versions, DB, env vars from pom.xml/build.gradle and application.yml |
| **infrastructure/dependencies.md** | Starters, external services from pom.xml/build.gradle and config |
| **infrastructure/tooling.md** | Build tool, test commands, CI from config, README, and build files |
| **infrastructure/deployment.md** | Hosting, deploy process if present from Dockerfile, CI config |
| **infrastructure/security.md** | SecurityFilterChain, JWT, CORS, auth boundaries from security config classes |
| **features/** | One file per major feature per `features/_TEMPLATE.md`; describe current behavior |

**Workflow files:** If `workflow/testing.md` (or another workflow file) is present but generic, add only project-specific content (e.g. actual test/lint commands). Do not overwrite process instructions.

### 4. (Optional) Build context retrieval
If the project uses a **vector DB** or **reduced context index**, index the knowledge files now. See `workflow/context-retrieval.md` for when and how to re-index.

### 5. Output
Produce a short summary:
```
Initialise complete.

Context loaded from project. Files created/updated:
- architecture/system-design.md
- architecture/database.md
- [list others]

Optional: Vector index updated (if applicable).

Next: Run `plan api for TICKET-ID` when ready.
```

## After Initialise
- Do not re-run on every ticket. Use `workflow/maintenance.md` to keep knowledge files updated after each ticket.
- Re-run initialise only when knowledge files are missing, empty, or the project has changed significantly.
