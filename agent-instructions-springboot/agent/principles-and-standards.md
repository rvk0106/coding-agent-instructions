# Principles & Standards — Spring Boot

## Core principles
- **Agents are collaborators, not autonomous engineers**
- **Plan first**: Planning and execution are separate phases
- **Small, verifiable steps**: Each phase is atomic and independently testable
- **Hard stop after each phase**: No auto-continue without human approval
- **Verification required**: Tests/build/checkstyle are mandatory
- **Humans remain accountable**: Humans approve plans, phase transitions, review code, and merge

## Spring Boot-specific standards
- Follow Spring Boot conventions and best practices
- Use Maven or Gradle build standards
- Follow Java naming conventions
- Use Lombok where appropriate to reduce boilerplate
- Apply SOLID principles

## Design patterns
- **Service layer** for business logic
- **Repository pattern** for data access (Spring Data JPA)
- **DTO pattern** for API requests/responses
- **Controller → Service → Repository** layered architecture
- **Dependency Injection** via constructor injection (preferred) or @Autowired
- **Exception handling** with @ControllerAdvice
- **Validation** with javax.validation annotations

## Package structure
```
src/main/java/com/example/project/
├── controller/          # REST controllers
├── service/            # Business logic
├── repository/         # Data access
├── model/              # JPA entities
├── dto/                # Data transfer objects
├── config/             # Configuration classes
├── exception/          # Custom exceptions
└── util/               # Utility classes
```

## Quality checklist
- All REST endpoints properly annotated (@GetMapping, @PostMapping, etc.)
- Request validation with @Valid and DTO validation annotations
- Unit tests with JUnit 5 and Mockito
- Integration tests with @SpringBootTest
- Proper HTTP status codes
- Exception handling with proper error responses
- OpenAPI/Swagger documentation updated
- Checkstyle compliance
