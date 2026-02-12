# Sample Ticket Plan

**Location**: `docs/PROJ-101-plan.md`

## Ticket metadata
- Ticket ID: PROJ-101
- Title: Add retry logic with configurable backoff to HTTP client
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Add retry capability for transient failures (connection errors, timeouts)
- Configurable max retries and backoff strategy
- Must not break existing public API
- Non-goals: circuit breaker pattern, rate limiting

## Current state analysis
- Reviewed `src/package_name/client.py`: basic HTTP calls via httpx, no retry logic
- Checked `src/package_name/_config.py`: has `timeout` option, no retry config
- Reviewed `src/package_name/exceptions.py`: has `ConnectionError`, `TimeoutError`
- Analyzed `tests/test_client.py`: tests for basic success/failure paths
- Checked `pyproject.toml`: httpx listed as runtime dep, no retry-related deps
- Reviewed `CHANGELOG.md`: last release was v1.2.0

## Context Loaded
- `workflow/context-router.md` -> task type: New Public Function / Class
- `architecture/public-api.md` -> API surface, backward compatibility
- `architecture/error-handling.md` -> exception classes
- `architecture/patterns.md` -> coding conventions
- `architecture/data-flow.md` -> call flow, external service patterns
- `features/_CONVENTIONS.md` -> test patterns
- `infrastructure/security.md` -> safe coding rules

## Architecture decisions
- Add retry config options to Config dataclass
- Create a `_retry.py` private module with retry logic (not inline in Client)
- Use exponential backoff with jitter by default
- Only retry on transient errors (ConnectionError, TimeoutError)
- Expose as configuration, not per-request option (simpler API)

## Phase 1
**Goal**: Add retry configuration options.
**Context needed**: `architecture/patterns.md` (dataclass pattern), `architecture/public-api.md` (backward compatibility)
**Tasks**:
- Add `max_retries` and `retry_backoff` fields to Config dataclass with defaults
- Add docstrings and type hints for new options
- Add configuration tests
**Allowed files**:
- src/package_name/_config.py
- tests/test_config.py
**Forbidden changes**:
- No client changes
- No new modules
**Verification**:
- `pytest tests/test_config.py`
- `mypy src/`
- `ruff check src/`
**Acceptance criteria**:
- `Config(max_retries=3)` defaults to 3
- `Config(retry_backoff="exponential")` defaults to "exponential"
- Existing config options unchanged

## Phase 2
**Goal**: Implement retry logic as a reusable private module.
**Context needed**: `architecture/data-flow.md` (call flow), `architecture/error-handling.md` (which errors to retry), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create `_retry.py` module with retry decorator/wrapper
- Handle exponential backoff with jitter
- Only retry on transient exception classes
- Add unit tests with mocked sleep
**Allowed files**:
- src/package_name/_retry.py (new)
- tests/test_retry.py (new)
**Forbidden changes**:
- No client changes yet
- No configuration changes
**Verification**:
- `pytest tests/test_retry.py`
- `mypy src/`
- `ruff check src/`
**Acceptance criteria**:
- Retries up to max_retries times
- Exponential backoff between retries
- Only retries on ConnectionError, TimeoutError
- Raises original error after max retries exhausted

## Phase 3
**Goal**: Integrate retry into Client and update docs.
**Context needed**: `architecture/public-api.md` (client interface), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Import and use retry wrapper in Client._request method
- Wrap external calls with retry logic
- Update docstrings on Client
- Add integration-style tests
- Update CHANGELOG.md
**Allowed files**:
- src/package_name/client.py
- tests/test_client.py
- CHANGELOG.md
**Forbidden changes**:
- No version bump (separate phase/ticket)
**Verification**:
- `pytest`
- `mypy src/`
- `ruff check src/`
**Acceptance criteria**:
- Client retries transient failures
- Existing tests still pass
- Docstrings complete
- CHANGELOG updated

## Next step
execute plan 1 for PROJ-101
