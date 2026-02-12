# Environment
> Tags: python, runtime, versions, os, virtualenv
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Python: [e.g. >= 3.9]
- Package manager: [e.g. pip / poetry / pdm / hatch]
- Build backend: [e.g. setuptools / hatchling / flit-core / pdm-backend]

## Supported Python Versions
<!-- List all versions the package supports and tests against -->
| Version | Status |
|---------|--------|
| 3.13 | Primary |
| 3.12 | Supported |
| 3.11 | Supported |
| 3.10 | Supported |
| 3.9 | Minimum |

## Platform Support
- CPython: [yes/no]
- PyPy: [yes/no]
- OS: [Linux / macOS / Windows / all]

## Virtual Environment Setup
```bash
# Option A: venv (stdlib)
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
# .venv\Scripts\activate   # Windows
pip install -e ".[dev]"

# Option B: Poetry
poetry install

# Option C: PDM
pdm install
```

## pyproject.toml Structure
```toml
[build-system]
requires = ["setuptools>=68.0", "setuptools-scm>=8.0"]
build-backend = "setuptools.build_meta"

[project]
name = "package-name"
requires-python = ">=3.9"
# ...

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "mypy>=1.0",
    "ruff>=0.1.0",
    "coverage[toml]>=7.0",
]
```

## Development Setup
```bash
# Minimum commands to get running
git clone [repo]
cd package-name
python -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
pytest
```

## CI Matrix
```yaml
# Example GitHub Actions matrix
strategy:
  matrix:
    python-version: ["3.9", "3.10", "3.11", "3.12", "3.13"]
    os: [ubuntu-latest]
```

## Environment Variables
<!-- List any env vars the package uses (for testing or optional features) -->
- [e.g. `PACKAGE_NAME_API_KEY` -- optional, for integration tests]
- [e.g. `PACKAGE_NAME_DEBUG` -- enables verbose logging]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Dropped Python 3.8 support -->
