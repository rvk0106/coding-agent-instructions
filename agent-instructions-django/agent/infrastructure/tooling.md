# Tooling
> Tags: linter, test, ci, formatter, quality, pytest, django
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Linting
- **flake8**: `flake8 .` (config: `.flake8` or `setup.cfg`)
  - Or **ruff**: `ruff check .` (faster, Rust-based; config: `pyproject.toml`)
- Auto-fix: `ruff check --fix .`

## Formatting
- **black**: `black .` (config: `pyproject.toml`)
- **isort**: `isort .` (import sorting; config: `pyproject.toml`)
- Check only: `black --check .` and `isort --check-only .`

## Testing
- Framework: pytest + pytest-django (or Django TestCase)
- Config: `pytest.ini` or `pyproject.toml` `[tool.pytest.ini_options]`
- Run all: `pytest`
- Run specific: `pytest apps/app_name/tests/test_views.py`
- Run by keyword: `pytest -k "test_create"`
- Run verbose: `pytest -v`
- Coverage: `pytest --cov=apps --cov-report=term-missing`
- Django check: `python manage.py test` (alternative)

## Type Checking
<!-- DELETE this section if not using mypy -->
- Tool: mypy + django-stubs
- Run: `mypy .` (config: `mypy.ini` or `pyproject.toml`)

## API Documentation
- Tool: [e.g. drf-spectacular / drf-yasg / none]
- Generate schema: `python manage.py spectacular --file schema.yml`
- Serve: `/api/docs/` (Swagger UI) or `/api/redoc/`
- Validate: `python manage.py spectacular --validate`

## Django Management Commands
```bash
python manage.py check                           # system check framework
python manage.py makemigrations --check --dry-run # verify no missing migrations
python manage.py showmigrations                   # list migration status
python manage.py shell_plus                       # enhanced shell (django-extensions)
python manage.py dbshell                          # database shell
```

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Pipeline steps: lint → format check → test → build → deploy
- Required checks before merge: [list them]

## CI Commands (typical)
```bash
flake8 .                                          # or: ruff check .
black --check .
isort --check-only .
pytest --cov=apps --cov-report=xml
python manage.py check --deploy                   # production checks
python manage.py makemigrations --check --dry-run # no missing migrations
```

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches -> main]
- Commit convention: [e.g. conventional commits / free-form]
- Pre-commit hooks: [e.g. pre-commit framework / none]

## Changelog
<!-- [PROJ-123] Switched from flake8 to ruff for linting -->
