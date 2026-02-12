# Maintenance Rules
> Tags: update, docs, post-ticket, audit
> Scope: What to update after completing a ticket

## Rule
After every ticket implementation, update the relevant instruction files.

## Decision Matrix

| What Changed | Update | Tag with Ticket ID? |
|-------------|--------|:-------------------:|
| Node.js version support | `infrastructure/environment.md` | Yes |
| Added/removed npm dependency | `infrastructure/dependencies.md` | Yes |
| CI/CD, linter, test config | `infrastructure/tooling.md` | Yes |
| Release/publish process | `infrastructure/publishing.md` | Yes |
| Module structure, components | `architecture/system-design.md` | Yes |
| Public API exports/types | `architecture/public-api.md` | Yes |
| Design patterns, conventions | `architecture/patterns.md` | Yes |
| Error classes, error handling | `architecture/error-handling.md` | Yes |
| Call flow, plugin chain | `architecture/data-flow.md` | Yes |
| New feature or feature change | `features/<feature-name>.md` | No |
| Workflow process change | `workflow/<relevant>.md` | No |

## How to Tag Changes
Add a line to the `## Changelog` section at the bottom of the file:
```
## Changelog
[PROJ-123] Added retry logic for HTTP client
[PROJ-456] Dropped Node.js 16 support
```

## Feature Docs Rule
- Feature docs describe HOW the feature works NOW
- No ticket IDs in feature docs -- keep them clean
- Overwrite/update the feature doc, don't append history
- One file per feature: `features/<feature-name>.md`

## When to Skip
- Pure refactors with no behavior change → no feature doc update needed
- Test-only changes → no doc update needed
- If unsure → update the doc (over-documenting is better than stale docs)

## Workflow Integration
This checklist runs after EVERY ticket's final phase is approved:
1. Review what changed (infra? architecture? feature behavior?)
2. Update the relevant files per the matrix above
3. Commit doc updates in the same PR as the implementation
