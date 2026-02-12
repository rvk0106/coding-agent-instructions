# Tooling
> Tags: linter, test, ci, formatter, quality, docs, mypy
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Linting & Formatting
- Ruff (preferred): `ruff check src/ tests/` (lint) + `ruff format src/ tests/` (format)
- Alternative: flake8 (`flake8 src/`) + black (`black src/`) + isort (`isort src/`)
- Config: `pyproject.toml` `[tool.ruff]` section or `ruff.toml`
- Auto-fix: `ruff check --fix src/ tests/`

## Type Checking
- mypy: `mypy src/`
- Config: `pyproject.toml` `[tool.mypy]` section
- Strict mode recommended: `strict = true` in config
```toml
[tool.mypy]
strict = true
warn_return_any = true
warn_unused_configs = true
```

## Testing
- Framework: pytest
- Run all: `pytest`
- Run specific: `pytest tests/test_module.py`
- Run by marker: `pytest -m "not slow"`
- Coverage: `pytest --cov=package_name --cov-report=html`
- Multi-version: `tox` (runs tests across Python 3.9-3.13)

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-ra -q"
```

## Documentation
- Tool: [Sphinx / MkDocs / none]
- Generate: `cd docs && make html` (Sphinx) or `mkdocs build` (MkDocs)
- Serve locally: `mkdocs serve` or `python -m http.server -d docs/_build/html`
- Docstring style: [Google / NumPy] -- consistent across package

## Build & Install
- Build: `python -m build`
- Install locally (editable): `pip install -e ".[dev]"`
- Verify build: `pip install dist/*.whl` (in a clean venv)
- Console / REPL: `python -c "import package_name; print(package_name.__version__)"`

## CI/CD
- Platform: [e.g. GitHub Actions / GitLab CI / CircleCI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Matrix: [e.g. Python 3.9, 3.10, 3.11, 3.12, 3.13 on ubuntu-latest]
- Pipeline steps: lint -> type-check -> test -> build
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches -> main]
- Commit convention: [e.g. conventional commits / free-form]

## Tox Configuration
```toml
# tox.toml or [tool.tox] in pyproject.toml
[tox]
env_list = py39, py310, py311, py312, py313, lint, type

[testenv]
deps = pytest
commands = pytest {posargs}

[testenv:lint]
deps = ruff
commands = ruff check src/ tests/

[testenv:type]
deps = mypy
commands = mypy src/
```

## Changelog
<!-- [PROJ-123] Migrated from flake8+black+isort to ruff -->
