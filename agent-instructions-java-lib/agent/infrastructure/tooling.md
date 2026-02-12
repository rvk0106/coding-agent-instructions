# Tooling
> Tags: build, test, lint, ci, formatter, quality, docs
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Build

### Maven
```bash
mvn clean compile          # compile only
mvn clean test             # compile + run tests
mvn clean verify           # compile + test + integration tests + checks
mvn clean install          # full build + install to local repo
mvn clean package          # build JAR
```

### Gradle
```bash
./gradlew clean build      # full build
./gradlew clean test       # run tests
./gradlew clean check      # run all checks (tests + static analysis)
./gradlew jar              # build JAR
```

## Testing
- Framework: JUnit 5 (Jupiter)
- Mocking: Mockito
- Assertions: AssertJ (preferred) or JUnit assertions
- Run all: `mvn test` / `./gradlew test`
- Run specific class: `mvn test -Dtest=ClassName` / `./gradlew test --tests ClassName`
- Run specific method: `mvn test -Dtest=ClassName#methodName`
- Run by tag: `mvn test -Dgroups=integration`
- Coverage: JaCoCo — check `target/site/jacoco/` after build

## Linting / Static Analysis

### Checkstyle
```bash
mvn checkstyle:check                   # Maven
./gradlew checkstyleMain               # Gradle
```
- Config: [e.g. `config/checkstyle/checkstyle.xml` or Google/Sun style]

### SpotBugs
```bash
mvn spotbugs:check                     # Maven
./gradlew spotbugsMain                 # Gradle
```

## Documentation
- Tool: Javadoc
- Generate: `mvn javadoc:javadoc` / `./gradlew javadoc`
- Output: `target/site/apidocs/` (Maven) or `build/docs/javadoc/` (Gradle)
- Check for warnings: build with `-Xdoclint:all`

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Matrix: [e.g. Java 17, 21 on ubuntu-latest]
- Pipeline steps: compile → test → checkstyle → spotbugs → javadoc → coverage
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches → main]
- Commit convention: [e.g. conventional commits / free-form]

## Changelog
<!-- [PROJ-123] Added GitHub Actions CI matrix for Java 17 and 21 -->
