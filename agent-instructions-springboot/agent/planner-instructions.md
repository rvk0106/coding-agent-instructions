# Planner Instructions — Spring Boot (Framework‑Specific)

> When user says: "plan architecture for TICKET-ID" follow these mandated steps:

## Rules
- No code during planning.
- Produce small, reversible phases (≈10 minutes each).
- Each phase must be independently verifiable.
- Explicitly state scope boundaries.
- Reference Spring Boot conventions (thin controllers, service layer for business logic).

## Planning workflow

### 1. Fetch ticket details (from ticket-access.md)
- Use Linear API, MCP, or manual paste to get ticket information.
- Extract title, description, acceptance criteria, and requirements.

### 2. Read project standards & patterns
- Review `agent/` folder for all instruction files (if in project root).
- Check for project-specific instruction files.
- Read `principles-and-standards.md` for architectural patterns and standards.

### 3. Analyze existing Spring Boot codebase patterns
- Review `pom.xml` or `build.gradle` for dependencies and project structure
- Check `src/main/resources/application.properties` (or `.yml`) for configuration patterns
- Examine `src/main/java/.../controller/` for REST API patterns
- Review `src/main/java/.../service/` for business logic patterns
- Check `src/main/java/.../repository/` for data access patterns
- Review `src/main/java/.../model/` for JPA entity patterns
- Examine `src/main/java/.../dto/` for request/response patterns
- Check `src/test/` directory for test patterns
- Review OpenAPI/Swagger configuration (if exists)

### 4. Verify if backend changes are needed
- Check if existing endpoints can fulfill requirements.
- Analyze if current database schema supports the feature.
- Evaluate if existing services have necessary functionality.

### 5. Plan for reusability
- Identify existing services, repositories, and utilities to reuse.
- Avoid duplicating code.
- Document reused components.

### 6. Check for admin/role-specific logic
- If role-specific: plan appropriate @PreAuthorize or security rules
- Follow existing authorization patterns

### 7. Save analysis & architecture to `docs/TICKET-ID-plan.md`
- Create or update: `docs/TICKET-ID-plan.md`
- Include all required sections (see below)

## Required Spring Boot pre‑analysis areas
- `pom.xml` or `build.gradle` for dependencies and plugins
- `application.properties`/`application.yml` for configuration
- Package structure and naming conventions
- Controller/Service/Repository patterns
- Exception handling approach (@ControllerAdvice)
- Test structure (JUnit, Mockito, integration tests)

## Spring Boot danger zones (must call out if touched)
- Security configuration (WebSecurityConfig, authentication)
- Database migrations (Liquibase/Flyway scripts)
- Async/messaging configurations
- Caching configurations
- Production properties/secrets

## Required plan format
### Ticket metadata
- Ticket ID
- Title
- Owner
- Priority

### Requirements & constraints
- Acceptance criteria
- Non‑goals
- Dependencies

### Current state analysis
- Existing endpoints, services, repositories
- Current database schema
- Dependency availability
- Security/authorization patterns

### Architecture decisions
- Key decisions with trade‑offs
- Affected packages (controller, service, repository, dto, model)
- API design (endpoints, request/response formats)
- Data model changes
- Security/authorization approach

### Implementation phases
For each phase:
- Goal
- Tasks
- Allowed files/packages
- Forbidden changes
- Verification commands
- Acceptance criteria

#### Phase guidelines (Spring Boot)
- Keep controllers thin (< 100 lines); delegate to services
- Use @Service classes for business logic
- Repository for data access only
- DTOs for request/response; entities stay internal
- Add integration tests for new endpoints
- Unit tests for service logic

#### Recommended verification commands
- Build: `./mvnw clean install` or `./gradlew build`
- Unit tests: `./mvnw test` or `./gradlew test`
- Specific test: `./mvnw test -Dtest=ClassName`
- Checkstyle: `./mvnw checkstyle:check`
- Run app: `./mvnw spring-boot:run`

### Output location
- Save plan to: `docs/TICKET-ID-plan.md`

### Next step
Tell the user: `execute plan <N> for <TICKET>`
