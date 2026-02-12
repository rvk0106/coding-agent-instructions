# Maintenance Rules
> Tags: update, docs, post-ticket, audit
> Scope: What to update after completing a ticket

## Rule
After every ticket implementation, update the relevant instruction files.

## Decision Matrix

| What Changed | Update | Tag with Ticket ID? |
|-------------|--------|:-------------------:|
| Node/browser support | `infrastructure/environment.md` | Yes |
| Added/removed npm package | `infrastructure/dependencies.md` | Yes |
| CI/CD, linter, bundler config | `infrastructure/tooling.md` | Yes |
| Hosting/deploy process | `infrastructure/deployment.md` | Yes |
| Route/page structure | `architecture/system-design.md` | Yes |
| Component patterns | `architecture/component-design.md` | Yes |
| State management approach | `architecture/state-management.md` | Yes |
| Design tokens, themes, breakpoints | `architecture/styling.md` | Yes |
| Coding conventions, TypeScript | `architecture/patterns.md` | Yes |
| Error handling approach | `architecture/error-handling.md` | Yes |
| API integration, data fetching | `architecture/data-flow.md` | Yes |
| Accessibility patterns | `architecture/accessibility.md` | Yes |
| New feature or feature change | `features/<feature-name>.md` | No |
| Workflow process change | `workflow/<relevant>.md` | No |

## How to Tag Changes
Add a line to the `## Changelog` section at the bottom of the file:
```
## Changelog
[PROJ-123] Added dark mode theme support
[PROJ-456] Migrated from Redux to Zustand
```

## Feature Docs Rule
- Feature docs describe HOW the feature works NOW
- No ticket IDs in feature docs -- keep them clean
- Overwrite/update the feature doc, don't append history
- One file per feature: `features/<feature-name>.md`

## When to Skip
- Pure refactors with no behavior change → no feature doc update needed
- Test-only changes → no doc update needed
- If unsure → update the doc

## Workflow Integration
This checklist runs after EVERY ticket's final phase is approved:
1. Review what changed (infra? architecture? feature behavior?)
2. Update the relevant files per the matrix above
3. Commit doc updates in the same PR as the implementation
