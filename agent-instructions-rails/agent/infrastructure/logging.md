# Logging & Monitoring
> Tags: logging, monitoring, errors, tracking, observability
> Scope: What to log, how to log, error tracking setup
> Last updated: [TICKET-ID or date]

## Log Levels
| Level | When to Use |
|-------|-------------|
| `debug` | Dev-only detail (SQL, params) -- never in prod |
| `info` | Normal operations (request served, job completed) |
| `warn` | Recoverable issues (retry succeeded, deprecation) |
| `error` | Failed operations (exception caught, external service down) |
| `fatal` | App cannot continue (DB unreachable, missing config) |

## What to Log
- Request: method, path, status, duration, user_id
- Background jobs: job name, args (sanitized), duration, result
- External service calls: service, endpoint, status, duration
- Auth events: login, logout, failed login, token refresh
- Business events: [project-specific key actions]

## What NEVER to Log
- Passwords, tokens, API keys
- Full credit card numbers
- PII beyond what's needed for debugging
- Raw request bodies with sensitive fields

## Structured Logging
- Format: [e.g. JSON / logfmt / Rails default]
- Library: [e.g. Lograge / Semantic Logger / Rails.logger]
- Example:
  ```ruby
  # config/initializers/lograge.rb (if using Lograge)
  Rails.application.configure do
    config.lograge.enabled = true
    config.lograge.custom_payload do |controller|
      { user_id: controller.current_user&.id }
    end
  end
  ```

## Error Tracking
- Service: [e.g. Sentry / Bugsnag / Honeybadger / none]
- Setup: [e.g. `SENTRY_DSN` env var]
- Rules:
  - Capture unhandled exceptions automatically
  - Add user context (user_id, tenant_id) to error reports
  - Ignore: `ActiveRecord::RecordNotFound`, `ActionController::RoutingError`
  - Alert: 500+ error rate spikes

## Query Logging
- Dev: SQL queries logged by default
- Prod: disable verbose SQL, enable slow query alerts
- Threshold: [e.g. queries > 500ms]
- N+1 detection: [e.g. Bullet gem in development]

## Changelog
<!-- [PROJ-123] Added Sentry for error tracking -->
