# Sample Ticket Plan — Spring Boot

**Location**: `docs/API-123-plan.md`

## Ticket metadata
- Ticket ID: API-123
- Title: Course enrollment API with capacity limits
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Admins and instructors can create courses with max capacity.
- Students can enroll if capacity available.
- Prevent over-enrollment.
- Expose REST endpoints for course management.
- Non‑goals: Payment integration, waitlist feature.

## Current state analysis
- Reviewed `pom.xml`: Spring Boot 3.x, Spring Data JPA, validation present
- Checked `application.yml`: PostgreSQL configured
- Reviewed `/controller/`: CourseController exists with basic CRUD
- Analyzed `/service/`: CourseService has create/update logic
- Checked `/repository/`: CourseRepository extends JpaRepository
- Reviewed `/model/`: Course entity exists, no enrollment tracking
- No enrollment entity or service exists
- Swagger configured at `/swagger-ui.html`

## Architecture decisions
- Add Enrollment entity with @ManyToOne relationship to Course and User
- Create EnrollmentService for business logic (capacity check, enrollment)
- Add EnrollmentController for REST endpoints
- Use @Transactional for enrollment to ensure atomicity
- Validate capacity in service layer before enrollment
- Return proper HTTP status codes (201 for enrollment, 409 for capacity full)

## Phase 1
**Goal**: Add Enrollment entity and repository with capacity tracking in Course.
**Tasks**:
- Update Course entity with `currentEnrollment` and `maxCapacity` fields
- Create Enrollment entity with Course and User relationships
- Create EnrollmentRepository interface
- Add database migration (Liquibase/Flyway)
- Add unit tests for entity relationships
**Allowed files**:
- `src/main/java/.../model/Course.java`
- `src/main/java/.../model/Enrollment.java`
- `src/main/java/.../repository/EnrollmentRepository.java`
- `src/main/resources/db/changelog/` (migration)
- `src/test/java/.../model/`
**Forbidden changes**:
- No controller or service changes
- No API endpoints
**Verification**:
- `./mvnw test -Dtest=CourseTest,EnrollmentTest`
- `./mvnw clean compile`
**Acceptance criteria**:
- Entities map correctly to database
- Relationships configured with proper cascade/fetch settings

## Phase 2
**Goal**: Add EnrollmentService with capacity validation logic.
**Tasks**:
- Create EnrollmentService with enroll() method
- Implement capacity check logic
- Add @Transactional annotation
- Create custom exceptions (CourseFullException, AlreadyEnrolledException)
- Add unit tests with Mockito
**Allowed files**:
- `src/main/java/.../service/EnrollmentService.java`
- `src/main/java/.../exception/CourseFullException.java`
- `src/main/java/.../exception/AlreadyEnrolledException.java`
- `src/test/java/.../service/EnrollmentServiceTest.java`
**Forbidden changes**:
- No controller changes
- No database schema changes
**Verification**:
- `./mvnw test -Dtest=EnrollmentServiceTest`
**Acceptance criteria**:
- Service validates capacity correctly
- Throws appropriate exceptions
- Unit tests cover success and failure scenarios

## Phase 3
**Goal**: Add REST API endpoints for enrollment.
**Tasks**:
- Create EnrollmentController with POST /api/courses/{id}/enroll
- Create EnrollmentDTO for request/response
- Add @ControllerAdvice handler for custom exceptions
- Add integration tests with @SpringBootTest
- Update Swagger annotations
**Allowed files**:
- `src/main/java/.../controller/EnrollmentController.java`
- `src/main/java/.../dto/EnrollmentDTO.java`
- `src/main/java/.../exception/GlobalExceptionHandler.java`
- `src/test/java/.../controller/EnrollmentControllerTest.java`
**Forbidden changes**:
- No service or entity changes
**Verification**:
- `./mvnw test -Dtest=EnrollmentControllerTest`
- `./mvnw spring-boot:run`
- Check Swagger: `http://localhost:8080/swagger-ui.html`
**Acceptance criteria**:
- Endpoint returns 201 on successful enrollment
- Returns 409 when course is full
- Returns 400 on validation errors
- Swagger documentation updated

## Next step
execute plan 1 for API-123
