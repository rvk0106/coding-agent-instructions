# Publishing & Release
> Tags: publish, release, pypi, versioning, build
> Scope: How the package is built, versioned, and published
> Last updated: [TICKET-ID or date]

## Version Location
- Location: `src/package_name/__init__.py` (as `__version__ = "X.Y.Z"`)
- Alternative: `src/package_name/__version__.py` or dynamic via `setuptools-scm`
- Format: `"X.Y.Z"` (semantic versioning)

## Semantic Versioning Rules
| Change Type | Version Bump | Examples |
|------------|:------------:|---------|
| Breaking API change | MAJOR (X) | Remove public function, change return type, remove config option |
| New feature (backward compatible) | MINOR (Y) | Add public function, add config option, add exception class |
| Bug fix (backward compatible) | PATCH (Z) | Fix behavior, improve error message, performance fix |

## pyproject.toml Key Fields
```toml
[project]
name = "package-name"
version = "X.Y.Z"                      # or dynamic
description = "Short package description"
readme = "README.md"
license = {text = "MIT"}
requires-python = ">=3.9"
authors = [
    {name = "Author Name", email = "author@example.com"},
]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
    "Programming Language :: Python :: 3.13",
    "Typing :: Typed",
]
dependencies = [
    # runtime deps here
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "mypy>=1.0",
    "ruff>=0.1.0",
    "coverage[toml]>=7.0",
    "build",
    "twine",
]

[project.urls]
Homepage = "https://github.com/org/package-name"
Documentation = "https://package-name.readthedocs.io"
Repository = "https://github.com/org/package-name"
Changelog = "https://github.com/org/package-name/blob/main/CHANGELOG.md"
```

## Release Process
```bash
# 1. Update version
# Edit src/package_name/__init__.py (or __version__.py)

# 2. Update CHANGELOG.md
# Add entry for new version

# 3. Run full verification
pytest --cov=package_name
mypy src/
ruff check src/ tests/

# 4. Build the package
python -m build

# 5. Test the built package (in a clean venv)
python -m venv /tmp/test-install
/tmp/test-install/bin/pip install dist/*.whl
/tmp/test-install/bin/python -c "import package_name; print(package_name.__version__)"

# 6. Upload to PyPI (DANGER ZONE -- requires human approval)
twine upload dist/*

# 7. Tag the release
git tag -a vX.Y.Z -m "Release vX.Y.Z"
git push origin vX.Y.Z
```

## CHANGELOG.md Format
```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature description

### Changed
- Changed behavior description

### Fixed
- Bug fix description

### Deprecated
- Deprecated feature (will be removed in vX+1.0.0)

### Removed
- Removed feature (was deprecated in vX-1.Y.Z)
```

## Danger Zones (hard stop, ask first)
- Publishing to PyPI
- Major version bumps
- Changing `requires-python`
- Modifying pyproject.toml metadata (name, license, etc.)
- Removing classifiers

## Changelog
<!-- [PROJ-123] Migrated from setup.py to pyproject.toml -->
