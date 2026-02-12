# Testing
> Tags: test, verify, pytest, mypy, ruff, build
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
pytest tests/test_module.py           # tests for touched files
mypy src/                             # type check
ruff check src/                       # lint (if installed)
```

## Full Checks (when required)
```bash
pytest --cov=package_name --cov-report=html   # full suite with coverage
mypy src/                                      # full type check
ruff check src/ tests/                         # full lint
python -m build                                # verify package builds
```

## Build Checks (when pyproject.toml or version changed)
```bash
python -m build                                # verify package builds
pip install dist/*.whl                         # verify package installs (clean venv)
python -c "import package_name; print(package_name.__version__)"  # verify import works
```

## Dependency Checks (when dependencies changed)
```bash
pip-audit                                      # security audit (if installed)
pip list --outdated                            # check for outdated deps
```

## Multi-Version Checks (before release)
```bash
tox                                            # run tests across Python 3.9-3.13
```

## Library-Specific Verification
- Test across Python versions (tox or CI matrix)
- Verify public API exports (`from package_name import *` works correctly)
- Test docstring examples (`pytest --doctest-modules` if enabled)
- Check backward compatibility (existing tests still pass)
- Verify `py.typed` marker is present (PEP 561)

## CI Commands
```bash
ruff check src/ tests/                         # lint
mypy src/                                      # type check
pytest --cov=package_name --cov-report=xml     # tests with coverage
python -m build                                # build verification
```

## Reporting Format
```
Commands run:
- `pytest tests/test_module.py` -> PASS/FAIL
- `mypy src/` -> PASS/FAIL (N errors)
- `ruff check src/` -> PASS/FAIL (N issues)
If FAIL -> STOP and ask before continuing
```
