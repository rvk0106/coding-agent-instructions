# Dependencies
> Tags: packages, services, apis, external, pip, poetry
> Scope: All external dependencies the app relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- Prefer Django ecosystem packages (django-* / djangorestframework-*)
- Prefer well-maintained packages with active communities
- Pin versions in requirements files or pyproject.toml
- Review changelog before upgrading major versions

## Key Packages
<!-- List packages the agent needs to know about when planning/implementing -->

### Core
- `django` -- web framework
- `djangorestframework` -- REST API framework
- `django-filter` -- queryset filtering for DRF
- `django-cors-headers` -- CORS handling

### Database
- `psycopg2-binary` or `psycopg[binary]` -- PostgreSQL adapter
- `dj-database-url` -- DATABASE_URL parsing (optional)

### Authentication
- [e.g. `djangorestframework-simplejwt` / `dj-rest-auth` / `django-allauth` / none]

### Background Tasks
- [e.g. `celery` + `redis` / `django-celery-beat` / `django-q2` / none]

### API Documentation
- [e.g. `drf-spectacular` / `drf-yasg` / none]

### Other
- `django-environ` -- environment variable management (optional)
- [Add project-specific packages]

## Dev Dependencies
- `pytest` + `pytest-django` -- testing framework
- `factory-boy` -- test data factories
- `coverage` -- code coverage measurement
- `flake8` or `ruff` -- linting
- `black` -- code formatting
- `isort` -- import sorting
- `mypy` + `django-stubs` -- type checking (optional)
- `pre-commit` -- git hook management (optional)

## Requirements Files
```
requirements/
├── base.txt          ← shared (Django, DRF, etc.)
├── dev.txt           ← dev-only (-r base.txt + pytest, factory-boy, etc.)
└── prod.txt          ← prod-only (-r base.txt + gunicorn, sentry-sdk, etc.)
```
Or use `pyproject.toml` with poetry/pip groups.

## Process for Adding a Dependency
1. Check if Django/DRF has built-in support first
2. Evaluate: maintenance status, security record, community size
3. Add to the correct requirements file or pyproject.toml group
4. Pin to a compatible version range (e.g. `djangorestframework>=3.14,<4.0`)
5. Update `infrastructure/dependencies.md` with purpose and notes

## External Services
<!-- Services the app talks to -->
- Payment: [e.g. Stripe / none]
- Email: [e.g. SendGrid / AWS SES / Django email backends]
- Storage: [e.g. S3 via django-storages / local media]
- Monitoring: [e.g. Sentry / Datadog / none]
- [Add project-specific services]

## Internal APIs / Microservices
<!-- Other services this app depends on or is consumed by -->
- [e.g. Auth service at auth.internal:8001]
- [e.g. Consumed by frontend SPA at app.example.com]

## Changelog
<!-- [PROJ-123] Added drf-spectacular for API documentation -->
