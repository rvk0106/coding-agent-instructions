# Tooling
> Tags: linter, test, ci, formatter, quality
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
- Coverage: [e.g. SimpleCov / none]

## API Docs
- Tool: [e.g. rswag / swagger-blocks / none]
- Generate: `bundle exec rake swagger:generate_modular`
- Verify: `curl http://localhost:3000/api-docs/v1/swagger.json`

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Pipeline steps: lint → test → build → deploy
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches → main]
- Commit convention: [e.g. conventional commits / free-form]

## Changelog
<!-- [PROJ-123] Switched from Minitest to RSpec -->
