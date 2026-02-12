# Security Rules
> Tags: security, auth, cors, csrf, django, owasp
> Scope: Security constraints agents must follow -- prevents vulnerabilities
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never expose `SECRET_KEY` in code or logs
- Never set `DEBUG = True` in production
- Never use raw SQL with user input -- use Django ORM parameterized queries
- Never expose internal IDs or tracebacks in error responses
- Never log passwords, tokens, or PII
- Never disable CSRF protection for session-auth views
- Never hardcode secrets in code (use environment variables)
- Never trust client-side data for authorization
- Never use `Model.objects.get(id=request.data['id'])` without scoping to current user

## Always Do These
- Always set `ALLOWED_HOSTS` explicitly (never `['*']` in production)
- Always scope queries to current user (or tenant if multi-tenant)
- Always validate input through DRF serializers
- Always validate file uploads (type, size, content)
- Always use HTTPS in production (`SECURE_SSL_REDIRECT = True`)
- Always apply permission classes to all views
- Always rate-limit authentication endpoints

## SECRET_KEY Management
```python
# CORRECT: from environment
SECRET_KEY = env('SECRET_KEY')

# WRONG: hardcoded
SECRET_KEY = 'django-insecure-abc123...'
```

## ALLOWED_HOSTS
```python
# Production
ALLOWED_HOSTS = ['api.example.com', 'www.example.com']

# WRONG: accepts all
ALLOWED_HOSTS = ['*']
```

## CORS (django-cors-headers)
```python
# settings.py
INSTALLED_APPS = [..., 'corsheaders', ...]
MIDDLEWARE = [
    ...,
    'corsheaders.middleware.CorsMiddleware',  # must be before CommonMiddleware
    'django.middleware.common.CommonMiddleware',
    ...,
]

# Explicit allowed origins (preferred)
CORS_ALLOWED_ORIGINS = [
    'https://app.example.com',
]

# WRONG: allows everything
# CORS_ALLOW_ALL_ORIGINS = True  # only for development
```

## CSRF Protection
- **API with token/JWT auth (no cookies)**: CSRF not needed; DRF's `SessionAuthentication` enforces CSRF, others skip it
- **Session auth**: `CsrfViewMiddleware` required; DRF `SessionAuthentication` enforces CSRF automatically
- Never use `@csrf_exempt` on views unless justified and documented

## SQL Injection Prevention
```python
# CORRECT: ORM parameterized queries
User.objects.filter(email=user_email)
User.objects.raw('SELECT * FROM users WHERE email = %s', [user_email])

# WRONG: string interpolation
User.objects.raw(f"SELECT * FROM users WHERE email = '{user_email}'")
```

## XSS Prevention
- Django templates auto-escape by default (for rendered HTML views)
- API responses (JSON): inherently safe from XSS
- Never use `|safe` template filter on user input

## Clickjacking Protection
```python
# Enabled by default via XFrameOptionsMiddleware
X_FRAME_OPTIONS = 'DENY'  # or 'SAMEORIGIN'
```

## HTTPS Settings (production)
```python
SECURE_SSL_REDIRECT = True
SECURE_HSTS_SECONDS = 31536000          # 1 year
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
```

## Query Scoping
```python
# CORRECT: scoped to current user
request.user.resources.filter(is_active=True)
Resource.objects.filter(owner=request.user, id=pk)

# WRONG: unscoped -- may leak other users' data
Resource.objects.get(id=pk)
Resource.objects.all()
```
<!-- If multi-tenant, also scope to tenant: Tenant.objects.filter(tenant=request.tenant) -->

## Input Validation
- ALWAYS use DRF serializers for API input validation
- NEVER trust `request.data` directly for model creation
```python
# CORRECT: validated through serializer
serializer = ResourceSerializer(data=request.data)
serializer.is_valid(raise_exception=True)
serializer.save(owner=request.user)

# WRONG: direct from request data
Resource.objects.create(**request.data)
```

## Authentication (DRF)
- Every view must have `permission_classes` (at minimum `[IsAuthenticated]`)
- Public endpoints must explicitly use `[AllowAny]` and be documented in `architecture/api-design.md`
- Token/session expiration: [e.g. 5 min access + 7 day refresh / session timeout]

## Rate Limiting (DRF Throttling)
```python
REST_FRAMEWORK = {
    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle',
    ],
    'DEFAULT_THROTTLE_RATES': {
        'anon': '100/hour',
        'user': '1000/hour',
    },
}
```

## File Upload Validation
```python
# In serializer
def validate_file(self, value):
    max_size = 10 * 1024 * 1024  # 10 MB
    allowed_types = ['image/jpeg', 'image/png', 'application/pdf']
    if value.size > max_size:
        raise serializers.ValidationError("File too large (max 10 MB).")
    if value.content_type not in allowed_types:
        raise serializers.ValidationError("Unsupported file type.")
    return value
```

## Django Security Check
```bash
# Run Django's built-in security checker for production:
python manage.py check --deploy
```

## Changelog
<!-- [PROJ-123] Added rate limiting to authentication endpoints -->
