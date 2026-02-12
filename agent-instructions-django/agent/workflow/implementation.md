# Implementation
> Tags: code, conventions, django, drf, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain -> STOP and ask

## Django Conventions
- **Views/ViewSets**: thin, handle HTTP concerns only; delegate to serializers and models
- **Models**: schema, relationships, simple business logic, custom managers
- **Serializers**: validation (`validate_*`, `validate()`), serialization/deserialization
- **Permissions**: `apps/app_name/permissions.py` for authorization logic
- **Services**: `apps/app_name/services.py` for complex multi-step operations (optional)
- **Signals**: `apps/app_name/signals.py` for decoupled side effects
- **Tasks**: `apps/app_name/tasks.py` for Celery background tasks
- **Migrations**: only with explicit approval; never edit existing migration files

## File Locations
```
apps/{app_name}/
├── models.py             -> ORM models, managers, abstract models
├── views.py              -> DRF views / viewsets (thin)
├── serializers.py        -> DRF serializers (validation + serialization)
├── urls.py               -> URL patterns / router registration
├── permissions.py        -> DRF permission classes
├── filters.py            -> django-filter FilterSets
├── signals.py            -> signal handlers (register in apps.py)
├── services.py           -> service layer (optional)
├── tasks.py              -> Celery tasks (if used)
├── admin.py              -> Django admin configuration
├── apps.py               -> AppConfig
└── tests/
    ├── test_models.py    -> model tests
    ├── test_views.py     -> API endpoint tests (APITestCase)
    ├── test_serializers.py -> serializer validation tests
    └── test_permissions.py -> permission tests

project/
├── settings/             -> settings (base, dev, prod)
├── urls.py               -> root URL configuration
└── wsgi.py / asgi.py     -> entry points
```

## ORM Best Practices
```python
# ALWAYS use select_related for ForeignKey / OneToOneField
Resource.objects.select_related('owner', 'category').filter(is_active=True)

# ALWAYS use prefetch_related for ManyToManyField / reverse ForeignKey
User.objects.prefetch_related('resources', 'groups').all()

# NEVER do queries in loops (N+1 problem)
# WRONG:
for resource in resources:
    print(resource.owner.name)  # hits DB each iteration

# CORRECT:
resources = Resource.objects.select_related('owner').all()
for resource in resources:
    print(resource.owner.name)  # no extra queries
```

## API Response Shape
See `architecture/api-design.md` for the project's standard response shapes. All endpoints must use them consistently.

## Serializer Patterns
```python
# Read vs write serializer (when shapes differ)
class ResourceListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Resource
        fields = ['id', 'name', 'status']

class ResourceDetailSerializer(serializers.ModelSerializer):
    owner = UserSerializer(read_only=True)
    class Meta:
        model = Resource
        fields = ['id', 'name', 'status', 'description', 'owner', 'created_at']

# ViewSet using different serializers
class ResourceViewSet(ModelViewSet):
    def get_serializer_class(self):
        if self.action == 'list':
            return ResourceListSerializer
        return ResourceDetailSerializer
```

## URL Routing
```python
# apps/app_name/urls.py
from rest_framework.routers import DefaultRouter
from .views import ResourceViewSet

router = DefaultRouter()
router.register(r'resources', ResourceViewSet, basename='resource')
urlpatterns = router.urls

# project/urls.py
from django.urls import path, include
urlpatterns = [
    path('api/v1/', include('apps.app_name.urls')),
]
```

## Danger Zones
- Auth changes -> ask first
- Raw SQL / `extra()` / `raw()` -> justify and parameterize
- Data scoping bypass (accessing other users' data) -> ask first
- Skipping serializer validation -> never
- Editing existing migration files -> never
