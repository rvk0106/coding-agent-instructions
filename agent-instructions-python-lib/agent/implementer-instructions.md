# Implementer Instructions — Python Library

## Read `docs/TICKET-ID-plan.md` first

## Python library conventions
- **Public API**: Export from `__init__.py`
- **Private modules**: Prefix with `_`
- **Docstrings**: All public functions/classes (Google or NumPy style)
- **Type hints**: For all public API
- **Exceptions**: Custom exceptions for library-specific errors
- **Logging**: Use `logging` module, not `print`

## File structure
- Source: `src/package_name/` or `package_name/`
- Tests: `tests/`
- Docs: `docs/`
- Config: `pyproject.toml`, `setup.py`

## Quality rules
- Comprehensive tests (unit, integration)
- Type hints with mypy compliance
- Docstrings for all public API
- No breaking changes in minor/patch versions
- Deprecation warnings for deprecated features
- Examples in docstrings or docs

## Post-implementation
1) Run tests: `pytest`
2) Type check: `mypy src/`
3) Lint: `flake8` or `ruff check`
4) Build: `python -m build`
5) Test installation: `pip install -e .`
6) Update CHANGELOG.md
