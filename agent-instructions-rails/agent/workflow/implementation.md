# Implementation
> Tags: code, conventions, rails, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain → STOP and ask

## Rails Conventions
- Controllers: thin, < 100 lines, delegate to services
- Models: validations + associations, extract concerns if shared
- Services: `app/services/` for multi-step business logic
- Policies: `app/policies/` for authorization
- Jobs: `app/jobs/` for background work
- Migrations: only with explicit approval

## File Locations
```
app/controllers/     → controllers (thin)
app/models/          → models + concerns
app/services/        → service objects
app/policies/        → authorization policies
app/jobs/            → background jobs
app/serializers/     → response serializers (if used)
config/routes.rb     → routing
db/migrate/          → migrations
spec/requests/       → request/integration specs
spec/models/         → model specs
spec/services/       → service specs
```

## API Response Shape
See `architecture/api-design.md` for the project's standard response shapes. All endpoints must use them consistently.

## Danger Zones
- Auth changes → ask first
- Direct SQL / raw queries → justify
- Data scoping bypass (accessing other users' data) → ask first
- Skipping validations → never
