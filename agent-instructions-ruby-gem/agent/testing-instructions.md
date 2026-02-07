# Testing Instructions — Ruby Gem

## Source: `docs/TICKET-ID-plan.md`

## Fast checks
- Specific tests: `bundle exec rspec spec/path/to/spec.rb`
- Lint: `bundle exec rubocop`
- Specific lint: `bundle exec rubocop lib/path/to/file.rb`

## Full checks
- All tests: `bundle exec rspec`
- Coverage: Check `coverage/` directory after tests
- Build: `gem build *.gemspec`
- Install: `gem install *.gem --local`

## Gem-specific
- Test across Ruby versions (using CI)
- Verify require works: `irb -r gem_name`
- YARD documentation: `yard stats`
- Check gemspec validity: `gem build` succeeds
