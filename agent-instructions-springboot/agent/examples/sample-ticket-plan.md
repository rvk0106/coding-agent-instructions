# Sample Ticket Plan — Spring Boot

**Location**: `docs/API-201-plan.md`

## Ticket metadata
- Ticket ID: API-201
- Title: Add user profile endpoint with CRUD operations
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Users can view and update their own profile (name, bio, avatar URL).
- Admins can view any user's profile.
- Profile data stored in a separate `user_profiles` table linked to `users`.
- Expose REST endpoints: GET /api/v1/users/{id}/profile, PUT /api/v1/users/{id}/profile.
- Non-goals: File upload for avatar (accept URL only), admin bulk operations.

## Current state analysis
- Reviewed `pom.xml`: Spring Boot 3.2.x, Spring Data JPA, Spring Security, springdoc-openapi present
- Checked `application.yml`: PostgreSQL configured, Flyway enabled
- Reviewed `src/main/java/.../controller/UserController.java`: basic user CRUD exists
- Analyzed `src/main/java/.../service/UserService.java`: create/update/find logic present
- Checked `src/main/java/.../model/User.java`: entity with email, name, role fields
- No `UserProfile` entity, service, or controller exists
- Reviewed `src/test/java/`: UserControllerTest and UserServiceTest present with MockMvc and Mockito patterns
- Swagger configured at `/swagger-ui.html`

## Context Loaded
- `workflow/context-router.md` --> task type: New API Endpoint + New Model
- `architecture/api-design.md` --> endpoint naming, response shape
- `architecture/error-handling.md` --> validation error shape, exception hierarchy
- `architecture/data-flow.md` --> request lifecycle, filter chain
- `architecture/database.md` --> schema, JPA conventions, Flyway migration rules
- `architecture/patterns.md` --> controller/service/repository conventions
- `architecture/glossary.md` --> domain terms
- `features/_CONVENTIONS.md` --> MockMvc patterns, DTO conventions
- `infrastructure/security.md` --> query scoping rules, @PreAuthorize patterns

## Architecture decisions
- Add `UserProfile` entity with `@OneToOne` relationship to `User` (separate table for extensibility).
- Create Flyway migration for `user_profiles` table.
- Create `UserProfileService` for profile business logic.
- Create `UserProfileController` with GET and PUT endpoints under `/api/v1/users/{id}/profile`.
- Use separate DTOs: `UserProfileResponse` and `UpdateProfileRequest`.
- Authorization: users can only update their own profile; admins can view any profile.
- Follow existing project patterns (constructor injection, @Transactional, @Valid).

## Phase 1
**Goal**: Add UserProfile entity, repository, and Flyway migration.
**Context needed**: `architecture/database.md` (JPA conventions), `architecture/patterns.md` (entity conventions), `features/_CONVENTIONS.md` (repository test patterns)
**Tasks**:
- Create `UserProfile` entity with fields: `id`, `userId`, `bio`, `avatarUrl`, `createdAt`, `updatedAt`
- Add `@OneToOne` relationship to `User` entity
- Create `UserProfileRepository` extending `JpaRepository`
- Add Flyway migration `V3__create_user_profiles_table.sql`
- Add `@DataJpaTest` repository test
**Allowed files**:
- `src/main/java/.../model/UserProfile.java`
- `src/main/java/.../model/User.java` (add relationship only)
- `src/main/java/.../repository/UserProfileRepository.java`
- `src/main/resources/db/migration/V3__create_user_profiles_table.sql`
- `src/test/java/.../repository/UserProfileRepositoryTest.java`
**Forbidden changes**:
- No controller or service changes
- No security configuration changes
**Verification**:
- `./mvnw test -Dtest=UserProfileRepositoryTest`
- `./mvnw clean compile`
**Acceptance criteria**:
- Entity maps correctly to database table
- @OneToOne relationship configured with proper cascade and fetch settings
- Migration runs cleanly and is reversible

## Phase 2
**Goal**: Add UserProfileService with business logic and authorization.
**Context needed**: `architecture/patterns.md` (service conventions), `architecture/error-handling.md` (exception patterns), `infrastructure/security.md` (authorization), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create `UserProfileService` with `getProfile(Long userId)` and `updateProfile(Long userId, UpdateProfileRequest request)` methods
- Add authorization logic: user can only update own profile, admin can view any
- Add `@Transactional` on update method
- Create `UpdateProfileRequest` DTO with validation annotations
- Create `UserProfileResponse` DTO with static factory from entity
- Add unit tests with Mockito
**Allowed files**:
- `src/main/java/.../service/UserProfileService.java`
- `src/main/java/.../dto/UpdateProfileRequest.java`
- `src/main/java/.../dto/UserProfileResponse.java`
- `src/test/java/.../service/UserProfileServiceTest.java`
**Forbidden changes**:
- No controller changes
- No database schema changes
- No security configuration changes
**Verification**:
- `./mvnw test -Dtest=UserProfileServiceTest`
**Acceptance criteria**:
- Service returns profile data correctly
- Service throws `ResourceNotFoundException` when profile not found
- Service throws `ForbiddenException` when user tries to update another user's profile
- Unit tests cover success and failure scenarios

## Phase 3
**Goal**: Add REST endpoints for user profile with integration tests.
**Context needed**: `architecture/api-design.md` (endpoint conventions), `architecture/error-handling.md` (HTTP status codes), `infrastructure/security.md` (auth), `workflow/implementation.md` (coding conventions), `features/_CONVENTIONS.md` (MockMvc test patterns)
**Tasks**:
- Create `UserProfileController` with GET and PUT endpoints
- Add `@Valid` on request DTO
- Add `@Operation` and `@ApiResponse` Swagger annotations
- Add integration tests with `@WebMvcTest` (MockMvc)
- Test cases: success, 404 not found, 403 forbidden, 400 validation error
**Allowed files**:
- `src/main/java/.../controller/UserProfileController.java`
- `src/test/java/.../controller/UserProfileControllerTest.java`
**Forbidden changes**:
- No service or entity changes
- No migration changes
**Verification**:
- `./mvnw test -Dtest=UserProfileControllerTest`
- `./mvnw spring-boot:run` (verify app starts)
- Check Swagger: `http://localhost:8080/swagger-ui.html`
**Acceptance criteria**:
- GET /api/v1/users/{id}/profile returns 200 with profile data
- PUT /api/v1/users/{id}/profile returns 200 on successful update
- Returns 404 when profile not found
- Returns 403 when non-admin user tries to view another user's profile
- Returns 400 on validation errors
- Swagger documentation shows new endpoints

## Next step
execute plan 1 for API-201
