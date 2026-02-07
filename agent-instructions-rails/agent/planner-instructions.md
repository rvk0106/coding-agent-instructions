# Planner Instructions — Rails (Framework‑Specific)

> When user says: "plan architecture for TICKET-ID" follow these mandated steps:

## Rules
- No code during planning.
- Produce small, reversible phases (≈10 minutes each).
- Each phase must be independently verifiable.
- Explicitly state scope boundaries.
- Reference Rails conventions (controllers thin, business logic in services/models).

## Planning workflow

### 1. Fetch ticket details (from ticket-access.md)
- Use Linear API, MCP, or manual paste to get ticket information.
- Extract title, description, acceptance criteria, and requirements.

### 2. Read project standards & patterns
- Review `agent/` folder for all instruction files (if in project root).
- Check for project-specific instruction files in:
  - `.github/instructions/*.instructions.md`
  - `docs/*.instructions.md`
- Read `design-patterns-used-in-rails.md` (if exists) for:
  - Architectural patterns
  - Coding standards
  - Class size limits
  - Naming conventions
  - Service object patterns
  - API response formats

### 3. Analyze existing Rails codebase patterns
- Review `db/schema.rb` for database patterns → Plan database changes
- Check `config/routes.rb` for API routing patterns → Plan API endpoints
- Examine `app/models/` for model patterns → Plan model structure
- Review `app/controllers/` for controller patterns → Plan controller structure
- Check `app/services/` for service object conventions
- Review `spec/` directory for test patterns → Plan testing strategy
- Check `docs/swagger.json` (or similar) for API documentation patterns
- Review `.rubocop.yml` for code quality standards

### 4. Verify if backend changes are needed
- Check if existing API endpoints can fulfill the requirements.
- Analyze if current database schema supports the feature.
- Evaluate if existing models/controllers have necessary functionality.
- If possible without backend changes, document frontend-only solution.

### 5. Plan for reusability
- Identify existing methods in models, controllers, and services that can be reused.
- Avoid duplicating code by leveraging existing functionality.
- Document any reused methods and their purpose.

### 6. Check for admin-specific logic
- If admin-specific: create separate controller in `api/v1/admin/`
- Follow existing patterns for controller structure and namespacing.

### 7. Save analysis & architecture to `docs/TICKET-ID-plan.md`
- Create or update: `docs/TICKET-ID-plan.md`
- Include:
  - Ticket metadata
  - Requirements & constraints
  - Architecture decisions
  - Current state analysis
  - Detailed phased plan (Phase 1..N)
  - File paths, code structure, and reasoning

## Required Rails pre‑analysis areas
- `config/routes.rb` for routing patterns and namespaces.
- `app/controllers/` for base controller inheritance and response format.
- `app/models/` for associations, validations, and patterns.
- `app/services/` for service object conventions.
- `spec/` for RSpec patterns and request spec structure.
- `db/schema.rb` (or `structure.sql`) for schema constraints.
- `.rubocop.yml` for linting rules.

## Rails danger zones (must call out if touched)
- AuthN/AuthZ, tenant switching, policy checks.
- Migrations/schema changes.
- Background jobs that mutate data.
- Money/billing logic.
- Production config/secrets.

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

## Architecture decisions
- Key decisions with trade‑offs
- Affected areas (models, controllers, services, routes, jobs, tests)
- Multi‑tenant boundaries (public vs admin schema)
- API response shape (success/error payloads)
- Authorization policy location (if needed)

### Implementation phases
For each phase:
- Goal
- Tasks
- Allowed files/areas
- Forbidden changes
- Verification commands
- Acceptance criteria

#### Phase guidelines (Rails)
- Keep controllers under 100 lines; use services for multi‑step logic.
- Prefer service objects in `app/services/` for business operations.
- Keep model changes minimal; extract concerns if shared.
- If adding endpoints: update routes, controller, request specs, and swagger tasks.
- If touching database: specify migration steps and rollback plan.

#### Recommended verification commands
- Targeted specs: `bundle exec rspec spec/requests/<path>_spec.rb`
- Model specs: `bundle exec rspec spec/models/<model>_spec.rb`
- Lint: `bundle exec rubocop`
- Swagger (if API changes): `bundle exec rake swagger:generate_modular`

### Output location
- Save plan to: `docs/TICKET-ID-plan.md`

### Next step
Tell the user: `execute plan <N> for <TICKET>`
