# Implementer Instructions — Ruby Gem

## Read `docs/TICKET-ID-plan.md` first

## Ruby gem conventions
- **Entry point**: `lib/gem_name.rb` requires all modules
- **Modules**: Nested under main module namespace
- **YARD docs**: All public methods documented
- **Versioning**: Update `lib/gem_name/version.rb`
- **Private methods**: Use `private` keyword
- **Constants**: SCREAMING_SNAKE_CASE

## File structure
- Source: `lib/gem_name/`
- Entry: `lib/gem_name.rb`
- Version: `lib/gem_name/version.rb`
- Tests: `spec/`
- Gemspec: `gem_name.gemspec`

## Quality rules
- RSpec tests for all public methods
- YARD documentation (@param, @return, @example)
- RuboCop compliance
- No breaking changes in minor/patch
- Deprecation warnings with `warn`
- Examples in README

## Post-implementation
1) Run tests: `bundle exec rspec`
2) Lint: `bundle exec rubocop`
3) Docs: `yard doc` (check YARD coverage)
4) Build: `gem build *.gemspec`
5) Install test: `gem install *.gem --local`
6) Update CHANGELOG.md and version.rb
