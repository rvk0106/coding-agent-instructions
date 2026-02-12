# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New Public Function | `plan library for TICKET-ID` then use "New Public Function" below |
| New Module | Use "New Module" prompt below |
| Bug Fix | `plan library for TICKET-ID` then use "Bug Fix" below |
| Configuration Change | Use "Configuration Change" prompt below |
| Dependency Change | Use "Dependency Change" prompt below |
| Error Handling | Use "Error Handling" prompt below |
| Refactor | Use "Refactor" prompt below |
| Version Bump / Release | Use "Version Bump / Release" prompt below |

---

## New Public Function
```
Add a new exported function:
- Module: [src/core/module.ts]
- Function: [functionName]
- Params: [list with types]
- Returns: [return type]
- Throws: [error classes]

Before implementing, read context-router.md → "New Public Method / Function" for full file list.

Create: function, TSDoc, types, tests.
Verify: npm test -- --testPathPattern=... && npm run lint && tsc --noEmit
```

## New Module
```
Add a new module:
- Location: [src/core/module-name.ts]
- Purpose: [what it does]
- Exports: [list of exports]
- Dependencies: [other modules it uses]

Before implementing, read context-router.md → "New Module" for full file list.

Create: source file under src/, test file under tests/.
Verify: npm test -- --testPathPattern=... && npm run lint && tsc --noEmit
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/area if known]

Before implementing, read context-router.md → "Bug Fix" for full file list.

Steps: reproduce → identify root cause → fix → add regression test.
Verify: npm test -- --testPathPattern=[relevant tests] && npm run lint
```

## Configuration Change
```
Add/modify configuration:
- Option: [options.optionName]
- Type: [string / number / boolean / etc.]
- Default: [default value]
- Purpose: [what it controls]

Before implementing, read context-router.md → "Configuration Change" for full file list.

Create: config option, validation, TSDoc, types, tests.
Verify: npm test -- --testPathPattern=... && npm run lint && tsc --noEmit
```

## Dependency Change
```
Add/update/remove dependency:
- Package: [package-name]
- Version: [constraint]
- Type: [runtime / dev / peer]
- Justification: [why this dependency is needed]

Before implementing, read context-router.md → "Dependency Change" for full file list.
DANGER ZONE: runtime dependencies need justification + bundle size check.

Update: package.json, relevant source code.
Verify: npm install && npm test && npm audit
```

## Error Handling
```
Add/modify error handling:
- Error class: [LibNameNewError]
- Extends: [LibNameError]
- Code: [ERR_NEW_ERROR]
- Thrown when: [condition]
- Message: [default message]

Before implementing, read context-router.md → "Error Handling Change" for full file list.

Create: error class, tests, update error hierarchy docs.
Verify: npm test -- --testPathPattern=... && npm run lint && tsc --noEmit
```

## Refactor
```
Refactor:
- Target: [file/module/function]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md → "Refactor" for full file list.

Steps: ensure test coverage → refactor → verify tests still pass.
Verify: npm test && npm run lint && tsc --noEmit
```

## Version Bump / Release
```
Prepare release:
- New version: [X.Y.Z]
- Bump type: [major/minor/patch]
- Changes: [summary of what changed]

Before implementing, read context-router.md → "Version Bump / Release" for full file list.
DANGER ZONE: publishing requires human approval.

Update: package.json version, CHANGELOG.md, verify build.
Verify: npm run build && npm test && npm run lint && npm publish --dry-run
```
