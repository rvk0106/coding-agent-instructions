# Implementation
> Tags: code, conventions, python, library, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain -> STOP and ask

## Python Library Conventions
- **Entry point**: `src/package_name/__init__.py` -- exports all public API via `__all__`
- **Modules**: Under `src/package_name/` namespace
- **Private modules**: Prefix with `_` (e.g. `_core.py`, `_utils.py`)
- **Docstrings**: All public functions/classes (Google or NumPy style)
- **Type hints**: PEP 484 on all public API, include `py.typed` marker
- **Constants**: `UPPER_SNAKE_CASE`
- **`# noqa`**: Only with justification comment (e.g. `# noqa: E501 -- URL too long`)
- **`# type: ignore`**: Only with justification comment
- **Logging**: Use `logging` module, never `print()` in library code

## File Locations
```
src/package_name/__init__.py         -> entry point, public API exports, __version__
src/package_name/_core.py            -> core logic (private module)
src/package_name/_config.py          -> configuration (private module)
src/package_name/exceptions.py       -> exception hierarchy
src/package_name/types.py            -> type aliases, protocols, dataclasses
src/package_name/client.py           -> primary client class (if used)
src/package_name/py.typed            -> PEP 561 marker
tests/test_core.py                   -> tests matching source modules
tests/test_client.py                 -> tests matching source modules
tests/conftest.py                    -> shared fixtures
pyproject.toml                       -> package configuration
```

## Docstring Convention
```python
def process(input_data: str, *, timeout: int = 30) -> Result:
    """Process the input data and return a structured result.

    Args:
        input_data: The raw data to process.
        timeout: Maximum seconds to wait. Defaults to 30.

    Returns:
        A Result object containing the processed output.

    Raises:
        PackageNameError: If processing fails.
        ValidationError: If input_data is empty.

    Examples:
        >>> result = process("hello")
        >>> result.success
        True
    """
```

## Import Conventions
```python
# Standard library
import logging
from pathlib import Path

# Third-party (if any)
import httpx

# Local (relative imports within package)
from package_name._core import _process_internal
from package_name.exceptions import PackageNameError
```

## Danger Zones
- Public API changes -> flag for review
- Adding runtime dependencies -> justify in `infrastructure/dependencies.md`
- Changing pyproject.toml -> ask first
- Removing/renaming public functions -> major version bump required
- `eval()` / `exec()` with user input -> never
- `pickle.loads()` on untrusted data -> never
