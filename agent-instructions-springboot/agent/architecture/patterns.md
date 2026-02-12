# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this project
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first --> execute in small phases --> verify --> human review
- No scope creep, no unrelated refactors

## Spring Boot Architecture Patterns

### Controllers
- Thin: handle only HTTP concerns (validation, request/response mapping)
- Delegate all business logic to `@Service` classes
- Use `@Valid` on request DTOs
- Return `ResponseEntity<T>` with explicit status codes
- Annotate with `@RestController` and `@RequestMapping`
```java
// CORRECT: thin controller
@PostMapping
public ResponseEntity<UserResponse> create(@Valid @RequestBody CreateUserRequest request) {
    UserResponse response = userService.create(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(response);
}

// WRONG: business logic in controller
@PostMapping
public ResponseEntity<User> create(@RequestBody User user) {
    if (userRepository.existsByEmail(user.getEmail())) { // business logic leak
        throw new ConflictException("Email taken");
    }
    return ResponseEntity.ok(userRepository.save(user)); // exposes entity
}
```

### Services
- Location: `src/main/java/.../service/`
- Contain all business logic
- Use `@Service` annotation
- Annotate with `@Transactional` where multi-step DB operations occur
- Naming: `UserService`, `EnrollmentService` (noun-based)
- Constructor injection for all dependencies

### Repositories
- Location: `src/main/java/.../repository/`
- Extend `JpaRepository<Entity, Long>` (or `CrudRepository`)
- Data access only -- no business logic
- Use Spring Data query methods or `@Query` for custom queries
```java
// CORRECT: Spring Data query method
Optional<User> findByEmail(String email);

// CORRECT: custom JPQL
@Query("SELECT u FROM User u WHERE u.role = :role AND u.active = true")
List<User> findActiveByRole(@Param("role") Role role);
```

### DTOs (Data Transfer Objects)
- Location: `src/main/java/.../dto/`
- Separate request and response DTOs: `CreateUserRequest`, `UserResponse`
- Never expose JPA entities directly in API responses
- Use validation annotations on request DTOs: `@NotNull`, `@NotBlank`, `@Size`, `@Email`, `@Pattern`
- Use records (Java 16+) for immutable DTOs where appropriate

### Dependency Injection
- **Constructor injection** (preferred): `private final` fields + constructor
- Avoid `@Autowired` on fields (makes testing harder, hides dependencies)
- Use `@RequiredArgsConstructor` (Lombok) to reduce boilerplate
```java
// CORRECT: constructor injection
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
}

// WRONG: field injection
@Service
public class UserService {
    @Autowired
    private UserRepository userRepository; // hidden dependency
}
```

## Package Structure
```
src/main/java/com/example/app/
├── controller/          # REST controllers (@RestController)
├── service/             # Business logic (@Service)
├── repository/          # Data access (JpaRepository)
├── model/               # JPA entities (@Entity)
├── dto/                 # Request/response DTOs
├── config/              # Configuration classes (@Configuration)
├── exception/           # Custom exceptions + @ControllerAdvice handler
├── security/            # Security filters, JWT utils, auth config
└── util/                # Utility classes (static helpers)
```

## Naming Conventions
- **Classes**: PascalCase (`UserController`, `EnrollmentService`, `CreateUserRequest`)
- **Methods/fields**: camelCase (`findByEmail`, `currentEnrollment`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_PAGE_SIZE`, `DEFAULT_ROLE`)
- **Packages**: lowercase (`com.example.app.controller`)
- **Database tables**: snake_case (`user_profiles`, `order_items`)
- **JSON fields**: camelCase (`firstName`, `createdAt`)

## SOLID Principles
- **Single Responsibility**: one reason to change per class
- **Open/Closed**: extend behavior via interfaces, not modification
- **Liskov Substitution**: subtypes must be substitutable
- **Interface Segregation**: small focused interfaces
- **Dependency Inversion**: depend on abstractions, inject via constructor

## Quality Checklist
- [ ] Controllers are thin -- no business logic
- [ ] Request DTOs use `@Valid` with validation annotations
- [ ] Response DTOs used -- entities never exposed directly
- [ ] Constructor injection -- no field `@Autowired`
- [ ] `@Transactional` on service methods with multi-step DB writes
- [ ] Unit tests for service logic (JUnit 5 + Mockito)
- [ ] Integration tests for controller endpoints (@SpringBootTest / @WebMvcTest)
- [ ] Proper HTTP status codes returned
- [ ] Exception handling via `@ControllerAdvice` with consistent error shape
- [ ] OpenAPI/Swagger documentation updated if API changed
- [ ] Checkstyle / SpotBugs pass
- [ ] No N+1 queries (use `@EntityGraph` or `JOIN FETCH` where needed)

## Changelog
<!-- [PROJ-123] Adopted service object pattern for all business logic -->
