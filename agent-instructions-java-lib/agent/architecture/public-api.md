# Public API Design
> Tags: api, public, methods, interface, semver, javadoc
> Scope: Public API surface, method signatures, return types, versioning
> Last updated: [TICKET-ID or date]

## API Surface Rules
- Every public class/interface MUST have Javadoc
- Every public method MUST have Javadoc with @param, @return, @throws
- Every public method MUST have JUnit 5 test coverage
- Breaking changes require a MAJOR version bump (semver)
- New public methods/classes require a MINOR version bump
- Bug fixes use PATCH version bump

## Entry Point
- Main class: [e.g. `com.example.lib.api.LibName`]
- Builder: [e.g. `com.example.lib.api.LibName.builder()`]
- Factory methods: [e.g. `LibName.create(config)`]

## Exported Packages
<!-- List packages that are part of the public API -->
| Package | Contents | Public? |
|---------|----------|---------|
| `com.example.lib.api` | Public interfaces, entry points | Yes |
| `com.example.lib.config` | Configuration classes, builders | Yes |
| `com.example.lib.exception` | Exception hierarchy | Yes |
| `com.example.lib.model` | Value objects, DTOs | Yes |
| `com.example.lib.spi` | SPI interfaces (if pluggable) | Yes |
| `com.example.lib.core` | Core logic | No (internal) |
| `com.example.lib.impl` | Implementations | No (internal) |
| `com.example.lib.util` | Utilities | No (internal) |

## Configuration API
<!-- Document the builder/configuration pattern -->
```java
LibConfig config = LibConfig.builder()
    .option1("value")
    .option2(true)
    .timeout(Duration.ofSeconds(30))
    .build();

LibName client = LibName.create(config);
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| [option1] | `String` | [default] | [description] |
| [option2] | `boolean` | [default] | [description] |

## Core Public Methods
<!-- Document the primary public API -->
| Method | Params | Returns | Throws | Description |
|--------|--------|---------|--------|-------------|
| `LibName.create(config)` | `LibConfig` | `LibName` | `ConfigurationException` | [description] |
| `client.execute(input)` | `Input` | `Result` | `LibNameException` | [description] |

## Return Types
<!-- Document custom return types -->
```java
// If using custom result objects:
public interface Result {
    boolean isSuccess();
    T getData();
    String getError();
}
```

## Null Safety
- Use `@Nullable` and `@NonNull` annotations on all public API parameters and return types
- Prefer `Optional<T>` for return types that may be absent
- Never return `null` from public methods without `@Nullable` annotation
- Validate non-null parameters with `Objects.requireNonNull()` at API boundary

## Javadoc Requirements
```java
/**
 * Brief description of what the method does.
 *
 * <p>Longer description if needed, with usage notes.</p>
 *
 * @param input the input to process, must not be null
 * @param options optional configuration overrides
 * @return the processed result
 * @throws ValidationException if input fails validation
 * @throws ConfigurationException if the client is not properly configured
 * @since 1.2.0
 * @see RelatedClass
 */
public Result process(@NonNull String input, Options options) {
    // ...
}
```

## Deprecation Policy
- Mark with `@Deprecated` annotation AND `@deprecated` Javadoc tag
- Include `@since` tag indicating when deprecated
- Include `forRemoval = true` and `since` in `@Deprecated` annotation (Java 9+)
- Maintain deprecated methods for at least ONE minor version before removal
- Document replacement in Javadoc `@deprecated` tag
```java
/**
 * @deprecated since 2.1.0, use {@link #newMethod(String)} instead.
 *             Will be removed in 3.0.0.
 */
@Deprecated(since = "2.1.0", forRemoval = true)
public Result oldMethod(String input) { ... }
```

## Backward Compatibility Rules
- Public methods: never remove in minor/patch
- Method signatures: never change parameter types in minor/patch
- Return types: never change in minor/patch
- Exception types: never remove from throws clause in minor/patch
- Configuration options: never remove in minor/patch (deprecate first)

## Changelog
<!-- [PROJ-123] Added new public method for batch processing -->
