# Testing Instructions — Spring Boot

## Purpose
Verification is mandatory for every phase.

## Source of verification commands
- Each phase in `docs/TICKET-ID-plan.md` specifies its verification commands.
- Run those exact commands plus any additional checks below.

## Fast checks
- Unit tests: `./mvnw test` or `./gradlew test`
- Specific test class: `./mvnw test -Dtest=ClassNameTest`
- Build: `./mvnw clean compile` or `./gradlew compileJava`

## Full checks (when required)
- Full build with tests: `./mvnw clean install` or `./gradlew build`
- Integration tests: `./mvnw verify` or `./gradlew integrationTest`
- Checkstyle: `./mvnw checkstyle:check` or `./gradlew checkstyleMain`

## Spring Boot API changes (required)
- Verify app starts: `./mvnw spring-boot:run` or `./gradlew bootRun`
- Check OpenAPI/Swagger: `http://localhost:8080/swagger-ui.html` or `/v3/api-docs`
- Test endpoints with curl or Postman

## Reporting format
- List commands executed
- Include pass/fail results
- If any command fails: stop and ask before continuing
