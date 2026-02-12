# Implementation
> Tags: code, conventions, java, library, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain → STOP and ask

## Java Library Conventions
- **Public API**: interfaces and classes in `api/` package only
- **Implementation**: classes in `impl/` or `core/` packages (not exported)
- **Javadoc**: All public classes/methods documented with `@param`, `@return`, `@throws`, `@since`
- **Null safety**: `@Nullable`/`@NonNull` annotations on public API
- **Immutable by default**: Use `final` fields, no setters on value objects
- **Builder pattern**: Use for configuration and objects with many optional params
- **Versioning**: Update version in `pom.xml`/`build.gradle` when releasing
- **Access modifiers**: Default to package-private, expose only what consumers need
- **Constants**: `static final` with `UPPER_SNAKE_CASE`
- **@since tags**: Add `@since X.Y.Z` to all new public classes/methods

## File Locations
```
src/main/java/com/example/lib/
├── api/                            → public interfaces and entry points
│   ├── LibName.java               → main entry point / factory
│   └── [Feature]Interface.java    → public interfaces
├── config/                         → configuration classes
│   └── LibConfig.java             → builder-based configuration
├── core/                           → core business logic (internal)
│   └── [Feature]Core.java         → core implementation
├── impl/                           → interface implementations (internal)
│   └── Default[Feature].java      → default implementations
├── exception/                      → exception hierarchy
│   ├── LibNameException.java      → base exception
│   └── [Specific]Exception.java   → specific exceptions
├── model/                          → value objects, DTOs
│   └── [ModelName].java           → immutable value objects
├── spi/                            → SPI interfaces (if pluggable)
│   └── [Provider]Interface.java   → service provider interfaces
└── util/                           → internal utilities
    └── [Util]Helper.java          → utility classes

src/test/java/com/example/lib/
├── api/                            → tests for public API
│   └── LibNameTest.java
├── core/                           → tests for core logic
│   └── [Feature]CoreTest.java
├── impl/                           → tests for implementations
│   └── Default[Feature]Test.java
└── integration/                    → integration tests
    └── [Feature]IntegrationTest.java

src/main/resources/
└── META-INF/services/              → SPI service files (if used)
    └── com.example.lib.spi.[Interface]
```

## Javadoc Standards
```java
/**
 * Brief description of what the class/method does.
 *
 * <p>Longer description if needed, with usage notes and examples.</p>
 *
 * @param input the input to process, must not be null
 * @param options optional configuration overrides
 * @return the processed result, never null
 * @throws ValidationException if input fails validation
 * @throws ConfigurationException if the client is not properly configured
 * @since 1.2.0
 * @see RelatedClass#relatedMethod
 */
public Result process(@NonNull String input, Options options) {
    Objects.requireNonNull(input, "input must not be null");
    // ...
}
```

## Danger Zones
- Public API changes → flag for review
- Adding runtime dependencies → justify in `infrastructure/dependencies.md`
- Changing pom.xml/build.gradle → ask first
- Removing/renaming public classes/methods → major version bump required
- `Runtime.exec()` / reflection on user input → never
- Deserializing untrusted data → never
