# Dependencies
> Tags: packages, pyproject, runtime, development, external
> Scope: All dependencies the package relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- **Minimal runtime dependencies** -- fewer deps = fewer conflicts for consumers
- Prefer stdlib over third-party where practical
- Use compatible version ranges (e.g. `>=1.0,<3.0`) not exact pins
- Every runtime dependency must be justified

## Runtime Dependencies (pyproject.toml)
<!-- List packages added as runtime dependencies -->
| Package | Version Constraint | Purpose | Justification |
|---------|-------------------|---------|---------------|
| [e.g. `httpx`] | `>=0.24,<1.0` | HTTP client | [why not urllib3 or urllib.request] |
| [e.g. none] | - | - | Prefer zero runtime deps |

## Development Dependencies
<!-- List packages in [project.optional-dependencies] dev -->
| Package | Purpose |
|---------|---------|
| `pytest` | Test framework |
| `pytest-cov` | Coverage plugin for pytest |
| `mypy` | Static type checker |
| `ruff` | Linter and formatter (replaces flake8, isort, black) |
| `coverage[toml]` | Code coverage measurement |
| `build` | PEP 517 package builder |
| `twine` | PyPI upload tool |
| `tox` | Multi-version test runner |
| `sphinx` or `mkdocs` | Documentation generator |
| [Add project-specific dev deps] |

## External Services
<!-- Services the package talks to (if any) -->
- [e.g. REST API at api.example.com]
- [e.g. none -- pure Python library]

## Adding Dependencies
Before adding a new runtime dependency:
1. Check if Python stdlib can do the job (`urllib.request`, `json`, `pathlib`, `dataclasses`, etc.)
2. Check the package's maintenance status (last release, open issues, bus factor)
3. Check download counts and community adoption
4. Check for version conflicts with popular packages
5. Document the justification in this file
6. Use the loosest compatible version constraint that works
7. Add to `[project.dependencies]` in `pyproject.toml`

## Dependency Auditing
```bash
# Check for known vulnerabilities
pip-audit

# Check for outdated packages
pip list --outdated

# Pin for reproducibility (dev only)
pip freeze > requirements-dev.txt
```

## Changelog
<!-- [PROJ-123] Added httpx >=0.24 for HTTP client -->
