# Planner Instructions — Ruby Gem

## Analyze patterns
- Review `*.gemspec` for gem configuration and dependencies
- Check `lib/` for source structure
- Examine `lib/gem_name.rb` for main entry point
- Review `spec/` for RSpec test structure
- Check `.rubocop.yml` for style configuration
- Review `.github/workflows/` for CI/CD
- Check `CHANGELOG.md` for versioning patterns

## Danger zones
- Public API changes
- Dependency version constraints
- Ruby version support
- Gemspec metadata changes

## Verification commands
- Tests: `bundle exec rspec`
- Lint: `bundle exec rubocop`
- Build: `gem build *.gemspec`
- Install locally: `gem install *.gem`
- Console: `bundle exec irb -r ./lib/gem_name`

## Save to: `docs/TICKET-ID-plan.md`
