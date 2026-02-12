# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this gem
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first → execute in small phases → verify → human review
- No scope creep, no unrelated refactors

## Ruby Gem Patterns

### Module Namespacing
- ALL code lives under the gem's top-level module
- No monkey-patching of core Ruby classes without explicit opt-in
```ruby
# CORRECT
module GemName
  class Client
    def initialize(config:)
      @config = config
    end
  end
end

# WRONG — pollutes global namespace
class Client
  def initialize(config:)
    @config = config
  end
end
```

### Configuration Pattern
- Use a `Configuration` class with a block-based DSL
- Provide sensible defaults
- Validate configuration on access, not on set
```ruby
module GemName
  class Configuration
    attr_accessor :api_key, :timeout, :retries

    def initialize
      @timeout = 30
      @retries = 3
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end
```

### Factory Methods
- Use class-level factory methods for complex object creation
- Keep `initialize` simple — no side effects

### Builder Pattern
- Use for objects with many optional parameters
- Return `self` from each setter for chaining

### Mixin Modules (Concerns)
- Use for shared behavior across multiple classes
- Location: `lib/gem_name/concerns/` or `lib/gem_name/mixins/`
```ruby
module GemName
  module Loggable
    def logger
      GemName.configuration.logger || Logger.new($stdout)
    end
  end
end
```

### Error Handling Pattern
- Custom exception hierarchy under `GemName::Error`
- See `architecture/error-handling.md` for full details

### Private vs Public
- Default to `private` — only expose what consumers need
- Use `private` keyword, not `private :method_name`
```ruby
class MyClass
  def public_method
    internal_step
  end

  private

  def internal_step
    # implementation
  end
end
```

## Naming Conventions
- Classes: `PascalCase`
- Methods/variables: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Predicate methods: `method_name?` (return boolean)
- Dangerous methods: `method_name!` (mutates or raises)
- File names: `snake_case.rb` matching class/module name

## Testing Standards
- Framework: RSpec
- Unit specs for all public methods
- Integration specs for key workflows
- Edge case coverage for error paths
- Factories or fixtures for test data
- No `let!` unless needed, prefer `let`

## Quality Checklist
- [ ] All public methods have YARD docs (`@param`, `@return`, `@example`)
- [ ] RSpec tests for all new code
- [ ] RuboCop passes
- [ ] No monkey-patching without opt-in
- [ ] Minimal runtime dependencies
- [ ] Backward compatible (or version bumped appropriately)
- [ ] CHANGELOG.md updated
- [ ] `lib/gem_name/version.rb` updated if releasing

## Changelog
<!-- [PROJ-123] Adopted configuration pattern for all settings -->
