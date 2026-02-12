# Deployment
> Tags: deploy, hosting, environments, infra, docker
> Scope: How the app is deployed and where
> Last updated: [TICKET-ID or date]

## Environments
| Env | URL | Branch | Deploy Method |
|-----|-----|--------|---------------|
| Dev | localhost:8080 | any | `./mvnw spring-boot:run` |
| Staging | [url] | [branch] | [auto/manual] |
| Production | [url] | main | [auto/manual] |

## Deploy Process
<!-- Describe your deployment pipeline -->
- [e.g. Push to main --> GitHub Actions --> Maven build --> Docker build --> Push to ECR --> Deploy to ECS]
- [e.g. `./mvnw package && docker build -t app . && docker push`]
- [e.g. `git push heroku main`]

### Build Artifact
```bash
# Maven: produces executable JAR
./mvnw clean package -DskipTests
java -jar target/app-0.0.1-SNAPSHOT.jar

# Gradle: produces executable JAR
./gradlew bootJar
java -jar build/libs/app-0.0.1-SNAPSHOT.jar
```

### Docker (if applicable)
```dockerfile
# Multi-stage Dockerfile pattern
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## Database Migrations
- Auto-run on deploy: [yes (Flyway/Liquibase runs on startup) / no (manual step)]
- Rollback: [process -- e.g. deploy previous version, reverse migration is automatic]
- Danger: always review migration SQL before production deployment

## Secrets Management
- Method: [e.g. environment variables / Spring Cloud Config / HashiCorp Vault / AWS Secrets Manager]
- Application properties: never commit secrets in `application.yml` / `application.properties`
- Pattern: use `${ENV_VAR}` placeholders in config, set values via environment

## Infrastructure Notes
- [e.g. Load balancer in front, health check at /actuator/health]
- [e.g. Auto-scaling based on CPU/memory metrics]
- [e.g. Separate worker instances for async processing]
- [e.g. Database connection pool: HikariCP (default), max pool size = 10]

## Changelog
<!-- [PROJ-123] Migrated from Heroku to AWS ECS -->
