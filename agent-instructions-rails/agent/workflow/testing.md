# Testing
> Tags: test, verify, rspec, rubocop, swagger
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
```bash
bundle exec rspec spec/path/to_spec.rb   # specs for touched files
bundle exec rubocop                       # lint
```

## Full Checks (when required)
```bash
bundle exec rspec                         # full suite
bundle exec rubocop --parallel            # full lint
```

## API Changes (if endpoints added/modified)
```bash
bundle exec rake swagger:generate_modular
curl http://localhost:3000/api-docs/v1/swagger.json
```

## DB Changes (if migrations added)
```bash
rails db:migrate
rails db:migrate:status
rails db:rollback STEP=1                  # verify rollback works
rails db:migrate                          # re-apply
```

## CI Commands
```bash
bundle exec rspec --format progress     # tests
bundle exec rubocop --parallel           # lint
bundle exec brakeman -q                  # security scan (if installed)
```

## Reporting Format
```
Commands run:
- `bundle exec rspec spec/...` → PASS/FAIL
- `bundle exec rubocop` → PASS/FAIL (N offenses)
If FAIL → STOP and ask before continuing
```
