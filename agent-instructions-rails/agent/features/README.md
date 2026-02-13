# Features

Living documentation of how each feature works. Agents read these to understand existing behavior before planning or implementing changes.

## Rules
- One file per feature: `features/<feature-name>.md`
- Describes HOW the feature works NOW (not history)
- No ticket IDs -- keep clean, consolidated
- Update after every ticket that changes feature behavior
- Use the template: `features/_TEMPLATE.md`

## Example Files
```
features/
├── README.md          (this file)
├── _TEMPLATE.md       (copy for new features)
├── authentication.md  (how auth works)
├── user-management.md (how users are managed)
├── dashboard.md       (how the dashboard works)
├── billing.md         (how billing works)
└── ...
```
