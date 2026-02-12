# Sample Ticket Plan

**Location**: `docs/PROJ-101-plan.md`

## Ticket metadata
- Ticket ID: PROJ-101
- Title: Add connection pooling with configurable limits and health monitoring
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Add connection pooling capability for external service connections
- Configurable pool size (min, max), timeout, and health check interval
- Must not break existing API
- Non-goals: circuit breaker pattern, rate limiting, load balancing

## Current state analysis
- Reviewed `src/main/java/com/example/lib/api/LibClient.java`: basic connection per request, no pooling
- Checked `src/main/java/com/example/lib/config/LibConfig.java`: has timeout option, no pool config
- Reviewed `src/main/java/com/example/lib/exception/`: has ConnectionException, TimeoutException
- Analyzed `src/test/java/com/example/lib/api/LibClientTest.java`: tests for basic success/failure
- Checked `pom.xml`: no pool-related dependencies
- Reviewed `CHANGELOG.md`: last release was v1.2.0

## Context Loaded
- `workflow/context-router.md` → task type: New Public Class / Method
- `architecture/public-api.md` → API surface, backward compatibility
- `architecture/error-handling.md` → exception classes
- `architecture/patterns.md` → coding conventions, builder pattern
- `architecture/data-flow.md` → call flow, thread safety, external service patterns
- `features/_CONVENTIONS.md` → test patterns
- `infrastructure/security.md` → safe coding rules

## Architecture decisions
- Add pool configuration to LibConfig via builder pattern
- Create ConnectionPool interface in api/ package (public)
- Create DefaultConnectionPool in impl/ package (internal)
- Use java.util.concurrent for thread safety (no external deps)
- Add health monitoring via scheduled executor
- Expose pool stats via a PoolStats value object

## Phase 1
**Goal**: Add connection pool configuration options.
**Context needed**: `architecture/patterns.md` (builder pattern), `architecture/public-api.md` (backward compatibility)
**Tasks**:
- Add pool config options to LibConfig.Builder (minSize, maxSize, acquireTimeout, healthCheckInterval)
- Provide sensible defaults (min=2, max=10, acquireTimeout=5s, healthCheck=30s)
- Add Javadoc with @since 1.3.0
- Add configuration tests
**Allowed files**:
- src/main/java/com/example/lib/config/LibConfig.java
- src/test/java/com/example/lib/config/LibConfigTest.java
**Forbidden changes**:
- No client changes
- No new classes
**Verification**:
- `mvn test -Dtest=LibConfigTest`
- `mvn checkstyle:check`
**Acceptance criteria**:
- `builder.maxPoolSize(20)` works
- Defaults: minSize=2, maxSize=10, acquireTimeout=5s, healthCheckInterval=30s
- Existing config options unchanged
- Javadoc complete

## Phase 2
**Goal**: Implement connection pool as a reusable component.
**Context needed**: `architecture/data-flow.md` (thread safety), `architecture/error-handling.md` (which errors to use), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create ConnectionPool interface in api/ package
- Create PoolStats value object in model/ package
- Create DefaultConnectionPool in impl/ package using java.util.concurrent
- Implement min/max size, acquire with timeout, health checking
- Add unit tests with Mockito
**Allowed files**:
- src/main/java/com/example/lib/api/ConnectionPool.java
- src/main/java/com/example/lib/model/PoolStats.java
- src/main/java/com/example/lib/impl/DefaultConnectionPool.java
- src/test/java/com/example/lib/impl/DefaultConnectionPoolTest.java
**Forbidden changes**:
- No client changes yet
- No configuration changes
**Verification**:
- `mvn test -Dtest=DefaultConnectionPoolTest`
- `mvn checkstyle:check`
**Acceptance criteria**:
- Pool creates connections up to maxSize
- Acquire blocks with timeout when pool exhausted
- Health check runs at configured interval
- Thread-safe (tested with concurrent access)
- Throws TimeoutException when acquire times out

## Phase 3
**Goal**: Integrate pool into LibClient and update docs.
**Context needed**: `architecture/public-api.md` (client interface), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Wire ConnectionPool into LibClient
- Use pool for external connections instead of per-request
- Add pool lifecycle (init on first use, close via AutoCloseable)
- Make LibClient implement AutoCloseable
- Update Javadoc on LibClient
- Add integration-style tests
- Update CHANGELOG.md
**Allowed files**:
- src/main/java/com/example/lib/api/LibClient.java
- src/test/java/com/example/lib/api/LibClientTest.java
- CHANGELOG.md
**Forbidden changes**:
- No version bump (separate phase/ticket)
**Verification**:
- `mvn clean verify`
- `mvn javadoc:javadoc`
**Acceptance criteria**:
- LibClient uses pool for connections
- Existing tests still pass
- LibClient implements AutoCloseable
- Javadoc complete
- CHANGELOG updated

## Next step
execute plan 1 for PROJ-101
