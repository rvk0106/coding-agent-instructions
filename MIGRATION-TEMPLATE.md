# Migration Template: Flat → 4-Category Structure
> Reference: `agent-instructions-rails/agent/` is the working example.
> Use this to migrate any framework from flat files to the organized structure.

## File Mapping (old → new)

| Old Flat File | New Location | Notes |
|--------------|-------------|-------|
| `principles-and-standards.md` | `architecture/patterns.md` | Coding conventions + quality checklist |
| `planner-instructions.md` | `workflow/planning.md` | Planning steps + context router integration |
| `execution-contract.md` | `workflow/execution.md` | Phase execution + plan-referenced context |
| `implementer-instructions.md` | `workflow/implementation.md` | Framework-specific coding rules |
| `testing-instructions.md` | `workflow/testing.md` | Verification commands |
| `ticket-access.md` | `workflow/ticket-access.md` | Ticket fetching (same content, new location) |
| _(new)_ | `workflow/context-router.md` | Task-type → file mapping |
| _(new)_ | `workflow/maintenance.md` | Post-ticket update rules |
| _(new)_ | `workflow/prompts.md` | Pre-built prompts |
| _(new)_ | `architecture/system-design.md` | High-level components |
| _(new)_ | `architecture/database.md` | Schema, tables, relationships |
| _(new)_ | `architecture/api-design.md` | Endpoints, response shapes |
| _(new)_ | `architecture/error-handling.md` | HTTP codes, error patterns |
| _(new)_ | `architecture/data-flow.md` | Request lifecycle, middleware |
| _(new)_ | `architecture/glossary.md` | Domain terms |
| _(new)_ | `infrastructure/environment.md` | Runtime, versions, DB |
| _(new)_ | `infrastructure/dependencies.md` | Packages, external services |
| _(new)_ | `infrastructure/tooling.md` | Linters, test runners, CI/CD |
| _(new)_ | `infrastructure/deployment.md` | Hosting, deploy process |
| _(new)_ | `infrastructure/security.md` | Auth boundaries, OWASP rules |
| _(new)_ | `features/_TEMPLATE.md` | Per-feature doc template |
| _(new)_ | `features/_CONVENTIONS.md` | Serialization, query, test patterns |
| `master-instructions.md` | `master-instructions.md` | Rewrite to v2 (index + context router) |

## Target Directory Structure
```
agent/
├── master-instructions.md
├── architecture/
│   ├── README.md
│   ├── system-design.md
│   ├── database.md
│   ├── api-design.md
│   ├── patterns.md
│   ├── error-handling.md
│   ├── data-flow.md
│   └── glossary.md
├── infrastructure/
│   ├── README.md
│   ├── environment.md
│   ├── dependencies.md
│   ├── tooling.md
│   ├── deployment.md
│   └── security.md
├── workflow/
│   ├── README.md
│   ├── context-router.md
│   ├── planning.md
│   ├── execution.md
│   ├── implementation.md
│   ├── testing.md
│   ├── maintenance.md
│   ├── ticket-access.md
│   └── prompts.md
├── features/
│   ├── README.md
│   ├── _TEMPLATE.md
│   └── _CONVENTIONS.md
└── examples/
    └── sample-ticket-plan.md
```

## Framework Adaptation Guide

### What stays IDENTICAL across all frameworks
These files are framework-agnostic — copy from Rails and use as-is:

| File | Why it's universal |
|------|--------------------|
| `workflow/context-router.md` | Task-type → file mapping (same categories) |
| `workflow/planning.md` | Planning steps (swap codebase analysis section only) |
| `workflow/execution.md` | Phase execution rules (universal) |
| `workflow/maintenance.md` | Post-ticket update matrix (universal) |
| `workflow/ticket-access.md` | Ticket fetching (universal) |
| `architecture/README.md` | Index table (universal) |
| `infrastructure/README.md` | Index table (universal) |
| `workflow/README.md` | Index table (universal) |
| `features/README.md` | Feature doc rules (universal) |
| `features/_TEMPLATE.md` | Swap file paths in Key Components table |
| `master-instructions.md` | Swap framework name in title, rest is universal |

### What needs framework-specific content
These files must be rewritten for each framework:

#### `workflow/implementation.md` — Coding Rules
```
Adapt per framework:
- Rails: controllers thin, services for logic, strong params
- Spring Boot: Controller → Service → Repository, DTOs, Bean injection
- Django: Views → Serializers → Models, DRF patterns, queryset managers
- Express: Route → Controller → Service, middleware, joi/zod validation
- React: Components → Hooks → Context/Store, prop types, a11y rules
- Python Lib: Public API, type hints, docstrings, backwards compat
- Node Lib: Exports, TypeScript, semver, tree-shaking
- Ruby Gem: Public API, yard docs, semver, backwards compat

Adapt file locations table per framework.
Adapt API response shape per framework.
```

#### `workflow/testing.md` — Verification Commands
```
Adapt per framework:
- Rails: bundle exec rspec, rubocop, swagger:generate
- Spring Boot: ./mvnw test, checkstyle:check, openapi-generator
- Django: python manage.py test / pytest, flake8, mypy
- Express: npm test (jest/mocha), npm run lint (eslint), supertest
- React: npm test (vitest/jest), npm run lint, npm run build
- Python Lib: pytest, flake8, mypy, tox
- Node Lib: npm test, npm run lint, npm run build, npm run typecheck
- Ruby Gem: bundle exec rspec, rubocop, yard
```

#### `workflow/prompts.md` — Pre-Built Prompts
```
Adapt verify commands in each prompt.
Adapt "Before implementing, read:" references (same structure, different patterns).
Adapt task types to framework:
- Backend (Rails/Spring/Django/Express): endpoint, model, job, migration, policy
- Frontend (React): component, hook, page, route, state management
- Library (Python/Node/Ruby): public API method, type, test, docs, release
```

#### `architecture/patterns.md` — Design Patterns
```
Migrate from old principles-and-standards.md.
Adapt controller/model/service patterns to framework equivalents.
Adapt quality checklist (lint, test, docs commands).
```

#### `architecture/api-design.md` — API Design
```
Backend frameworks: endpoint naming, response shape, pagination, versioning.
Frontend (React): API client patterns, data fetching, error handling.
Libraries: public API design, method signatures, return types.
```

#### `architecture/error-handling.md` — Error Handling
```
Backend: HTTP status map, error response shape, exception mapping.
Frontend: Error boundaries, toast/notification patterns, retry logic.
Libraries: Exception hierarchy, error codes, custom error classes.
```

#### `architecture/data-flow.md` — Request/Data Lifecycle
```
Backend: HTTP request → middleware → controller → service → DB → response.
Frontend: User action → event → state update → re-render → side effects.
Libraries: Input → validation → processing → output.
```

#### `architecture/database.md` — Data Storage
```
Backend: DB engine, schema, tables, relationships, migration conventions.
Frontend: State management (Redux/Zustand/Context), local storage, cache.
Libraries: N/A or internal data structures.
```

#### `infrastructure/environment.md` — Runtime
```
Adapt: language version, framework version, DB, package manager, env vars.
```

#### `infrastructure/dependencies.md` — Packages
```
Adapt: key packages/gems/modules, external services, internal APIs.
```

#### `infrastructure/tooling.md` — Dev Tools
```
Adapt: linter, formatter, test runner, CI/CD, code quality tools.
```

#### `infrastructure/security.md` — Security Rules
```
Backend: strong params, SQL injection, tenant scoping, CSRF, auth checks.
Frontend: XSS prevention, CSP, token storage, input sanitization.
Libraries: input validation, dependency scanning, no eval/exec.
```

#### `features/_CONVENTIONS.md` — Implementation Patterns
```
Adapt code examples to framework:
- Serialization patterns
- Query/data fetching patterns
- Test data patterns (factories, fixtures, mocks)
- Test template (request/component/unit spec)
```

#### `architecture/system-design.md`, `glossary.md`, `infrastructure/deployment.md`
```
These are project-specific, not framework-specific.
Fill in during initial setup for each project.
Use the Rails templates as the format reference.
```

## Migration Checklist

```
For framework: _______________

1. [ ] Create directories: architecture/, infrastructure/, workflow/, features/
2. [ ] Copy universal files from Rails (see table above)
3. [ ] Migrate old flat files:
   - [ ] principles-and-standards.md → architecture/patterns.md (rewrite for framework)
   - [ ] planner-instructions.md → workflow/planning.md (swap codebase analysis section)
   - [ ] execution-contract.md → workflow/execution.md (copy from Rails)
   - [ ] implementer-instructions.md → workflow/implementation.md (rewrite for framework)
   - [ ] testing-instructions.md → workflow/testing.md (swap commands)
   - [ ] ticket-access.md → workflow/ticket-access.md (copy as-is)
4. [ ] Create new files with framework-specific content:
   - [ ] workflow/context-router.md (copy from Rails)
   - [ ] workflow/maintenance.md (copy from Rails)
   - [ ] workflow/prompts.md (adapt verify commands)
   - [ ] architecture/system-design.md (template — fill per project)
   - [ ] architecture/database.md (adapt to framework's data layer)
   - [ ] architecture/api-design.md (adapt to framework's API patterns)
   - [ ] architecture/error-handling.md (adapt to framework's error patterns)
   - [ ] architecture/data-flow.md (adapt to framework's request lifecycle)
   - [ ] architecture/glossary.md (template — fill per project)
   - [ ] infrastructure/environment.md (adapt to framework's runtime)
   - [ ] infrastructure/dependencies.md (adapt to framework's packages)
   - [ ] infrastructure/tooling.md (adapt to framework's tools)
   - [ ] infrastructure/deployment.md (template — fill per project)
   - [ ] infrastructure/security.md (adapt to framework's security patterns)
   - [ ] features/_TEMPLATE.md (swap file paths)
   - [ ] features/_CONVENTIONS.md (rewrite for framework's patterns)
5. [ ] Rewrite master-instructions.md to v2 format (copy Rails, swap framework name)
6. [ ] Delete old flat files
7. [ ] Update examples/sample-ticket-plan.md with Context Loaded sections
8. [ ] Verify: all cross-references between files are correct
```

## Content Format Rules (all files)

```
Header format:
  # Title
  > Tags: keyword1, keyword2, keyword3
  > Scope: 1-line description of what this file covers
  > Last updated: [TICKET-ID or date]

Body rules:
  - Bullet-point dense, no paragraphs
  - Code examples: CORRECT/WRONG pattern with comments
  - Tables for mappings (status codes, file locations, etc.)
  - Changelog section at bottom of architecture/ and infrastructure/ files
  - NO changelog in features/ or workflow/ files
```
