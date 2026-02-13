# Testing
> Tags: test, verify, rspec, rubocop, capybara, system
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
bundle exec rspec spec/path/to_spec.rb   # specs for touched files
bundle exec rubocop                       # lint (if installed)
```

## Full Checks (when required)
```bash
bundle exec rspec                         # full suite
bundle exec rubocop --parallel            # full lint
bundle exec erblint --lint-all            # ERB lint (if installed)
```

## View / Page Changes
```bash
# System specs (Capybara) for user-facing changes
bundle exec rspec spec/system/

# Request specs for controller behavior
bundle exec rspec spec/requests/

# Helper specs (if helpers changed)
bundle exec rspec spec/helpers/
```

## DB Changes (if migrations added)
```bash
rails db:migrate
rails db:migrate:status
rails db:rollback STEP=1                  # verify rollback works
rails db:migrate                          # re-apply
```

## Asset Changes (if CSS/JS modified)
```bash
rails assets:precompile                   # verify assets compile
# Or framework-specific:
# rails tailwindcss:build                 # Tailwind
# yarn build                              # esbuild/webpack
```

## CI Commands
```bash
bundle exec rspec --format progress     # tests
bundle exec rubocop --parallel           # lint
bundle exec brakeman -q                  # security scan (if installed)
bundle exec erblint --lint-all           # ERB lint (if installed)
```

## Reporting Format
```
Commands run:
- `bundle exec rspec spec/...` -> PASS/FAIL
- `bundle exec rubocop` -> PASS/FAIL (N offenses)
- `bundle exec rspec spec/system/...` -> PASS/FAIL
If FAIL -> STOP and ask before continuing
```
