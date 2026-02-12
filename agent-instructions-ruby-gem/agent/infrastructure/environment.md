# Environment
> Tags: ruby, runtime, versions, os
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Ruby: [e.g. >= 3.0]
- Bundler: [e.g. >= 2.0]
- Required Ruby features: [e.g. pattern matching / ractors / none]

## Supported Ruby Versions
<!-- List all versions the gem supports and tests against -->
| Version | Status |
|---------|--------|
| 3.3 | Primary |
| 3.2 | Supported |
| 3.1 | Supported |
| 3.0 | Minimum |
| 2.7 | [Supported / Deprecated / Dropped] |

## Platform Support
- MRI (CRuby): [yes/no]
- JRuby: [yes/no]
- TruffleRuby: [yes/no]

## OS / Container
- Dev: [e.g. macOS / Linux / Docker]
- CI: [e.g. GitHub Actions ubuntu-latest]

## Local Setup
```bash
# Minimum commands to get running
git clone [repo]
cd gem_name
bundle install
bundle exec rspec
```

## Environment Variables
<!-- List any env vars the gem uses (for testing or optional features) -->
- [e.g. `GEM_NAME_API_KEY` — optional, for integration tests]
- [e.g. `GEM_NAME_DEBUG` — enables verbose logging]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Dropped Ruby 2.7 support -->
