# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this project
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first → execute in small phases → verify → human review
- No scope creep, no unrelated refactors

## Rails Patterns Used

### Controllers
- Thin: < 100 lines, no business logic
- Inherit from base API controller
- Use strong parameters always
- Use consistent response shape (see `api-design.md`)

### Models
- Validations and associations only
- Extract shared behavior into concerns
- No business logic -- delegate to services
- Scopes for common queries

### Services
- Location: `app/services/`
- One public method per service (usually `call` or `perform`)
- Used for: multi-step operations, cross-model logic, external API calls
- Naming: `VerbNounService` (e.g. `CreateProgramService`)

### Policies
- Location: `app/policies/`
- Library: [e.g. Pundit / CanCanCan]
- One policy per model
- Check in controller before_action

### Jobs
- Location: `app/jobs/`
- Queue: [e.g. Sidekiq]
- Naming: `VerbNounJob` (e.g. `SendWelcomeEmailJob`)
- Idempotent: jobs must be safe to retry

## Testing Standards
- Framework: RSpec
- Request specs for every endpoint
- Model specs for validations/associations/scopes
- Service specs for business logic
- Factories: FactoryBot
- No `let!` unless needed, prefer `let`

## Quality Checklist
- [ ] Strong parameters in all controller actions
- [ ] RSpec tests for all new code
- [ ] RuboCop passes
- [ ] Swagger updated (if API changed)
- [ ] No N+1 queries (use `includes`/`eager_load`)
- [ ] Error handling with consistent payloads
- [ ] Rollback plan for migrations

## Changelog
<!-- [PROJ-123] Adopted service object pattern for all business logic -->
