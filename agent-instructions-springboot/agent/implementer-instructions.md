# Implementer Instructions — Spring Boot

> When implementing a phase, always read `docs/TICKET-ID-plan.md` first.

## General rules
- Read the plan from `docs/TICKET-ID-plan.md` before starting.
- Follow the approved plan and the execution contract.
- Touch only files listed for the phase (ask if new files are needed).
- No unrelated refactors.
- Reuse existing patterns and helpers from the codebase.
- If uncertain, stop and ask.

## Spring Boot conventions
- **Controllers**: Thin, only handle HTTP concerns (validation, mapping)
- **Services**: Business logic, transactions (@Transactional)
- **Repositories**: Data access only (Spring Data JPA)
- **DTOs**: For request/response serialization
- **Entities**: JPA models, internal to service/repository layer
- Use constructor injection for dependencies (preferred over @Autowired)
- Follow package-by-feature or package-by-layer structure consistently

## Package location conventions
- Controllers: `src/main/java/.../controller/`
- Services: `src/main/java/.../service/`
- Repositories: `src/main/java/.../repository/`
- Entities: `src/main/java/.../model/` or `.../entity/`
- DTOs: `src/main/java/.../dto/`
- Config: `src/main/java/.../config/`
- Exceptions: `src/main/java/.../exception/`
- Tests: `src/test/java/.../`

## REST API conventions
- Use proper HTTP methods: GET, POST, PUT, PATCH, DELETE
- Return appropriate status codes (200, 201, 204, 400, 404, 500)
- Use @Valid for request validation
- Handle exceptions with @ControllerAdvice
- Response format:
  - Success: `{ "data": {...}, "message": "..." }`
  - Error: `{ "error": "...", "message": "...", "timestamp": "..." }`

## Quality rules
- Add @Valid to DTO parameters
- Use proper validation annotations (@NotNull, @Size, @Email, etc.)
- Add unit tests for services (Mockito for dependencies)
- Add integration tests for controllers (@SpringBootTest, @WebMvcTest)
- Use @Transactional where appropriate
- Handle exceptions properly with custom error responses

## Post-implementation steps
1) Run all verification commands from the phase.
2) Build the project: `./mvnw clean install` or `./gradlew build`
3) Update OpenAPI/Swagger annotations if API changes
4) Run checkstyle: `./mvnw checkstyle:check`
5) If frontend integration needed, document endpoints in `docs/frontend-integration.md`:
   - Section format: `## TICKET-ID: [Description]`
   - Include endpoint details (path, method, request/response)
   - Include authorization requirements
