# Environment
> Tags: ruby, rails, runtime, versions, os, assets
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Ruby: [e.g. 3.2.x]
- Rails: [e.g. 7.1.x]
- Bundler: [e.g. 2.x]
- Node: [e.g. 18.x / not required if using importmap]
- Yarn/npm: [e.g. yarn 1.x / npm 9.x / not required]

## Database & Services
- Primary DB: [e.g. PostgreSQL / MySQL / SQLite]
- Cache: [e.g. Redis / Memcached / SolidCache / none]
- Search: [e.g. Elasticsearch / none]
- Job backend: [e.g. Redis (for Sidekiq) / PostgreSQL (for GoodJob) / none]
- WebSocket: [e.g. Redis (for ActionCable) / SolidCable / none]

## Asset Pipeline
- Pipeline: [e.g. Propshaft / Sprockets]
- JS bundling: [e.g. importmap / esbuild / webpack / rollup]
- CSS: [e.g. Tailwind / Bootstrap / SCSS / plain CSS]
- Build command: [e.g. `rails assets:precompile` / `bin/dev` for development]

## OS / Container
- Dev: [e.g. macOS / Docker / devcontainer]
- CI: [e.g. GitHub Actions ubuntu-latest]
- Prod: [e.g. AWS ECS / Heroku / Render / Fly.io]

## Local Setup
```bash
# Minimum commands to get running
bundle install
rails db:setup
bin/dev          # or rails s (if not using Procfile.dev)
```

## Environment Variables
- `DATABASE_URL` - primary DB connection
- `REDIS_URL` - cache/job broker (if using Redis)
- `SECRET_KEY_BASE` - Rails credentials
- `RAILS_MASTER_KEY` - decrypt credentials
- [Add project-specific vars here]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Upgraded Ruby 3.1 -> 3.2 -->
