# Tooling
> Tags: linter, test, ci, formatter, quality, docs
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Linting
- RuboCop: `bundle exec rubocop`
- Config: `.rubocop.yml`
- Auto-fix: `bundle exec rubocop -A`

## Testing
- Framework: RSpec
- Run all: `bundle exec rspec`
- Run specific: `bundle exec rspec spec/path/to_spec.rb`
- Run tag: `bundle exec rspec --tag focus`
- Coverage: [e.g. SimpleCov — check `coverage/` after tests]

## Documentation
- Tool: YARD
- Generate: `yard doc`
- Stats: `yard stats --list-undoc`
- Serve locally: `yard server --reload`

## Build & Install
- Build gem: `gem build *.gemspec`
- Install locally: `gem install *.gem --local`
- Console: `bundle exec irb -r ./lib/gem_name`

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Matrix: [e.g. Ruby 3.0, 3.1, 3.2, 3.3 on ubuntu-latest]
- Pipeline steps: lint → test → build
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches → main]
- Commit convention: [e.g. conventional commits / free-form]

## Changelog
<!-- [PROJ-123] Added GitHub Actions CI matrix for Ruby 3.0-3.3 -->
