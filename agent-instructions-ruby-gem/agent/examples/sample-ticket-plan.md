# Sample Ticket Plan

**Location**: `docs/PROJ-101-plan.md`

## Ticket metadata
- Ticket ID: PROJ-101
- Title: Add retry logic with configurable backoff
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Add retry capability for transient failures
- Configurable max retries and backoff strategy
- Must not break existing API
- Non-goals: circuit breaker pattern, rate limiting

## Current state analysis
- Reviewed `lib/gem_name/client.rb`: basic HTTP calls, no retry logic
- Checked `lib/gem_name/configuration.rb`: has timeout option, no retry config
- Reviewed `lib/gem_name/errors.rb`: has ConnectionError, TimeoutError
- Analyzed `spec/gem_name/client_spec.rb`: tests for basic success/failure
- Checked `gem_name.gemspec`: no retry-related dependencies
- Reviewed `CHANGELOG.md`: last release was v1.2.0

## Context Loaded
- `workflow/context-router.md` → task type: New Public Method / Feature
- `architecture/public-api.md` → API surface, backward compatibility
- `architecture/error-handling.md` → exception classes
- `architecture/patterns.md` → coding conventions
- `architecture/data-flow.md` → call flow, external service patterns
- `features/_CONVENTIONS.md` → test patterns
- `infrastructure/security.md` → safe coding rules

## Architecture decisions
- Add retry config options to Configuration class
- Create Retry middleware/wrapper (not inline in Client)
- Use exponential backoff with jitter by default
- Only retry on transient errors (ConnectionError, TimeoutError)
- Expose as configuration, not per-request option (simpler API)

## Phase 1
**Goal**: Add retry configuration options.
**Context needed**: `architecture/patterns.md` (configuration pattern), `architecture/public-api.md` (backward compatibility)
**Tasks**:
- Add `max_retries` and `retry_backoff` config options with defaults
- Add YARD documentation for new options
- Add configuration specs
**Allowed files**:
- lib/gem_name/configuration.rb
- spec/gem_name/configuration_spec.rb
**Forbidden changes**:
- No client changes
- No new files
**Verification**:
- `bundle exec rspec spec/gem_name/configuration_spec.rb`
- `bundle exec rubocop lib/gem_name/configuration.rb`
**Acceptance criteria**:
- `config.max_retries` defaults to 3
- `config.retry_backoff` defaults to `:exponential`
- Existing config options unchanged

## Phase 2
**Goal**: Implement retry logic as a reusable module.
**Context needed**: `architecture/data-flow.md` (call flow), `architecture/error-handling.md` (which errors to retry), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create Retryable module with retry logic
- Handle exponential backoff with jitter
- Only retry on transient error classes
- Add unit specs
**Allowed files**:
- lib/gem_name/retryable.rb
- spec/gem_name/retryable_spec.rb
- lib/gem_name.rb (add require)
**Forbidden changes**:
- No client changes yet
- No configuration changes
**Verification**:
- `bundle exec rspec spec/gem_name/retryable_spec.rb`
- `bundle exec rubocop lib/gem_name/retryable.rb`
**Acceptance criteria**:
- Retries up to max_retries times
- Exponential backoff between retries
- Only retries on ConnectionError, TimeoutError
- Raises original error after max retries exhausted

## Phase 3
**Goal**: Integrate retry into Client and update docs.
**Context needed**: `architecture/public-api.md` (client interface), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Include Retryable in Client
- Wrap external calls with retry logic
- Update YARD docs on Client
- Add integration-style specs
- Update CHANGELOG.md
**Allowed files**:
- lib/gem_name/client.rb
- spec/gem_name/client_spec.rb
- CHANGELOG.md
**Forbidden changes**:
- No version bump (separate phase/ticket)
**Verification**:
- `bundle exec rspec`
- `bundle exec rubocop`
- `yard stats --list-undoc`
**Acceptance criteria**:
- Client retries transient failures
- Existing tests still pass
- YARD docs complete
- CHANGELOG updated

## Next step
execute plan 1 for PROJ-101
