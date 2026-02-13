# Implementation
> Tags: code, conventions, rails, patterns, views
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain -> STOP and ask

## Rails Conventions
- Controllers: thin, < 100 lines, delegate to services
- Models: validations + associations, extract concerns if shared
- Services: `app/services/` for multi-step business logic
- Policies: `app/policies/` for authorization
- Jobs: `app/jobs/` for background work
- Mailers: `app/mailers/` for emails, always `deliver_later`
- Migrations: only with explicit approval

## View Conventions
- Use partials for reusable elements
- Pass locals explicitly to partials (not instance variables)
- Keep logic out of views -- use helpers or presenters
- Use `form_with(model: ...)` for forms (not `form_for` or `form_tag`)
- Flash messages: `:notice` for success, `:alert` for errors
- Use `flash.now` when rendering (not redirecting), especially for Turbo
- Always render with `status: :unprocessable_entity` on validation failure (Turbo requirement)

## Turbo Conventions
- Turbo Drive: enabled by default, opt-out specific elements with `data-turbo="false"`
- Turbo Frames: use `turbo_frame_tag dom_id(model)` for targeted updates
- Turbo Streams: use `respond_to` with `format.turbo_stream` + `format.html` fallback
- Stimulus: one behavior per controller, use targets/values/actions

## File Locations
```
app/controllers/          -> controllers (thin)
app/models/               -> models + concerns
app/services/             -> service objects
app/policies/             -> authorization policies
app/jobs/                 -> background jobs
app/mailers/              -> mailers
app/views/                -> view templates
app/views/layouts/        -> layouts
app/views/shared/         -> shared partials
app/helpers/              -> view helpers
app/javascript/           -> JS entrypoint
app/javascript/controllers/ -> Stimulus controllers
app/assets/stylesheets/   -> CSS/SCSS
config/routes.rb          -> routing
db/migrate/               -> migrations
spec/system/              -> system/feature specs (Capybara)
spec/requests/            -> request/integration specs
spec/models/              -> model specs
spec/services/            -> service specs
spec/helpers/             -> helper specs
spec/mailers/             -> mailer specs
```

## Danger Zones
- Auth changes -> ask first
- Direct SQL / raw queries -> justify
- Data scoping bypass (accessing other users' data) -> ask first
- Skipping validations -> never
- Using `html_safe` or `raw` on user content -> never
- Disabling CSRF -> never (full-stack Rails requires it)
