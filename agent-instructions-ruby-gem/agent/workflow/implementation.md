# Implementation
> Tags: code, conventions, ruby, gem, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain → STOP and ask

## Ruby Gem Conventions
- **Entry point**: `lib/gem_name.rb` — requires all modules
- **Modules**: Nested under main module namespace
- **YARD docs**: All public methods documented with `@param`, `@return`, `@example`
- **Versioning**: Update `lib/gem_name/version.rb` when releasing
- **Private methods**: Use `private` keyword
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Frozen strings**: `# frozen_string_literal: true` at top of every file

## File Locations
```
lib/gem_name.rb              → entry point, top-level requires
lib/gem_name/version.rb      → VERSION constant
lib/gem_name/configuration.rb → config DSL (if used)
lib/gem_name/errors.rb       → exception hierarchy
lib/gem_name/client.rb       → primary client class (if used)
lib/gem_name/[module].rb     → feature modules
spec/gem_name/[module]_spec.rb → specs matching source structure
spec/spec_helper.rb          → test configuration
gem_name.gemspec             → gem specification
```

## YARD Documentation
```ruby
# @param input [String] the input to process
# @param options [Hash] optional configuration
# @option options [Integer] :timeout (30) request timeout in seconds
# @return [Result] the processed result
# @raise [GemName::ArgumentError] if input is nil or empty
# @example Basic usage
#   result = GemName.process("hello")
#   result.success? #=> true
def process(input, **options)
  # ...
end
```

## Danger Zones
- Public API changes → flag for review
- Adding runtime dependencies → justify in `infrastructure/dependencies.md`
- Changing gemspec → ask first
- Removing/renaming public methods → major version bump required
- `eval` / metaprogramming with user input → never
