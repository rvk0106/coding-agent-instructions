# System Design
> Tags: architecture, components, modules, high-level
> Scope: How the package is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this package does -->
[Describe what this package does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual structure -->
```
[Consumer Code] -> package_name.public_func(args)
                    -> [Core Module] -> [Adapters / Backends] (if used)
                    -> [Middleware / Hooks] (if used)
                    -> [External Services] (if used)
```
- Core: [e.g. main processing logic / client / DSL]
- Adapters: [e.g. HTTP backends / storage backends / none]
- Plugins: [e.g. hook system / none]

## Module Structure
<!-- Map out the package hierarchy -->
```python
package_name/
    __init__.py          # public API exports, __version__
    _core.py             # main logic (private module)
    _config.py           # configuration (private module)
    exceptions.py        # exception hierarchy
    types.py             # type aliases, protocols, dataclasses
    client.py            # primary client class (if applicable)
    py.typed             # PEP 561 marker for type checkers
```

## Dependencies
- Runtime: [list runtime packages, prefer minimal]
- Development: [list dev-only packages]

## Python Version Support
<!-- List all versions the package supports and tests against -->
| Version | Status |
|---------|--------|
| 3.13 | Primary |
| 3.12 | Supported |
| 3.11 | Supported |
| 3.10 | Supported |
| 3.9 | Minimum |

## Key Data Flows
<!-- Describe 2-3 critical flows through the package -->
1. **Configuration**: `package_name.configure(option=value)` -> stores in `_config` -> used by core modules
2. **[Flow Name]**: [step] -> [step] -> [step]
3. **[Flow Name]**: [step] -> [step] -> [step]

## Changelog
<!-- [PROJ-123] Added adapter pattern for pluggable backends -->
