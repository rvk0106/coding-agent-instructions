# Dependencies
> Tags: gems, gemspec, runtime, development, external
> Scope: All dependencies the gem relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- **Minimal runtime dependencies** — fewer deps = fewer conflicts for consumers
- Prefer stdlib over gems where practical
- Pin to compatible ranges (`~>`) not exact versions
- Every runtime dependency must be justified

## Runtime Dependencies (gemspec)
<!-- List gems added as runtime dependencies in the gemspec -->
| Gem | Version Constraint | Purpose | Justification |
|-----|-------------------|---------|---------------|
| [e.g. `faraday`] | `~> 2.0` | HTTP client | [why not Net::HTTP] |
| [e.g. none] | - | - | Prefer zero runtime deps |

## Development Dependencies
<!-- List gems in the gemspec or Gemfile for development -->
| Gem | Purpose |
|-----|---------|
| `rspec` | Test framework |
| `rubocop` | Linter / formatter |
| `yard` | Documentation |
| `simplecov` | Code coverage |
| `bundler` | Dependency management |
| `rake` | Task runner |
| [Add project-specific dev gems] |

## External Services
<!-- Services the gem talks to (if any) -->
- [e.g. REST API at api.example.com]
- [e.g. none — pure Ruby library]

## Adding Dependencies
Before adding a new runtime dependency:
1. Check if Ruby stdlib can do the job
2. Check the gem's maintenance status and popularity
3. Check for version conflicts with common gems
4. Document the justification in this file
5. Use the loosest compatible version constraint that works

## Changelog
<!-- [PROJ-123] Added faraday ~> 2.0 for HTTP client -->
