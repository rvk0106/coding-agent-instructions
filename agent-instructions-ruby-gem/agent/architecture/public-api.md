# Public API Design
> Tags: api, public, methods, interface, semver
> Scope: Public API surface, method signatures, return types, versioning
> Last updated: [TICKET-ID or date]

## API Surface Rules
- Every public method MUST have YARD documentation
- Every public method MUST have RSpec coverage
- Breaking changes require a MAJOR version bump (semver)
- New public methods require a MINOR version bump
- Bug fixes use PATCH version bump

## Entry Point
- Main require: `require 'gem_name'`
- Optional requires: [e.g. `require 'gem_name/middleware'` / none]

## Configuration API
<!-- Document the configuration DSL -->
```ruby
GemName.configure do |config|
  config.option_1 = "value"
  config.option_2 = true
  # [Add project-specific options]
end
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| [option_1] | String | [default] | [description] |
| [option_2] | Boolean | [default] | [description] |

## Core Public Methods
<!-- Document the primary public API -->
| Method | Params | Returns | Description |
|--------|--------|---------|-------------|
| `GemName.method_1` | `(arg1, arg2:)` | `Result` | [description] |
| `GemName::Client#method_2` | `(arg1)` | `String` | [description] |

## Return Types
<!-- Document custom return types/structs -->
```ruby
# If using custom result objects:
# result.success? → Boolean
# result.data     → Hash/Object
# result.error    → String/nil
```

## Deprecation Policy
- Deprecation warnings for at least ONE minor version before removal
- Use `warn "[GemName] DEPRECATION: method_name is deprecated, use new_method instead"`
- Document deprecations in CHANGELOG.md

## Backward Compatibility Rules
- Public methods: never remove in minor/patch
- Method signatures: never change required params in minor/patch
- Return types: never change in minor/patch
- Configuration options: never remove in minor/patch (deprecate first)

## Changelog
<!-- [PROJ-123] Added new public method for batch processing -->
