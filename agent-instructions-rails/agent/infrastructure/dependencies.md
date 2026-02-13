# Dependencies
> Tags: gems, services, apis, external
> Scope: All external dependencies the app relies on
> Last updated: [TICKET-ID or date]

## Key Gems
<!-- List gems the agent needs to know about when planning/implementing -->
- Authentication: [e.g. `devise` / `rodauth` / `clearance` / custom]
- Authorization: [e.g. `pundit` / `cancancan` / custom / none]
- Background jobs: [e.g. `sidekiq` / `good_job` / `solid_queue` / none]
- Database adapter: [e.g. `pg` / `mysql2` / `sqlite3`]
- Frontend/Hotwire: [e.g. `turbo-rails` / `stimulus-rails` / `importmap-rails`]
- Forms: [e.g. `simple_form` / `formtastic` / standard `form_with`]
- Pagination: [e.g. `pagy` / `kaminari` / `will_paginate`]
- View components: [e.g. `view_component` / `phlex` / plain partials]
- Decorators: [e.g. `draper` / none]
- CSS: [e.g. `tailwindcss-rails` / `bootstrap` / `sassc-rails` / `cssbundling-rails`]
- JS bundling: [e.g. `jsbundling-rails` / `importmap-rails`]
- File uploads: [e.g. `activestorage` / `shrine` / `carrierwave`]
- Rich text: [e.g. `actiontext` / none]
- Testing: `rspec-rails`, [e.g. `capybara` / `selenium-webdriver`]
- Linting: `rubocop-rails`, [e.g. `erb_lint`]
- [Add project-specific gems]

## External Services
<!-- Services the app talks to -->
- Payment: [e.g. Stripe / none]
- Email: [e.g. SendGrid / Postmark / ActionMailer SMTP only]
- Storage: [e.g. S3 / ActiveStorage local]
- Monitoring: [e.g. Sentry / Datadog / none]
- [Add project-specific services]

## Internal APIs / Microservices
<!-- Other services this app depends on or is consumed by -->
- [e.g. Auth service at auth.internal:3001]
- [e.g. Mobile app consuming /api/v1/ endpoints]

## Changelog
<!-- [PROJ-123] Added Stripe gem for payments -->
