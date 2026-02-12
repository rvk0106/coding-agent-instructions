# System Design
> Tags: architecture, components, data-flow, high-level, django
> Scope: How the system is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this app does -->
[Describe what this app does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual stack -->
```
[Client] → [Load Balancer / Reverse Proxy] → [Django / DRF API] → [Database]
                                                                  → [Cache] (if used)
                                                                  → [Celery Workers] (if used)
                                                                  → [File Storage] (if used)
```
- Database: [e.g. PostgreSQL / MySQL / SQLite]
- Cache: [e.g. Redis / Memcached / none]
- Task queue: [e.g. Celery + Redis / Celery + RabbitMQ / Django-Q / none]
- Storage: [e.g. S3 / django-storages / local media / none]

## Django Project Structure
<!-- Document your project vs apps layout -->
```
project_name/               ← Django project (settings, root urls, wsgi/asgi)
├── settings/
│   ├── base.py             ← shared settings
│   ├── dev.py              ← development overrides
│   └── prod.py             ← production overrides
├── urls.py                 ← root URL configuration
├── wsgi.py / asgi.py       ← entry points
apps/
├── users/                  ← user management app
├── [app_name]/             ← domain-specific app
│   ├── models.py
│   ├── views.py
│   ├── serializers.py
│   ├── urls.py
│   ├── permissions.py
│   ├── signals.py
│   ├── admin.py
│   ├── apps.py
│   └── tests/
└── ...
```

## Tenancy Model
<!-- DELETE this section if your app is single-tenant -->
- [e.g. account scoping via tenant_id column / schema-based via django-tenants]
- Tenant resolution: [e.g. subdomain / header / path]

## Authentication
- Method: [e.g. DRF TokenAuthentication / JWT (djangorestframework-simplejwt) / SessionAuthentication / OAuth2]
- Token flow: [e.g. login → access_token + refresh_token / session cookie]
- Custom user model: [e.g. extends AbstractUser / AbstractBaseUser]

## Authorization
- Library: [e.g. DRF permissions / django-guardian / django-rules / custom]
- Roles: [e.g. admin, manager, member, viewer]
- Pattern: [e.g. permission_classes on views / groups + permissions / object-level]

## Key Data Flows
<!-- Describe 2-3 critical flows -->
1. **User Registration**: POST /api/v1/auth/register → create user → send verification email → activate
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added Celery task processing pipeline -->
