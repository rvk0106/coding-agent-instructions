# Environment
> Tags: java, spring-boot, runtime, versions, config
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Java: [e.g. 17 / 21]
- Spring Boot: [e.g. 3.2.x]
- Build tool: [e.g. Maven 3.9.x / Gradle 8.x]

## Database & Services
- Primary DB: [e.g. PostgreSQL / MySQL / H2 (dev only)]
- Cache: [e.g. Redis / Caffeine / none]
- Message broker: [e.g. RabbitMQ / Kafka / none]
- Search: [e.g. Elasticsearch / none]
- Job scheduler: [e.g. Spring Scheduler / Quartz / none]

## OS / Container
- Dev: [e.g. macOS / Docker Compose / devcontainer]
- CI: [e.g. GitHub Actions ubuntu-latest]
- Prod: [e.g. AWS ECS / Kubernetes / Azure App Service / Heroku]

## Application Configuration
- Config format: [e.g. `application.yml` / `application.properties`]
- Profiles: `dev`, `staging`, `prod` (via `spring.profiles.active`)
- Profile-specific config: [e.g. `application-dev.yml`, `application-prod.yml`]
- Externalized config: [e.g. environment variables / Spring Cloud Config / Vault]

## Local Setup
```bash
# Minimum commands to get running

# Maven
./mvnw clean install
./mvnw spring-boot:run

# Gradle
./gradlew build
./gradlew bootRun

# With Docker Compose (if applicable)
docker compose up -d  # start DB + services
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
```

## Environment Variables
- `SPRING_DATASOURCE_URL` - JDBC connection URL (e.g. `jdbc:postgresql://localhost:5432/myapp`)
- `SPRING_DATASOURCE_USERNAME` - DB username
- `SPRING_DATASOURCE_PASSWORD` - DB password
- `JWT_SECRET` - JWT signing key (if using JWT auth)
- `SPRING_PROFILES_ACTIVE` - active profile (dev/staging/prod)
- [Add project-specific vars here]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Upgraded Java 17 --> 21 -->
