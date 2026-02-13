# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this project
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first -> execute in small phases -> verify -> human review
- No scope creep, no unrelated refactors

## Rails Patterns Used

### Controllers
- Thin: < 100 lines, no business logic
- Inherit from `ApplicationController`
- Use strong parameters always
- Set flash messages for redirects; use `flash.now` for renders
- Respond to HTML by default; add Turbo Stream format when needed
```ruby
# Standard controller action pattern
def create
  @resource = current_user.resources.build(resource_params)
  if @resource.save
    redirect_to @resource, notice: "Resource created."
  else
    flash.now[:alert] = "Could not create resource."
    render :new, status: :unprocessable_entity
  end
end
```

### Models
- Validations and associations only
- Extract shared behavior into concerns (see example below)
- No business logic -- delegate to services
- Scopes for common queries

### Concerns
- Location: `app/models/concerns/` (models) or `app/controllers/concerns/` (controllers)
- Use for shared behavior across multiple models or controllers
```ruby
# app/models/concerns/archivable.rb
module Archivable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(archived_at: nil) }
    scope :archived, -> { where.not(archived_at: nil) }
  end

  def archive!
    update!(archived_at: Time.current)
  end
end
```

### Services
- Location: `app/services/`
- One public method per service (usually `call` or `perform`)
- Used for: multi-step operations, cross-model logic, external API calls
- Naming: `VerbNounService` (e.g. `CreateOrderService`)

### Policies
<!-- DELETE this section if not using policy-based authorization -->
- Location: `app/policies/`
- Library: [e.g. Pundit / CanCanCan / custom]
- One policy per model
- Check in controller before_action

### Jobs
<!-- DELETE this section if not using background jobs -->
- Location: `app/jobs/`
- Queue: [e.g. Sidekiq / GoodJob / SolidQueue / DelayedJob]
- Naming: `VerbNounJob` (e.g. `SendWelcomeEmailJob`)
- Idempotent: jobs must be safe to retry

### Mailers
- Location: `app/mailers/`
- Views: `app/views/[mailer_name]/`
- Naming: `VerbNounMailer` or `[Model]Mailer` (e.g. `UserMailer`)
- Always deliver via jobs: `UserMailer.welcome(user).deliver_later`

### View Components / Partials
- Reusable UI: shared partials in `app/views/shared/`
- Component library: [e.g. ViewComponent / Phlex / plain partials]
- Location: [e.g. `app/components/` for ViewComponent / `app/views/shared/`]

## Testing Standards
- Framework: RSpec
- System specs for critical user flows (Capybara)
- Request specs for controller actions
- Model specs for validations/associations/scopes
- Service specs for business logic
- Factories: FactoryBot
- No `let!` unless needed, prefer `let`

## Quality Checklist
- [ ] Strong parameters in all controller actions
- [ ] RSpec tests for all new code
- [ ] RuboCop passes
- [ ] No N+1 queries (use `includes`/`eager_load`)
- [ ] Flash messages for user feedback
- [ ] Error states handled with proper HTTP status codes
- [ ] Views use partials for reusable elements
- [ ] Turbo-compatible responses (status: :unprocessable_entity on render)
- [ ] Rollback plan for migrations

## Changelog
<!-- [PROJ-123] Adopted service object pattern for all business logic -->
