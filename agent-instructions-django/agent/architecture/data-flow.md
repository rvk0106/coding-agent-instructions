# Data Flow & Request Lifecycle
> Tags: request, middleware, pipeline, view, serializer, response, django
> Scope: How a request flows through the app from entry to response
> Last updated: [TICKET-ID or date]

## Request Pipeline
```
Client Request
  → WSGI (gunicorn) / ASGI (uvicorn/daphne)
    → Django Middleware Pipeline (top to bottom):
      1. SecurityMiddleware (HTTPS redirect, HSTS)
      2. SessionMiddleware (session handling)
      3. CommonMiddleware (URL normalization, APPEND_SLASH)
      4. CsrfViewMiddleware (CSRF for session auth)
      5. AuthenticationMiddleware (sets request.user)
      6. [Custom middleware] (logging, tenant resolution, etc.)
    → URL Resolver (urls.py)
      → DRF API View / ViewSet:
        1. Authentication (verify credentials → 401 if invalid)
        2. Permission checks (check access → 403 if denied)
        3. Throttle checks (rate limit → 429 if exceeded)
        4. Content negotiation
        5. View method (list/create/retrieve/update/destroy)
          → Serializer (validate input, serialize output)
            → Model / Manager (DB read/write via ORM)
            → External service calls (if any)
          → Response object
      → DRF Response rendering
    → Django Middleware Pipeline (bottom to top, response phase)
  → WSGI/ASGI
Client Response
```

## DRF Authentication Flow
<!-- Adapt to your auth method (Token, JWT, Session) -->
```
Request → DRF authentication classes (in order) → first to authenticate wins
  ├── TokenAuthentication: extract from Authorization header → lookup Token → set request.user
  ├── JWTAuthentication: extract Bearer token → decode/verify → set request.user
  ├── SessionAuthentication: check session cookie + CSRF → set request.user
  ├── Authenticated → proceed to permission check
  ├── Failed → 401 Unauthorized
  └── No credentials → AnonymousUser (may proceed if AllowAny)
```

## DRF Permission Flow
<!-- Adapt to your permission classes -->
```
View → check permission_classes (in order) → all must pass
  ├── has_permission(request, view) → view-level check
  ├── has_object_permission(request, view, obj) → object-level check (retrieve/update/destroy)
  ├── All pass → proceed to view logic
  └── Any deny → 403 Forbidden
```

## Middleware Pipeline
<!-- Document custom middleware if used -->
```python
# settings.py MIDDLEWARE order matters:
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',          # CORS (must be high)
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    # [Custom middleware here]
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

## Multi-Tenant Flow
<!-- DELETE this section if your app is single-tenant -->
```
Request → middleware resolves tenant (from subdomain/header) → set tenant context
  ├── All ORM queries auto-scoped to tenant (via custom manager or middleware)
  ├── Admin routes → may cross tenant boundaries
  └── Danger: raw SQL or Manager.all() bypasses tenant scoping
```

## Signals Flow
<!-- DELETE this section if not using signals -->
```
Model.save() / Model.delete()
  → pre_save / pre_delete signal → handlers run synchronously
  → DB write
  → post_save / post_delete signal → handlers run synchronously
  WARNING: Signals run in the same transaction; failures can roll back the save.
```

## Celery Task Flow
<!-- DELETE this section if not using Celery -->
```
View → task.delay(args) → return 200/202 to client immediately
  → Celery worker picks up task from broker (Redis/RabbitMQ)
    → Execute task → update DB / call external service
    → If failure → retry (max_retries, exponential backoff)
    → If max retries exceeded → dead letter / log error
```

## Transaction Rules
- ALWAYS use `transaction.atomic()` for multi-model writes
- NEVER call external services inside a transaction (holds DB lock on network failure)
- Pattern: DB writes in `atomic()` → external calls after commit
- Use `transaction.on_commit()` for post-commit side effects (sending emails, Celery tasks)

```python
from django.db import transaction

def create_order(user, items):
    with transaction.atomic():
        order = Order.objects.create(user=user, status='pending')
        for item in items:
            OrderItem.objects.create(order=order, **item)

    # After commit: safe to trigger side effects
    transaction.on_commit(lambda: send_order_confirmation.delay(order.id))
```

## Serialization Pipeline
- Serializer: DRF ModelSerializer / Serializer
- Format: JSON (default renderer)
- Naming: [e.g. snake_case / camelCase via djangorestframework-camel-case]
- Timestamps: [e.g. ISO-8601 (DRF default)]
- Nulls: [e.g. included as null / omitted]

## Changelog
<!-- [PROJ-123] Added rate limiting middleware -->
