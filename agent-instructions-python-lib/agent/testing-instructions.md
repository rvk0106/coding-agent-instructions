# Testing Instructions — Python Library

## Source: `docs/TICKET-ID-plan.md`

## Fast checks
- Unit tests: `pytest tests/test_module.py`
- Type check: `mypy src/`
- Lint: `flake8 src/`

## Full checks
- All tests: `pytest --cov=package_name --cov-report=html`
- Docs build: `cd docs && make html`
- Package build: `python -m build`
- Install test: `pip install dist/*.whl`

## Library-specific
- Test across Python versions (tox or CI)
- Verify public API exports
- Check for backward compatibility
- Test example code in docstrings
