# API Design
> Tags: api, endpoints, rest, drf, response, versioning, pagination
> Scope: DRF API conventions, endpoint patterns, response shapes
> Last updated: [TICKET-ID or date]

## Base URL
- Pattern: [e.g. `/api/v1/` or `/api/`]
- Admin: [e.g. `/api/v1/admin/`]
- Public: [e.g. `/api/v1/`]

## Versioning
- Strategy: [choose one]
  - **URL path**: `/api/v1/resources` -- DRF convention; simplest routing, easier debugging
  - **Header-based**: `Accept: application/vnd.myapp.v1+json` -- cleaner URLs, more complex routing
  - **Namespace versioning**: DRF's `NamespaceVersioning`
- **Recommendation:** URL path versioning is the DRF standard
- Current version: [e.g. v1]
- DRF setting:
  ```python
  REST_FRAMEWORK = {
      'DEFAULT_VERSIONING_CLASS': 'rest_framework.versioning.URLPathVersioning',
  }
  ```

## Response Shape
<!-- Define YOUR project's standard shape. Example options: -->
```python
# Option A: Wrapped response (explicit success flag)
# Success: {"success": true, "message": "...", "data": {}, "meta": {}}
# Error:   {"success": false, "message": "...", "errors": [], "meta": {}}

# Option B: Bare data (simpler, DRF default)
# Success: {"id": 1, "name": "..."} or {"results": [...], "count": N}
# Error:   {"detail": "Not found."} or {"field_name": ["error"]}

# Option C: JSON:API format (via djangorestframework-jsonapi)
# Success: {"data": {"type": "resources", "id": "1", "attributes": {}}}
```
**This project uses**: [describe your chosen shape here]

## Authentication
<!-- Choose your auth pattern -->
- **DRF TokenAuthentication**: `Authorization: Token <token>`
- **JWT (simplejwt)**: `Authorization: Bearer <access_token>`
- **SessionAuthentication**: cookie-based (CSRF required)
- **API key**: custom header `X-API-Key`
- **This project uses**: [describe your auth method]
- DRF setting:
  ```python
  REST_FRAMEWORK = {
      'DEFAULT_AUTHENTICATION_CLASSES': [
          # 'rest_framework.authentication.TokenAuthentication',
          # 'rest_framework_simplejwt.authentication.JWTAuthentication',
          # 'rest_framework.authentication.SessionAuthentication',
      ],
  }
  ```
- Unauthenticated: 401
- Unauthorized: 403

## Pagination
- Style: [choose one]
  - **PageNumberPagination**: `?page=1&page_size=25` -- meta: `count`, `next`, `previous`
  - **LimitOffsetPagination**: `?limit=25&offset=0`
  - **CursorPagination**: `?cursor=<encoded>` -- best for real-time feeds
- **This project uses**: [describe your pagination style]
- DRF setting:
  ```python
  REST_FRAMEWORK = {
      'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
      'PAGE_SIZE': 25,
  }
  ```

## Key Endpoints
<!-- List the main API groups -->
| Group | Base Path | Auth Required | ViewSet/View |
|-------|-----------|:------------:|--------------|
| Auth | [e.g. `/api/v1/auth/`] | No | [e.g. AuthViewSet] |
| Users | [e.g. `/api/v1/users/`] | Yes | [e.g. UserViewSet] |
| Admin | [e.g. `/api/v1/admin/`] | Yes (admin) | [e.g. AdminUserViewSet] |
| [group] | [path] | [yes/no] | [view class] |

## URL Routing
```python
# apps/app_name/urls.py
from rest_framework.routers import DefaultRouter
from .views import ResourceViewSet

router = DefaultRouter()
router.register(r'resources', ResourceViewSet, basename='resource')

urlpatterns = router.urls

# project/urls.py
urlpatterns = [
    path('api/v1/', include('apps.app_name.urls')),
]
```

## Naming Conventions
- Resources: plural (`/users`, `/orders`)
- Actions: RESTful (list, retrieve, create, update, partial_update, destroy)
- Custom actions: `@action(detail=True)` or `@action(detail=False)` with verb prefix
- Nested max depth: 2 levels (`/accounts/{id}/users/`)
- URL names: kebab-case or snake_case (consistent with project)

## API Documentation
- Tool: [e.g. drf-spectacular / drf-yasg / none]
- Generate schema: [e.g. `python manage.py spectacular --file schema.yml`]
- Serve docs: [e.g. `/api/docs/` (Swagger UI) / `/api/redoc/` (ReDoc)]
- DRF setting:
  ```python
  REST_FRAMEWORK = {
      'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
  }
  ```

## Changelog
<!-- [PROJ-123] Added product catalog API endpoints -->
