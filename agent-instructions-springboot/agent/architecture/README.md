# Architecture

Technical design documentation for this Spring Boot application. Agents read these files during planning to understand system structure, conventions, and constraints.

## Files

| File | Purpose | When to Read |
|------|---------|--------------|
| `system-design.md` | High-level app structure, components, auth, tenancy | First planning, major architecture changes |
| `database.md` | Schema, tables, relationships, JPA conventions, migrations | DB changes, new entities, model changes |
| `api-design.md` | REST conventions, response shapes, versioning, endpoints | New/modified endpoints, API changes |
| `patterns.md` | Design patterns, coding standards, quality checklist | Every implementation phase |
| `error-handling.md` | Exception hierarchy, HTTP code mapping, error response shape | New endpoints, error-related changes |
| `data-flow.md` | Request lifecycle, filter chain, transactions, async flows | Flow-related changes, middleware, auth pipeline |
| `glossary.md` | Domain terms, roles, status definitions | When domain terms are unclear |

## Rules
- Fill these files during project onboarding (`workflow/initialise.md`)
- Update after every ticket via `workflow/maintenance.md`
- Tag changes with ticket IDs in Changelog sections
