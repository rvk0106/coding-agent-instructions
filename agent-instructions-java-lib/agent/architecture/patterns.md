# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this library
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first → execute in small phases → verify → human review
- No scope creep, no unrelated refactors

## Java Library Patterns

### Interfaces for Contracts
- Define public API through interfaces, not concrete classes
- Consumers program to interfaces, implementations are internal
```java
// CORRECT — public interface in api/ package
public interface Processor {
    Result process(Input input);
}

// Implementation in impl/ package (internal)
class DefaultProcessor implements Processor {
    @Override
    public Result process(Input input) { ... }
}
```

### Immutable Value Objects
- Value objects should be immutable by default
- Use `final` fields, no setters
- Provide factory methods or builders for construction
```java
// CORRECT — immutable value object
public final class Config {
    private final String apiKey;
    private final Duration timeout;

    private Config(Builder builder) {
        this.apiKey = Objects.requireNonNull(builder.apiKey, "apiKey must not be null");
        this.timeout = builder.timeout != null ? builder.timeout : Duration.ofSeconds(30);
    }

    public String getApiKey() { return apiKey; }
    public Duration getTimeout() { return timeout; }

    public static Builder builder() { return new Builder(); }

    public static final class Builder {
        private String apiKey;
        private Duration timeout;

        public Builder apiKey(String apiKey) { this.apiKey = apiKey; return this; }
        public Builder timeout(Duration timeout) { this.timeout = timeout; return this; }
        public Config build() { return new Config(this); }
    }
}
```

### Builder Pattern
- Use for objects with many optional parameters
- Return `this` from each setter for chaining
- Validate in `build()`, not in setters
- Make the target class constructor private

### Factory Methods
- Use static factory methods for complex object creation
- Prefer `create()`, `of()`, `from()` naming
- Keep constructors simple — no side effects
```java
// CORRECT — static factory method
public static LibClient create(Config config) {
    Objects.requireNonNull(config, "config must not be null");
    return new LibClient(config);
}
```

### Strategy Pattern
- Use for pluggable algorithms or behaviors
- Define strategy interface in `api/` or `spi/` package
- Provide default implementations
```java
public interface RetryStrategy {
    boolean shouldRetry(int attempt, Exception lastException);
    Duration getDelay(int attempt);
}
```

### Template Method
- Use for defining a skeleton algorithm with customizable steps
- Base class defines the template, subclasses override specific steps

### Dependency Injection (optional)
- Design for DI but do NOT require a DI container
- Accept dependencies via constructor parameters
- Provide sensible defaults for optional dependencies

## Package Structure
```
com.example.lib/
├── api/              — Public interfaces and entry points
├── core/             — Core business logic (internal)
├── impl/             — Interface implementations (internal)
├── config/           — Configuration classes and builders
├── exception/        — Exception hierarchy
├── util/             — Internal utility classes
├── spi/              — Service Provider Interfaces (if pluggable)
└── model/            — Value objects, DTOs
```

## Naming Conventions
- Classes/Interfaces: `PascalCase` (e.g. `ConnectionPool`, `Retryable`)
- Methods/Fields: `camelCase` (e.g. `getConnection()`, `maxRetries`)
- Constants: `UPPER_SNAKE_CASE` (e.g. `DEFAULT_TIMEOUT`, `MAX_RETRIES`)
- Packages: lowercase, no underscores (e.g. `com.example.lib.core`)
- Test classes: `ClassNameTest` (e.g. `ConnectionPoolTest`)
- Boolean methods: `is`/`has`/`can` prefix (e.g. `isConnected()`, `hasNext()`)
- Factory methods: `create()`, `of()`, `from()`, `newInstance()`

## Access Modifiers
- Default to package-private — only expose what consumers need
- Public: only for API surface (api/, config/, exception/, model/ packages)
- Protected: only when extension is explicitly supported
- Private: for all internal implementation details
```java
// CORRECT — minimal visibility
public class LibClient {
    private final Config config;       // private field
    private final Processor processor; // private field

    public Result execute(Input input) { // public API
        validate(input);
        return processor.process(input);
    }

    void validate(Input input) { // package-private — testable but not public
        Objects.requireNonNull(input, "input must not be null");
    }
}
```

## Testing Standards
- Framework: JUnit 5
- Mocking: Mockito
- Assertions: AssertJ (preferred) or JUnit assertions
- Unit tests for all public methods
- Integration tests for key workflows
- Edge case coverage for error paths
- Use `@Nested` classes for grouping related tests
- Use `@ParameterizedTest` for data-driven tests

## Quality Checklist
- [ ] All public classes/methods have Javadoc (`@param`, `@return`, `@throws`, `@since`)
- [ ] JUnit 5 tests for all new code
- [ ] Checkstyle passes
- [ ] SpotBugs passes (no new warnings)
- [ ] Null safety annotations on public API
- [ ] Minimal runtime dependencies
- [ ] Backward compatible (or version bumped appropriately)
- [ ] CHANGELOG.md updated
- [ ] Version in pom.xml/build.gradle updated if releasing

## Changelog
<!-- [PROJ-123] Adopted builder pattern for configuration -->
