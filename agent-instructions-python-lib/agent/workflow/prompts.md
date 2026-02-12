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
Add a new public function:
- Module: [package_name.module_name]
- Function: [function_name]
- Params: [list with types]
- Returns: [return type]
- Raises: [exception classes]

Before implementing, read context-router.md -> "New Public Function / Class" for full file list.

Create: function, docstring, type hints, pytest tests, update __all__.
Verify: pytest tests/test_... && mypy src/ && ruff check src/
```

## New Module
```
Add a new module:
- Package path: [package_name.module_name]
- Purpose: [what it does]
- Public functions/classes: [list]
- Dependencies: [other modules it uses]

Before implementing, read context-router.md -> "New Module" for full file list.

Create: source file under src/package_name/, test file under tests/.
Verify: pytest tests/test_... && mypy src/ && ruff check src/
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [file/area if known]

Before implementing, read context-router.md -> "Bug Fix" for full file list.

Steps: reproduce -> identify root cause -> fix -> add regression test.
Verify: pytest tests/[relevant tests] && mypy src/ && ruff check src/
```

## Configuration Change
```
Add/modify configuration:
- Option: [config.option_name]
- Type: [str/bool/int/etc.]
- Default: [default value]
- Purpose: [what it controls]

Before implementing, read context-router.md -> "Configuration Change" for full file list.

Create: config option, validation, docstring, type hints, tests.
Verify: pytest tests/test_... && mypy src/ && ruff check src/
```

## Dependency Change
```
Add/update/remove dependency:
- Package: [package_name]
- Version: [constraint]
- Type: [runtime / development]
- Justification: [why this dependency is needed]

Before implementing, read context-router.md -> "Dependency Change" for full file list.
DANGER ZONE: runtime dependencies need justification.

Update: pyproject.toml, relevant source code.
Verify: pip install -e ".[dev]" && pytest && pip-audit
```

## Error Handling
```
Add/modify error handling:
- Exception class: [PackageNameError subclass]
- Inherits from: [PackageNameError]
- Raised when: [condition]
- Message: [default message]

Before implementing, read context-router.md -> "Error Handling Change" for full file list.

Create: exception class, tests, update documentation.
Verify: pytest tests/test_... && mypy src/ && ruff check src/
```

## Refactor
```
Refactor:
- Target: [file/class/function]
- Reason: [why -- too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md -> "Refactor" for full file list.

Steps: ensure test coverage -> refactor -> verify tests still pass.
Verify: pytest && mypy src/ && ruff check src/
```

## Version Bump / Release
```
Prepare release:
- New version: [X.Y.Z]
- Bump type: [major/minor/patch]
- Changes: [summary of what changed]

Before implementing, read context-router.md -> "Version Bump / Release" for full file list.
DANGER ZONE: publishing requires human approval.

Update: __version__, CHANGELOG.md, verify build.
Verify: python -m build && pytest && mypy src/ && ruff check src/
```
