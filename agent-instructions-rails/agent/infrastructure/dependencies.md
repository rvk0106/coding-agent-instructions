# Dependencies
> Tags: gems, services, apis, external
> Scope: All external dependencies the app relies on
> Last updated: [TICKET-ID or date]

## Key Gems
<!-- List gems the agent needs to know about when planning/implementing -->
- `devise` / `jwt` - authentication ([describe which])
- `pundit` / `cancancan` - authorization ([describe which])
- `sidekiq` - background jobs
- `pg` - PostgreSQL adapter
- `rspec-rails` - testing
- `rubocop-rails` - linting
- `rswag` / `swagger-blocks` - API docs ([describe which])
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
