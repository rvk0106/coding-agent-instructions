# Environment
> Tags: ruby, rails, runtime, versions, os
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Ruby: [e.g. 3.2.x]
- Rails: [e.g. 7.1.x]
- Bundler: [e.g. 2.x]
- Node: [e.g. 18.x] (if asset pipeline or JS needed)

## Database
- Primary: [e.g. PostgreSQL 15.x]
- Cache: [e.g. Redis 7.x]
- Search: [e.g. Elasticsearch 8.x / none]

## OS / Container
- Dev: [e.g. macOS / Docker / devcontainer]
- CI: [e.g. GitHub Actions ubuntu-latest]
- Prod: [e.g. AWS ECS / Heroku / Render]

## Local Setup
```bash
# Minimum commands to get running
bundle install
rails db:setup
rails s
```

## Environment Variables
- `DATABASE_URL` - primary DB connection
- `REDIS_URL` - cache/sidekiq broker
- `SECRET_KEY_BASE` - Rails credentials
- [Add project-specific vars here]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Upgraded Ruby 3.1 → 3.2 -->
