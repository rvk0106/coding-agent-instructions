# Dependencies
> Tags: gems, services, apis, external
> Scope: All external dependencies the app relies on
> Last updated: [TICKET-ID or date]

## Key Gems
<!-- List gems the agent needs to know about when planning/implementing -->
- Authentication: [e.g. `devise` / `jwt` / `devise-jwt` / `rodauth` / none]
- Authorization: [e.g. `pundit` / `cancancan` / custom / none]
- Background jobs: [e.g. `sidekiq` / `good_job` / `solid_queue` / none]
- Database adapter: [e.g. `pg` / `mysql2` / `sqlite3`]
- Testing: `rspec-rails`
- Linting: `rubocop-rails`
- API docs: [e.g. `rswag` / `swagger-blocks` / none]
- [Add project-specific gems]

## External Services
<!-- Services the app talks to -->
- Payment: [e.g. Stripe / none]
- Email: [e.g. SendGrid / ActionMailer only]
- Storage: [e.g. S3 / ActiveStorage local]
- Monitoring: [e.g. Sentry / Datadog / none]
- [Add project-specific services]

## Internal APIs / Microservices
<!-- Other services this app depends on or is consumed by -->
- [e.g. Auth service at auth.internal:3001]
- [e.g. Consumed by frontend at app.example.com]

## Changelog
<!-- [PROJ-123] Added Stripe gem for payments -->
