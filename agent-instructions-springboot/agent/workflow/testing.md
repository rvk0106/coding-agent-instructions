# Testing
> Tags: test, verify, junit, mockito, mockmvc, checkstyle
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
# Maven - run specific test class
./mvnw test -Dtest=UserServiceTest

# Maven - run specific test method
./mvnw test -Dtest="UserServiceTest#testCreateUser"

# Gradle - run specific test class
./gradlew test --tests UserServiceTest

# Lint (if configured)
./mvnw checkstyle:check
# or
./gradlew checkstyleMain
```

## Full Checks (when required)
```bash
# Maven - full build with all tests
./mvnw clean verify

# Gradle - full build with all tests
./gradlew clean build

# Maven - integration tests only
./mvnw verify -Pfailsafe

# Gradle - integration tests only
./gradlew integrationTest
```

## Spring Boot Specific Tests

### Controller Tests (@WebMvcTest)
```bash
./mvnw test -Dtest=UserControllerTest
# Tests HTTP layer only, mocks services
```

### Service Unit Tests
```bash
./mvnw test -Dtest=UserServiceTest
# Pure unit tests with Mockito mocks
```

### Repository Tests (@DataJpaTest)
```bash
./mvnw test -Dtest=UserRepositoryTest
# Tests JPA layer with in-memory DB or Testcontainers
```

### Integration Tests (@SpringBootTest)
```bash
./mvnw test -Dtest=UserIntegrationTest
# Full Spring context, real (or containerized) DB
```

## API Changes (if endpoints added/modified)
```bash
# Verify app starts
./mvnw spring-boot:run
# or
./gradlew bootRun

# Check Swagger UI (if springdoc-openapi configured)
curl -s http://localhost:8080/v3/api-docs | jq .
# Browse: http://localhost:8080/swagger-ui.html

# Test endpoints manually
curl -X GET http://localhost:8080/api/v1/users -H "Authorization: Bearer <token>"
```

## DB Changes (if migrations added)
```bash
# Maven - run migrations
./mvnw flyway:migrate
# or run app (auto-migrate on startup)

# Verify migration applied
./mvnw flyway:info

# Test rollback (Flyway)
./mvnw flyway:undo
./mvnw flyway:migrate
```

## CI Commands
```bash
# Full verification (tests + build)
./mvnw clean verify
# or
./gradlew clean build

# Lint
./mvnw checkstyle:check

# Security scan (if configured)
./mvnw dependency-check:check
# or
./gradlew dependencyCheckAnalyze
```

## Reporting Format
```
Commands run:
- `./mvnw test -Dtest=UserServiceTest` --> PASS/FAIL
- `./mvnw checkstyle:check` --> PASS/FAIL (N violations)
If FAIL --> STOP and ask before continuing
```
