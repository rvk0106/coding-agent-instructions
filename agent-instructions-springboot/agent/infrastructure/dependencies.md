# Dependencies
> Tags: starters, dependencies, services, external
> Scope: All external dependencies the app relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- Prefer Spring Boot starters over individual libraries (auto-configuration, version management)
- Use the Spring Boot BOM for version alignment
- Add dependencies only when needed -- avoid "just in case" additions
- Document why non-obvious dependencies were added

## Key Dependencies
<!-- List dependencies the agent needs to know about when planning/implementing -->
| Dependency | Group | Purpose |
|-----------|-------|---------|
| `spring-boot-starter-web` | Core | REST API, embedded Tomcat, Jackson |
| `spring-boot-starter-data-jpa` | Data | JPA/Hibernate, Spring Data repositories |
| `spring-boot-starter-security` | Security | Authentication, authorization, Spring Security |
| `spring-boot-starter-validation` | Validation | Bean Validation (JSR 380), `@Valid`, `@NotNull` |
| `spring-boot-starter-test` | Testing | JUnit 5, Mockito, MockMvc, Spring Test |
| `spring-boot-starter-actuator` | Ops | Health checks, metrics, info endpoints |
| [e.g. `springdoc-openapi-starter-webmvc-ui`] | Docs | Swagger UI + OpenAPI 3 spec generation |
| [e.g. `org.flywaydb:flyway-core`] | Migration | Database migration management |
| [e.g. `org.projectlombok:lombok`] | Utility | `@Getter`, `@Setter`, `@RequiredArgsConstructor`, `@Builder` |
| [e.g. `io.jsonwebtoken:jjwt-api`] | Auth | JWT creation and validation |
| [Add project-specific dependencies] | | |

## Database Driver
- [e.g. `org.postgresql:postgresql` / `com.mysql:mysql-connector-j` / `com.h2database:h2`]

## External Services
<!-- Services the app talks to -->
- Payment: [e.g. Stripe / none]
- Email: [e.g. SendGrid / Spring Mail / none]
- Storage: [e.g. AWS S3 / Azure Blob / none]
- Monitoring: [e.g. Micrometer + Prometheus / Datadog / Sentry / none]
- Logging: [e.g. SLF4J + Logback (default) / ELK stack / none]
- [Add project-specific services]

## Internal APIs / Microservices
<!-- Other services this app depends on or is consumed by -->
- [e.g. Auth service at auth.internal:8081]
- [e.g. Consumed by frontend SPA at app.example.com]

## Process for Adding Dependencies
1. Check if a Spring Boot starter exists for the functionality
2. Verify compatibility with current Spring Boot version
3. Add to `pom.xml` (`<dependency>` section) or `build.gradle` (`dependencies` block)
4. Document in this file with purpose
5. Run `./mvnw clean verify` or `./gradlew clean build` to confirm no conflicts

## Changelog
<!-- [PROJ-123] Added springdoc-openapi for API documentation -->
