# Implementation
> Tags: code, conventions, spring-boot, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain --> STOP and ask

## Spring Boot Conventions
- **Controllers**: thin, handle only HTTP concerns (validation, request/response mapping)
- **Services**: business logic, `@Transactional` for multi-step DB writes
- **Repositories**: data access only (extend `JpaRepository`), no business logic
- **DTOs**: separate request/response DTOs for API serialization
- **Entities**: JPA models, internal to service/repository layer -- never expose directly
- **Dependency injection**: constructor injection (`private final` fields + constructor or `@RequiredArgsConstructor`)
- **Package structure**: follow existing project conventions (`controller/`, `service/`, `repository/`, `model/`, `dto/`, `config/`, `exception/`)

## File Locations
```
src/main/java/com/example/app/
  controller/          --> REST controllers (@RestController)
  service/             --> Business logic (@Service)
  repository/          --> Data access (JpaRepository)
  model/ or entity/    --> JPA entities (@Entity)
  dto/                 --> Request/response DTOs
  config/              --> Configuration classes (@Configuration)
  exception/           --> Custom exceptions + GlobalExceptionHandler
  security/            --> Security filters, JWT utilities
  util/                --> Utility classes

src/main/resources/
  application.yml      --> Main configuration
  application-dev.yml  --> Dev profile config
  db/migration/        --> Flyway migrations (or db/changelog/ for Liquibase)

src/test/java/com/example/app/
  controller/          --> Controller tests (@WebMvcTest, @SpringBootTest)
  service/             --> Service unit tests (Mockito)
  repository/          --> Repository tests (@DataJpaTest)
  integration/         --> Full integration tests (@SpringBootTest)
```

## REST API Conventions
- Use proper HTTP methods: GET, POST, PUT, PATCH, DELETE
- Return appropriate status codes (200, 201, 204, 400, 401, 403, 404, 409, 422, 500)
- Use `@Valid` on request DTO parameters
- Handle exceptions via `@ControllerAdvice` (see `architecture/error-handling.md`)
- Use `ResponseEntity<T>` for explicit status code control
```java
// CORRECT: explicit response with DTO
@PostMapping
public ResponseEntity<UserResponse> create(@Valid @RequestBody CreateUserRequest request) {
    UserResponse response = userService.create(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(response);
}

// WRONG: returning entity directly
@PostMapping
public User create(@RequestBody User user) {
    return userRepository.save(user);
}
```

## API Response Shape
See `architecture/api-design.md` for the project's standard response shapes. All endpoints must use them consistently.

## Danger Zones
- Auth/security changes --> ask first, load `infrastructure/security.md`
- Direct SQL / native queries --> justify, ensure parameterized
- Data scoping bypass (accessing other users'/tenants' data) --> ask first
- Skipping validation (`@Valid`) --> never
- Exposing entities in API responses --> never, use DTOs
- Business logic in controllers --> never, delegate to services
- Missing `@Transactional` on multi-step DB writes --> always add

## Post-Implementation Steps
1. Run all verification commands from the phase
2. Build the project: `./mvnw clean verify` or `./gradlew clean build`
3. Update OpenAPI/Swagger annotations if API changes
4. Run lint: `./mvnw checkstyle:check` (if configured)
5. Confirm all tests pass
