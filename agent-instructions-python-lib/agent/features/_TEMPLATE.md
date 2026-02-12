# Feature: [Feature Name]
> Tags: [relevant, keywords]
> Scope: [what this feature covers]
> Status: [active / deprecated / planned]

## Summary
<!-- 1-2 sentences: what this feature does -->

## How It Works
<!-- Step-by-step flow, keep it concise -->
1. [Step]
2. [Step]
3. [Step]

## Key Components
| Component | Location | Purpose |
|-----------|----------|---------|
| Module | `src/package_name/...` | [what it does] |
| Class | `src/package_name/...` | [what it does] |
| Config | `src/package_name/_config.py` | [what it does] |

## Public API
| Name | Signature | Returns | Description |
|------|-----------|---------|-------------|
| `package_name.func` | `(arg: str) -> Result` | `Result` | [description] |

## Configuration Options (if applicable)
| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `option_name` | `str` | `None` | [description] |

## Usage Examples
```python
import package_name

# Basic usage
result = package_name.func("input")
print(result.data)

# With configuration
package_name.configure(option_name="value")
result = package_name.func("input")
```

## Business Rules
- [Rule 1]
- [Rule 2]

## Edge Cases / Gotchas
- [Thing to watch out for]
- [Known limitation]

## Tests
- Unit tests: `tests/test_module.py`
- Integration tests: `tests/integration/test_feature.py`
