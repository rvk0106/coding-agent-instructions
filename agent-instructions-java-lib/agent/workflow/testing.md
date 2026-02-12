# Testing
> Tags: test, verify, junit, checkstyle, spotbugs, javadoc
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

### Maven
```bash
mvn test -Dtest=ClassName              # tests for touched class
mvn checkstyle:check                   # lint check
```

### Gradle
```bash
./gradlew test --tests ClassName       # tests for touched class
./gradlew checkstyleMain               # lint check
```

## Full Checks (when required)

### Maven
```bash
mvn clean verify                       # full suite: compile + test + integration + checks
mvn checkstyle:check                   # full lint
mvn spotbugs:check                     # static analysis
```

### Gradle
```bash
./gradlew clean build                  # full suite
./gradlew checkstyleMain               # full lint
./gradlew spotbugsMain                 # static analysis
```

## Documentation Checks
```bash
# Maven
mvn javadoc:javadoc                    # generate Javadoc (verify no warnings)
mvn javadoc:javadoc -Xdoclint:all      # strict Javadoc validation

# Gradle
./gradlew javadoc                      # generate Javadoc
```

## Build Checks (when pom.xml/build.gradle or version changed)
```bash
# Maven
mvn clean package                      # verify JAR builds
mvn clean install                      # verify installs to local repo

# Gradle
./gradlew clean jar                    # verify JAR builds
./gradlew publishToMavenLocal          # verify installs to local repo
```

## Dependency Checks (when dependencies changed)
```bash
# Maven
mvn versions:display-dependency-updates  # check for updates
mvn dependency:tree                      # inspect dependency tree
mvn org.owasp:dependency-check-maven:check  # security audit (if plugin configured)

# Gradle
./gradlew dependencyUpdates             # check for updates
./gradlew dependencies                  # inspect dependency tree
```

## Coverage
```bash
# Maven (JaCoCo)
mvn clean verify                       # generates coverage report
# Check: target/site/jacoco/index.html

# Gradle (JaCoCo)
./gradlew clean test jacocoTestReport  # generates coverage report
# Check: build/reports/jacoco/test/html/index.html
```

## Library-Specific Checks
- **Cross-version testing**: Run tests on all supported Java versions (17, 21) via CI matrix
- **Public API verification**: Ensure all public methods have Javadoc and tests
- **Backward compatibility**: Verify existing tests still pass after changes

## CI Commands
```bash
# Maven CI pipeline
mvn clean verify                       # tests + integration tests
mvn checkstyle:check                   # lint
mvn spotbugs:check                     # static analysis
mvn javadoc:javadoc                    # doc generation
mvn jacoco:report                      # coverage report
```

## Reporting Format
```
Commands run:
- `mvn test -Dtest=...` → PASS/FAIL
- `mvn checkstyle:check` → PASS/FAIL (N violations)
- `mvn javadoc:javadoc` → PASS/FAIL (N warnings)
If FAIL → STOP and ask before continuing
```
