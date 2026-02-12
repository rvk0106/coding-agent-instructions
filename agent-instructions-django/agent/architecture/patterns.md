# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality, django
> Scope: Coding patterns and quality standards for this project
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first → execute in small phases → verify → human review
- No scope creep, no unrelated refactors

## Django Patterns Used

### Views / ViewSets
- **Fat models, thin views**: Views handle HTTP concerns only; business logic goes in models, managers, or services
- Use DRF `ModelViewSet` for standard CRUD
- Use `APIView` or `generics.*` for custom endpoints
- Keep views under 100 lines
- Always apply `permission_classes`
- Always use serializers for request/response

```python
# CORRECT: thin view, delegates to serializer and model
class ResourceViewSet(ModelViewSet):
    queryset = Resource.objects.all()
    serializer_class = ResourceSerializer
    permission_classes = [IsAuthenticated, ResourcePermission]
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_fields = ['status', 'category']
    ordering_fields = ['created_at', 'name']

# WRONG: business logic in view
class ResourceViewSet(ModelViewSet):
    def create(self, request):
        # Don't put complex logic here -- use serializer or model
        if request.data['price'] > 100:
            send_notification(...)  # belongs in model/signal/service
```

### Models
- Define schema, relationships, and simple business logic
- Use custom managers for reusable query logic
- Use model methods for single-object business logic
- Use `Meta` class for ordering, indexes, constraints, verbose names
- Extract shared behavior into abstract models or mixins

```python
# Abstract base model for common fields
class TimestampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

class Resource(TimestampedModel):
    name = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)

    class Meta:
        ordering = ['-created_at']

    def archive(self):
        self.is_active = False
        self.save(update_fields=['is_active', 'updated_at'])
```

### Serializers
- **Validation**: Use `validate_<field>()` for field-level, `validate()` for cross-field
- **Nested serializers**: Read-only nesting for display; use PrimaryKeyRelatedField for writes
- Keep serializers focused: separate read vs. write serializers if shapes differ significantly

```python
class ResourceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Resource
        fields = ['id', 'name', 'status', 'category', 'created_at']
        read_only_fields = ['id', 'created_at']

    def validate_name(self, value):
        if len(value) < 3:
            raise serializers.ValidationError("Name must be at least 3 characters.")
        return value

    def validate(self, attrs):
        # Cross-field validation
        if attrs.get('status') == 'published' and not attrs.get('category'):
            raise serializers.ValidationError("Published resources must have a category.")
        return attrs
```

### Permission Classes
- Use DRF permission classes for authorization
- One permission class per concern (IsOwner, IsAdmin, etc.)
- Apply at view level or per-action with `get_permissions()`

```python
# apps/app_name/permissions.py
from rest_framework.permissions import BasePermission

class IsOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.owner == request.user
```

### Signals
<!-- DELETE this section if not using signals -->
- Location: `apps/app_name/signals.py`
- Register in `apps/app_name/apps.py` via `ready()`
- Use for decoupled side effects (notifications, cache invalidation)
- Do NOT use for core business logic -- makes debugging harder

```python
# apps/app_name/signals.py
from django.db.models.signals import post_save
from django.dispatch import receiver

@receiver(post_save, sender=Resource)
def resource_created(sender, instance, created, **kwargs):
    if created:
        notify_admins(instance)

# apps/app_name/apps.py
class AppNameConfig(AppConfig):
    def ready(self):
        import apps.app_name.signals  # noqa: F401
```

### Services (optional)
<!-- DELETE this section if not using service objects -->
- Location: `apps/app_name/services.py`
- Use for complex multi-step operations or external API calls
- One public method per service
- Naming: `verb_noun` function or `VerbNounService` class

## Package Structure
```
apps/{app_name}/
├── __init__.py
├── admin.py              → Django admin configuration
├── apps.py               → AppConfig (register signals here)
├── models.py             → ORM models, managers, abstract models
├── views.py              → DRF views / viewsets
├── serializers.py        → DRF serializers
├── urls.py               → URL patterns / router
├── permissions.py        → DRF permission classes
├── filters.py            → django-filter FilterSets
├── signals.py            → signal handlers
├── services.py           → service layer (optional)
├── tasks.py              → Celery tasks (if using Celery)
└── tests/
    ├── __init__.py
    ├── test_models.py
    ├── test_views.py
    ├── test_serializers.py
    └── test_permissions.py
```

## Naming Conventions
- **Classes**: PascalCase (`ResourceViewSet`, `ResourceSerializer`, `IsOwner`)
- **Functions/methods**: snake_case (`get_queryset`, `validate_name`)
- **Variables**: snake_case (`resource_count`, `is_active`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_PAGE_SIZE`, `DEFAULT_STATUS`)
- **URLs**: kebab-case or snake_case (consistent with project)
- **Apps**: short, lowercase, no underscores when possible (`users`, `orders`, `catalog`)
- **Test methods**: `test_<what_it_tests>` (`test_create_resource_with_valid_data`)

## Quality Checklist
- [ ] Serializer validation for all inputs
- [ ] Permission classes on all views
- [ ] Tests for all new code (views, models, serializers)
- [ ] Migrations generated and tested
- [ ] No N+1 queries (use `select_related` / `prefetch_related`)
- [ ] Linting passes (`flake8` / `ruff`)
- [ ] API docs updated (if using drf-spectacular)
- [ ] Error handling with consistent response format

## Changelog
<!-- [PROJ-123] Adopted service layer pattern for payment processing -->
