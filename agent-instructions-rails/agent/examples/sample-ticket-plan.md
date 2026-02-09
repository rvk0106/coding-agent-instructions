# Sample Ticket Plan — Linear Style

**Location**: `docs/EDU-421-plan.md`

## Ticket metadata
- Ticket ID: EDU-421
- Title: Program CRUD with hierarchy support
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Admins can create, update, and delete programs.
- Programs may have parent/child relationships.
- Prevent cycles in hierarchy.
- Expose read endpoints for non‑admin users.
- Non‑goals: UI changes, data migration for existing records.

## Current state analysis
- Reviewed `db/schema.rb`: programs table exists with basic fields
- Checked `app/models/program.rb`: basic validations present
- Reviewed `app/controllers/api/v1/`: no programs controller exists
- Analyzed `config/routes.rb`: no programs routes defined
- Reviewed `spec/`: no programs specs exist
- Checked `.rubocop.yml`: standard Rails cops enabled

## Context Loaded
- `workflow/context-router.md` → task type: New API Endpoint
- `architecture/api-design.md` → endpoint naming, response shape
- `architecture/error-handling.md` → validation error shape
- `architecture/data-flow.md` → request lifecycle, auth pipeline
- `architecture/patterns.md` → controller/model/service conventions
- `architecture/glossary.md` → domain terms
- `features/_CONVENTIONS.md` → serialization, query patterns
- `infrastructure/security.md` → tenant scoping rules
- `architecture/database.md` → tenant schema (admin endpoint)

## Architecture decisions
- Add hierarchy validation in model layer.
- Use a service for create/update to enforce business rules.
- Add admin controller for write operations; public controller for reads.
- Update routes to separate admin and public endpoints.
- Ensure responses follow the standard Rails API payload shape.

## Phase 1
**Goal**: Add model validations and hierarchy checks.
**Context needed**: `architecture/patterns.md` (model conventions), `features/_CONVENTIONS.md` (model spec patterns)
**Tasks**:
- Add parent association and validation.
- Add cycle detection method.
- Add model specs.
**Allowed files**:
- app/models/program.rb
- spec/models/program_spec.rb
**Forbidden changes**:
- No controller or route changes.
- No migrations.
**Verification**:
- `bundle exec rspec spec/models/program_spec.rb`
**Acceptance criteria**:
- Cycle creation is rejected.
- Parent/child constraints validated.

## Phase 2
**Goal**: Add admin write endpoints with service object.
**Context needed**: `architecture/api-design.md` (response shape), `architecture/error-handling.md` (validation errors), `infrastructure/security.md` (admin auth), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Add service object for create/update.
- Add admin controller actions.
- Add request specs.
**Allowed files**:
- app/services/program_upsert_service.rb
- app/controllers/api/v1/admin/programs_controller.rb
- spec/requests/api/v1/admin/programs_spec.rb
**Forbidden changes**:
- No public read endpoints.
- No UI changes.
**Verification**:
- `bundle exec rspec spec/requests/api/v1/admin/programs_spec.rb`
 - `bundle exec rake swagger:generate_modular`
**Acceptance criteria**:
- Admin can create/update/delete.
- Validation errors return consistent API format.

## Phase 3
**Goal**: Add public read endpoints.
**Context needed**: `architecture/api-design.md` (public endpoint conventions), `architecture/data-flow.md` (read request pipeline), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Add read-only controller actions.
- Add routes.
- Add request specs.
**Allowed files**:
- app/controllers/api/v1/programs_controller.rb
- config/routes.rb
- spec/requests/api/v1/programs_spec.rb
**Forbidden changes**:
- No admin write changes.
**Verification**:
- `bundle exec rspec spec/requests/api/v1/programs_spec.rb`
 - `bundle exec rake swagger:generate_modular`
**Acceptance criteria**:
- Non‑admin users can list and show programs.

## Next step
execute plan 1 for EDU-421
