# Public API Design
> Tags: api, public, functions, classes, interface, semver, type-hints
> Scope: Public API surface, function/class signatures, return types, versioning
> Last updated: [TICKET-ID or date]

## API Surface Rules
- Every public function/class MUST have a docstring (Google or NumPy style)
- Every public function/class MUST have type hints (PEP 484)
- Every public function/class MUST have pytest coverage
- Breaking changes require a MAJOR version bump (semver)
- New public functions/classes require a MINOR version bump
- Bug fixes use PATCH version bump

## Entry Point
- Main import: `import package_name` or `from package_name import public_func`
- Public API defined in `__init__.py` via `__all__`
- Optional submodule imports: [e.g. `from package_name.extras import ...` / none]

## `__init__.py` Exports
<!-- Document what is exported from the top-level package -->
```python
# src/package_name/__init__.py
from package_name._core import public_func, PublicClass
from package_name.exceptions import PackageNameError

__all__ = [
    "public_func",
    "PublicClass",
    "PackageNameError",
    # [Add all public names]
]

__version__ = "X.Y.Z"
```

## Configuration API
<!-- Document the configuration interface -->
```python
import package_name

# Option A: Module-level configure function
package_name.configure(
    option_1="value",
    option_2=True,
)

# Option B: Dataclass / dict config
from package_name import Config
config = Config(option_1="value", option_2=True)
client = package_name.Client(config=config)
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| [option_1] | `str` | [default] | [description] |
| [option_2] | `bool` | [default] | [description] |

## Core Public Functions / Classes
<!-- Document the primary public API -->
| Name | Signature | Returns | Description |
|------|-----------|---------|-------------|
| `package_name.public_func` | `(arg1: str, *, timeout: int = 30) -> Result` | `Result` | [description] |
| `package_name.PublicClass` | `(config: Config)` | instance | [description] |
| `PublicClass.method` | `(self, data: dict) -> str` | `str` | [description] |

## Type Hints (PEP 484)
- All public functions/methods must have complete type annotations
- Use `typing` module types where needed (`Optional`, `Union`, `Sequence`, etc.)
- Use `TypeAlias` or `type` (3.12+) for complex types
- Include `py.typed` marker file (PEP 561) for downstream type checking
```python
# CORRECT
def process(input_data: str, *, timeout: int = 30) -> Result:
    """Process input data and return a Result."""
    ...

# WRONG - missing type hints
def process(input_data, timeout=30):
    ...
```

## Docstring Requirements
Use Google style or NumPy style consistently across the package.

```python
# Google style
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

## Deprecation Policy
- Deprecation warnings for at least ONE minor version before removal
- Use `warnings.warn` with `DeprecationWarning` category
- Document deprecations in CHANGELOG.md
```python
import warnings

def old_function() -> None:
    """Deprecated: Use new_function instead."""
    warnings.warn(
        "old_function is deprecated, use new_function instead. "
        "It will be removed in v3.0.0.",
        DeprecationWarning,
        stacklevel=2,
    )
    return new_function()
```

## Backward Compatibility Rules
- Public functions: never remove in minor/patch
- Function signatures: never change required params in minor/patch
- Return types: never change in minor/patch
- Configuration options: never remove in minor/patch (deprecate first)
- Exception classes: never remove in minor/patch
- `__all__` exports: never remove names in minor/patch

## Changelog
<!-- [PROJ-123] Added new public function for batch processing -->
