# Dependencies
> Tags: maven, gradle, runtime, development, external
> Scope: All dependencies the library relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- **Minimal runtime dependencies** — fewer deps = fewer conflicts for consumers
- The Java standard library (`java.*`, `javax.*`) is rich — prefer it over third-party libs
- Pin to compatible ranges, not exact versions
- Every runtime dependency must be justified

## Runtime Dependencies (pom.xml / build.gradle)
<!-- List dependencies added as runtime/compile scope -->
| Dependency | Group ID | Version | Purpose | Justification |
|-----------|----------|---------|---------|---------------|
| [e.g. `slf4j-api`] | `org.slf4j` | `2.0.x` | Logging facade | [Standard logging abstraction, no implementation bundled] |
| [e.g. none] | - | - | - | Prefer zero runtime deps |

## Development Dependencies
<!-- List dependencies for test/provided scope -->
| Dependency | Group ID | Scope | Purpose |
|-----------|----------|-------|---------|
| `junit-jupiter` | `org.junit.jupiter` | test | Test framework (JUnit 5) |
| `mockito-core` | `org.mockito` | test | Mocking framework |
| `mockito-junit-jupiter` | `org.mockito` | test | Mockito JUnit 5 integration |
| `assertj-core` | `org.assertj` | test | Fluent assertions |
| `jacoco-maven-plugin` | `org.jacoco` | build | Code coverage |
| `maven-checkstyle-plugin` | `org.apache.maven.plugins` | build | Linting |
| `spotbugs-maven-plugin` | `com.github.spotbugs` | build | Bug detection |
| `maven-javadoc-plugin` | `org.apache.maven.plugins` | build | Javadoc generation |
| `maven-surefire-plugin` | `org.apache.maven.plugins` | build | Test execution |
| [Add project-specific dev deps] | | | |

## External Services
<!-- Services the library talks to (if any) -->
- [e.g. REST API at api.example.com]
- [e.g. none — pure Java library]

## Adding Dependencies
Before adding a new runtime dependency:
1. **Check if `java.*` can do the job** — Java stdlib covers HTTP (`java.net.http`), JSON (via third-party but consider), concurrency (`java.util.concurrent`), etc.
2. **Check the library's maintenance status** — last release date, open issues, bus factor
3. **Check for version conflicts** — will this conflict with common frameworks (Spring, Jakarta)?
4. **Check transitive dependencies** — prefer libs with minimal transitive deps
5. **Document the justification** in this file
6. **Use version ranges conservatively** — prefer `[1.0,2.0)` syntax in Maven or strict versions

## Dependency Version Updates
```bash
# Maven: check for available updates
mvn versions:display-dependency-updates
mvn versions:display-plugin-updates

# Gradle: use ben-manes versions plugin
./gradlew dependencyUpdates
```

## Changelog
<!-- [PROJ-123] Added slf4j-api 2.0.x for logging facade -->
