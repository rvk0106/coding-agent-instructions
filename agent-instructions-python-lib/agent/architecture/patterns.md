# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this package
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first -> execute in small phases -> verify -> human review
- No scope creep, no unrelated refactors

## Python Library Patterns

### Public API via `__init__.py`
- ALL public names exported through `__init__.py` and listed in `__all__`
- Internal modules prefixed with `_` (e.g. `_core.py`, `_utils.py`)
- Consumers import from the package, never from private modules
```python
# CORRECT - consumer imports from package
from package_name import process, Client

# WRONG - consumer imports from private module
from package_name._core import process
```

### Private Modules
- Prefix with `_` to signal internal use
- Not part of public API, can change without version bump
- Use `__all__` in `__init__.py` to control what's public
```python
# src/package_name/_core.py  (private module)
def process(data: str) -> Result:
    """Public function, exported via __init__.py."""
    ...

def _validate_input(data: str) -> None:
    """Private helper, not exported."""
    ...
```

### Factory Functions
- Use for complex object creation with validation
- Prefer over class constructors when initialization is non-trivial
```python
def create_client(
    api_key: str,
    *,
    timeout: int = 30,
    retries: int = 3,
) -> Client:
    """Create and configure a Client instance.

    Args:
        api_key: Authentication key.
        timeout: Request timeout in seconds.
        retries: Number of retry attempts.

    Returns:
        Configured Client instance.

    Raises:
        ConfigurationError: If api_key is empty.
    """
    if not api_key:
        raise ConfigurationError("api_key must not be empty")
    config = Config(api_key=api_key, timeout=timeout, retries=retries)
    return Client(config=config)
```

### Context Managers
- Use for resource management (connections, file handles, temp state)
- Implement `__enter__` / `__exit__` or use `contextlib.contextmanager`
```python
from contextlib import contextmanager

@contextmanager
def managed_connection(url: str):
    """Open and automatically close a connection."""
    conn = Connection(url)
    try:
        yield conn
    finally:
        conn.close()
```

### Protocols and ABCs
- Use `typing.Protocol` for structural subtyping (duck typing)
- Use `abc.ABC` for formal abstract base classes
```python
from typing import Protocol

class Serializer(Protocol):
    """Protocol for objects that can serialize data."""
    def serialize(self, data: dict) -> bytes: ...
    def deserialize(self, raw: bytes) -> dict: ...
```

### Dataclasses
- Use for data structures, configuration objects, result types
- Prefer `@dataclass(frozen=True)` for immutable data
```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Config:
    """Package configuration."""
    api_key: str
    timeout: int = 30
    retries: int = 3

@dataclass(frozen=True)
class Result:
    """Processing result."""
    success: bool
    data: dict | None = None
    error: str | None = None
```

### Error Handling Pattern
- Custom exception hierarchy under `PackageNameError`
- See `architecture/error-handling.md` for full details

### Private vs Public
- Default to private -- only expose what consumers need
- Use `_` prefix for private functions and modules
- Use `__all__` in `__init__.py` to explicitly declare the public API
```python
# Public function (in __all__)
def process(data: str) -> Result:
    """Process data."""
    _validate(data)
    return _do_work(data)

# Private function (not in __all__)
def _validate(data: str) -> None:
    if not data:
        raise ValidationError("data must not be empty")
```

## Naming Conventions
- Classes: `PascalCase`
- Functions / methods / variables: `snake_case`
- Constants: `UPPER_SNAKE_CASE`
- Private: `_prefixed` (single underscore)
- Modules: `snake_case.py` (private: `_snake_case.py`)
- Type aliases: `PascalCase` (e.g. `JsonDict = dict[str, Any]`)
- File names match module names: `my_module.py` contains `MyModule` class

## Style Standards
- PEP 8 compliance
- PEP 484 type hints on all public API
- Line length: 88 (black default) or 79 (PEP 8 strict)
- Import order: stdlib -> third-party -> local (enforced by isort)
- Docstrings: Google or NumPy style, consistent across package
- No `# type: ignore` without justification comment
- No `# noqa` without justification comment

## Testing Standards
- Framework: pytest
- Unit tests for all public functions/classes
- Edge case coverage for error paths
- Fixtures in `conftest.py`
- Parametrize for input variations
- `mock.patch` for external dependencies
- No test pollution -- each test independent

## Quality Checklist
- [ ] All public functions/classes have docstrings (Google or NumPy style)
- [ ] All public functions/classes have type hints (PEP 484)
- [ ] pytest tests for all new code
- [ ] mypy passes with no errors
- [ ] ruff / flake8 passes
- [ ] black / isort formatting applied
- [ ] No private module imports in public API
- [ ] Minimal runtime dependencies
- [ ] Backward compatible (or version bumped appropriately)
- [ ] CHANGELOG.md updated
- [ ] `__version__` updated if releasing

## Changelog
<!-- [PROJ-123] Adopted dataclass pattern for configuration -->
