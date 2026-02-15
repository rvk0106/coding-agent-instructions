# Maintenance Rules
> Tags: update, docs, post-ticket, audit
> Scope: What to update after completing a ticket

## Rule
After every ticket implementation, update the relevant instruction files.

## Decision Matrix

| What Changed | Update | Tag with Ticket ID? |
|-------------|--------|:-------------------:|
| Ruby/Rails version, env vars | `infrastructure/environment.md` | Yes |
| Added/removed gem or service | `infrastructure/dependencies.md` | Yes |
| CI/CD, linter, test config | `infrastructure/tooling.md` | Yes |
| Deploy process, hosting | `infrastructure/deployment.md` | Yes |
| DB schema, tables, indexes | `architecture/database.md` | Yes |
| Routes, URL structure | `architecture/routing.md` | Yes |
| View patterns, Turbo/Stimulus | `architecture/views.md` | Yes |
| Design patterns, conventions | `architecture/patterns.md` | Yes |
| System design, components | `architecture/system-design.md` | Yes |
| Error handling, flash patterns | `architecture/error-handling.md` | Yes |
| New feature or feature change | `features/<feature-name>.md` | No |
| Workflow process change | `workflow/<relevant>.md` | No |

## How to Tag Changes
Add a line to the `## Changelog` section at the bottom of the file:
```
## Changelog
[PROJ-123] Added Redis 7.x for session caching
[PROJ-456] Migrated from Heroku to AWS ECS
```

## Feature Docs Rule
- Feature docs describe HOW the feature works NOW
- No ticket IDs in feature docs -- keep them clean
- Overwrite/update the feature doc, don't append history
- One file per feature: `features/<feature-name>.md`

## When to Skip
- Pure refactors with no behavior change -> no feature doc update needed
- Test-only changes -> no doc update needed
- If unsure -> update the doc (over-documenting is better than stale docs)

## Knowledge Base Update
After all execution phases for a ticket are complete, update the `agent/` knowledge base so future tasks benefit from accurate context:
- Review all files changed across every phase of the ticket
- Match changes against the Decision Matrix to identify which `agent/` instruction files need updating
- For each affected file:
  - Add new patterns, conventions, or configurations introduced
  - Update or remove guidance that conflicts with the new implementation
  - Ensure inline examples reflect the current codebase state
- If a new feature was added, create or update `features/<feature-name>.md`
- If architectural decisions were made, record rationale in the relevant `architecture/` file

## Workflow Integration
This checklist runs after EVERY ticket's final phase is approved:
1. Review what changed (infra? architecture? feature behavior?)
2. Update the relevant files per the matrix above
3. Update `agent/` knowledge base per the Knowledge Base Update section above
4. Commit doc updates in the same PR as the implementation
