# Tooling
> Tags: linter, test, ci, formatter, quality
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Linting
- RuboCop: `bundle exec rubocop`
- Config: `.rubocop.yml`
- Auto-fix: `bundle exec rubocop -A`
- ERB Lint: [e.g. `bundle exec erblint --lint-all` / not installed]
- Config: [e.g. `.erb-lint.yml`]

## Testing
- Framework: RSpec
- Run all: `bundle exec rspec`
- Run specific: `bundle exec rspec spec/path/to_spec.rb`
- Run tag: `bundle exec rspec --tag focus`
- System tests: `bundle exec rspec spec/system/`
- System test driver: [e.g. Capybara + Selenium / Cuprite / Rack::Test]
- Coverage: [e.g. SimpleCov / none]

## Asset Building
- Development: [e.g. `bin/dev` (Procfile.dev) / `rails s`]
- Precompile: `rails assets:precompile`
- CSS build: [e.g. `rails tailwindcss:build` / `yarn build:css`]
- JS build: [e.g. `importmap pin` / `yarn build`]

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Pipeline steps: lint -> test -> system test -> build -> deploy
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches -> main]
- Commit convention: [e.g. conventional commits / free-form]

## Changelog
<!-- [PROJ-123] Switched from Minitest to RSpec -->
