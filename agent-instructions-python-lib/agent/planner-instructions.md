# Planner Instructions — Python Library

## Analyze patterns
- Review `pyproject.toml` or `setup.py` for package configuration
- Check `src/` or package root for module structure
- Examine `__init__.py` for public API exports
- Review `tests/` for test structure
- Check `docs/` for documentation patterns
- Review `.github/workflows/` for CI/CD
- Check type stubs (`*.pyi`) if present

## Danger zones
- Public API changes (breaking changes)
- Dependency version constraints
- Python version support changes
- Build configuration (pyproject.toml, setup.py)

## Verification commands
- Tests: `pytest` or `python -m pytest`
- Coverage: `pytest --cov=package_name`
- Lint: `flake8 src/` or `ruff check`
- Type check: `mypy src/`
- Build: `python -m build`
- Install locally: `pip install -e .`

## Save to: `docs/TICKET-ID-plan.md`
