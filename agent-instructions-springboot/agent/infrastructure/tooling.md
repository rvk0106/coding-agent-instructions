# Tooling
> Tags: build, test, lint, ci, formatter, quality
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Build

### Maven
```bash
./mvnw clean install          # compile + test + package
./mvnw clean compile          # compile only (fast check)
./mvnw clean package -DskipTests  # package without tests
./mvnw spring-boot:run        # run locally
```

### Gradle
```bash
./gradlew build               # compile + test + package
./gradlew compileJava         # compile only (fast check)
./gradlew build -x test       # package without tests
./gradlew bootRun             # run locally
```

## Testing
- Framework: JUnit 5 (via `spring-boot-starter-test`)
- Mocking: Mockito (included in starter-test)
- Controller tests: MockMvc (`@WebMvcTest`) or `@SpringBootTest` with `TestRestTemplate`/`WebTestClient`
- Repository tests: `@DataJpaTest` (in-memory DB or Testcontainers)
- Integration tests: `@SpringBootTest` (full context)
- Testcontainers: [e.g. PostgreSQLContainer for realistic DB tests / not used]

### Test Commands
```bash
# Maven
./mvnw test                            # run all tests
./mvnw test -Dtest=UserServiceTest     # run specific test class
./mvnw test -Dtest="UserServiceTest#testCreate"  # run specific method
./mvnw verify                          # run all tests including integration

# Gradle
./gradlew test                         # run all tests
./gradlew test --tests UserServiceTest  # run specific test class
./gradlew test --tests "*.UserServiceTest.testCreate"  # specific method
./gradlew integrationTest              # integration tests (if configured separately)
```

## Linting & Static Analysis
- Checkstyle: [e.g. `./mvnw checkstyle:check` / `./gradlew checkstyleMain` / not configured]
- Config: [e.g. `config/checkstyle/checkstyle.xml`]
- SpotBugs: [e.g. `./mvnw spotbugs:check` / `./gradlew spotbugsMain` / not configured]
- SonarQube: [e.g. `./mvnw sonar:sonar` / `./gradlew sonarqube` / not configured]

## Code Formatting
- Formatter: [e.g. google-java-format / Spring Java Format / IDE default]
- Apply: [e.g. `./mvnw spring-javaformat:apply` / IDE auto-format]

## API Documentation
- Tool: [e.g. springdoc-openapi / springfox / none]
- Swagger UI: `http://localhost:8080/swagger-ui.html`
- OpenAPI spec: `http://localhost:8080/v3/api-docs`
- Verify: `curl -s http://localhost:8080/v3/api-docs | jq .`

## CI/CD
- Platform: [e.g. GitHub Actions / GitLab CI / Jenkins / CircleCI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Pipeline steps:
  1. Checkout
  2. Set up Java [version]
  3. Cache Maven/Gradle dependencies
  4. Build: `./mvnw clean verify` or `./gradlew clean build`
  5. Lint: Checkstyle / SpotBugs
  6. Test: `./mvnw test` with coverage report
  7. Package: `./mvnw package` or `./gradlew bootJar`
  8. Deploy (on main branch)
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches --> main]
- Commit convention: [e.g. conventional commits / free-form]
- Test coverage target: [e.g. 80% line coverage / none]

## Changelog
<!-- [PROJ-123] Added Checkstyle configuration -->
