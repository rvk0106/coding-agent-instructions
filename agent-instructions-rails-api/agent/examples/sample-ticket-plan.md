# Sample Ticket Plan

**Location**: `docs/PROJ-101-plan.md`

## Ticket metadata
- Ticket ID: PROJ-101
- Title: Resource CRUD with category support
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Admins can create, update, and delete resources.
- Resources belong to categories (each resource has one category).
- Expose read endpoints for non-admin users.
- Non-goals: UI changes, data migration for existing records.

## Current state analysis
- Reviewed `db/schema.rb`: resources table exists with basic fields
- Checked `app/models/resource.rb`: basic validations present
- Reviewed `app/controllers/api/v1/`: no resources controller exists
- Analyzed `config/routes.rb`: no resources routes defined
- Reviewed `spec/`: no resources specs exist
- Checked `.rubocop.yml`: standard Rails cops enabled

## Context Loaded
- `workflow/context-router.md` → task type: New API Endpoint
- `architecture/api-design.md` → endpoint naming, response shape
- `architecture/error-handling.md` → validation error shape
- `architecture/data-flow.md` → request lifecycle, auth pipeline
- `architecture/patterns.md` → controller/model/service conventions
- `architecture/glossary.md` → domain terms
- `features/_CONVENTIONS.md` → serialization, query patterns
- `infrastructure/security.md` → query scoping rules

## Architecture decisions
- Add category association and validation in model layer.
- Use a service for create/update to enforce business rules.
- Add admin controller for write operations; public controller for reads.
- Update routes to separate admin and public endpoints.
- Follow the project's standard API response shape.

## Phase 1
**Goal**: Add model validations and category association.
**Context needed**: `architecture/patterns.md` (model conventions), `features/_CONVENTIONS.md` (model spec patterns)
**Tasks**:
- Add category association and validation.
- Add model specs.
**Allowed files**:
- app/models/resource.rb
- spec/models/resource_spec.rb
**Forbidden changes**:
- No controller or route changes.
- No migrations.
**Verification**:
- `bundle exec rspec spec/models/resource_spec.rb`
**Acceptance criteria**:
- Category association validated.
- Required fields enforced.

## Phase 2
**Goal**: Add admin write endpoints with service object.
**Context needed**: `architecture/api-design.md` (response shape), `architecture/error-handling.md` (validation errors), `infrastructure/security.md` (admin auth), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Add service object for create/update.
- Add admin controller actions.
- Add request specs.
**Allowed files**:
- app/services/resource_upsert_service.rb
- app/controllers/api/v1/admin/resources_controller.rb
- spec/requests/api/v1/admin/resources_spec.rb
**Forbidden changes**:
- No public read endpoints.
- No UI changes.
**Verification**:
- `bundle exec rspec spec/requests/api/v1/admin/resources_spec.rb`
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
- app/controllers/api/v1/resources_controller.rb
- config/routes.rb
- spec/requests/api/v1/resources_spec.rb
**Forbidden changes**:
- No admin write changes.
**Verification**:
- `bundle exec rspec spec/requests/api/v1/resources_spec.rb`
**Acceptance criteria**:
- Non-admin users can list and show resources.

## Next step
execute plan 1 for PROJ-101
