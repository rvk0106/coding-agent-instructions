# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common tasks -- saves agents from re-discovering patterns
> Last updated: [TICKET-ID or date]

## Quick Reference
| Task | Prompt |
|------|--------|
| New Public Method | `plan gem for TICKET-ID` then use "New Public Method" below |
| New Module / Class | Use "New Module / Class" prompt below |
| Bug Fix | `plan gem for TICKET-ID` then use "Bug Fix" below |
| Configuration Change | Use "Configuration Change" prompt below |
| Dependency Change | Use "Dependency Change" prompt below |
| Error Handling | Use "Error Handling" prompt below |
| Refactor | Use "Refactor" prompt below |
| Version Bump / Release | Use "Version Bump / Release" prompt below |

---

## New Public Method
```
Add a new public method:
- Module/Class: [GemName::ClassName]
- Method: [method_name]
- Params: [list with types]
- Returns: [return type]
- Raises: [error classes]

Before implementing, read context-router.md → "New Public Method / Feature" for full file list.

Create: method, YARD docs, RSpec specs.
Verify: bundle exec rspec spec/... && bundle exec rubocop && yard stats --list-undoc
```

## New Module / Class
```
Add a new module/class:
- Namespace: [GemName::ModuleName]
- Purpose: [what it does]
- Public methods: [list]
- Dependencies: [other modules it uses]

Before implementing, read context-router.md → "New Module / Class" for full file list.

Create: source file under lib/gem_name/, spec file under spec/gem_name/.
Verify: bundle exec rspec spec/... && bundle exec rubocop
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/area if known]

Before implementing, read context-router.md → "Bug Fix" for full file list.

Steps: reproduce → identify root cause → fix → add regression test.
Verify: bundle exec rspec [relevant specs] && bundle exec rubocop
```

## Configuration Change
```
Add/modify configuration:
- Option: [config.option_name]
- Type: [String/Boolean/Integer/etc.]
- Default: [default value]
- Purpose: [what it controls]

Before implementing, read context-router.md → "Configuration Change" for full file list.

Create: config option, validation, YARD docs, specs.
Verify: bundle exec rspec spec/... && bundle exec rubocop
```

## Dependency Change
```
Add/update/remove dependency:
- Gem: [gem_name]
- Version: [constraint]
- Type: [runtime / development]
- Justification: [why this dependency is needed]

Before implementing, read context-router.md → "Dependency Change" for full file list.
DANGER ZONE: runtime dependencies need justification.

Update: gemspec, Gemfile, relevant source code.
Verify: bundle install && bundle exec rspec && bundle audit check
```

## Error Handling
```
Add/modify error handling:
- Error class: [GemName::NewError]
- Inherits from: [GemName::Error]
- Raised when: [condition]
- Message: [default message]

Before implementing, read context-router.md → "Error Handling Change" for full file list.

Create: error class, specs, update documentation.
Verify: bundle exec rspec spec/... && bundle exec rubocop
```

## Refactor
```
Refactor:
- Target: [file/class/method]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md → "Refactor" for full file list.

Steps: ensure test coverage → refactor → verify tests still pass.
Verify: bundle exec rspec && bundle exec rubocop
```

## Version Bump / Release
```
Prepare release:
- New version: [X.Y.Z]
- Bump type: [major/minor/patch]
- Changes: [summary of what changed]

Before implementing, read context-router.md → "Version Bump / Release" for full file list.
DANGER ZONE: publishing requires human approval.

Update: version.rb, CHANGELOG.md, verify build.
Verify: gem build *.gemspec && bundle exec rspec && bundle exec rubocop
```
