# Environment
> Tags: java, runtime, versions, jdk, build
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Java: [e.g. >= 17]
- Build tool: [e.g. Maven 3.9+ / Gradle 8+]
- Required Java features: [e.g. records, sealed classes, pattern matching / none]

## Supported Java Versions
<!-- List all versions the library supports and tests against -->
| Version | Status |
|---------|--------|
| 21 | Primary (LTS) |
| 17 | Minimum (LTS) |
| [22+] | [Supported / Not tested] |

## JDK Vendors
- Recommended: Eclipse Temurin (Adoptium)
- Also tested: [e.g. Amazon Corretto, Oracle JDK, GraalVM]
- CI uses: [e.g. Eclipse Temurin via actions/setup-java]

## Build Tool
- **Maven**: `mvn clean install`
- **Gradle**: `./gradlew clean build`
- Wrapper: [e.g. Maven Wrapper (`mvnw`) / Gradle Wrapper (`gradlew`) — committed to repo]

## Local Setup
```bash
# Minimum commands to get running
git clone [repo]
cd lib-name

# Maven
./mvnw clean install

# Gradle
./gradlew clean build
```

## Environment Variables
<!-- List any env vars the library uses (for testing or optional features) -->
- [e.g. `LIB_NAME_API_KEY` — optional, for integration tests]
- [e.g. `LIB_NAME_DEBUG` — enables verbose logging]

## CI Matrix
```yaml
# Example GitHub Actions matrix
strategy:
  matrix:
    java: [17, 21]
    os: [ubuntu-latest]
```

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Dropped Java 11 support -->
