# Testing
> Tags: test, verify, rspec, rubocop, yard, gem-build
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
```

## Documentation Checks
```bash
yard stats --list-undoc                   # check YARD coverage
yard doc                                  # generate docs (verify no warnings)
```

## Build Checks (when gemspec or version changed)
```bash
gem build *.gemspec                       # verify gem builds
gem install *.gem --local                 # verify gem installs
bundle exec irb -r ./lib/gem_name        # verify require works
```

## Dependency Checks (when dependencies changed)
```bash
bundle audit check --update               # security audit (if bundler-audit installed)
bundle outdated                           # check for outdated deps
```

## CI Commands
```bash
bundle exec rspec --format progress       # tests
bundle exec rubocop --parallel             # lint
yard stats --list-undoc                    # doc coverage
gem build *.gemspec                        # build verification
```

## Reporting Format
```
Commands run:
- `bundle exec rspec spec/...` → PASS/FAIL
- `bundle exec rubocop` → PASS/FAIL (N offenses)
- `yard stats` → X% documented
If FAIL → STOP and ask before continuing
```
