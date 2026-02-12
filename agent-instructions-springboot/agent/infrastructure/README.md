# Infrastructure

Environment, dependencies, tooling, deployment, and security documentation. Agents read these files to understand the project's runtime environment and operational constraints.

## Files

| File | Purpose | When to Read |
|------|---------|--------------|
| `environment.md` | Java/Spring Boot versions, DB, services, env vars, local setup | Environment-related changes, first-time setup |
| `dependencies.md` | Spring starters, external services, internal APIs | Adding dependencies, integrating services |
| `tooling.md` | Build tools, testing, linting, CI/CD, code quality | Running tests, builds, CI-related changes |
| `deployment.md` | Environments, deploy process, secrets management | Deploy-related changes, infrastructure updates |
| `security.md` | Spring Security config, JWT, CORS, CSRF, input validation | Auth changes, security-related work |

## Rules
- Fill these files during project onboarding (`workflow/initialise.md`)
- Update after every ticket via `workflow/maintenance.md`
- Tag changes with ticket IDs in Changelog sections
