# Implementer Instructions — Django

> Read `docs/TICKET-ID-plan.md` before implementing.

## Django conventions
- **Views/ViewSets**: Thin, handle HTTP concerns only
- **Serializers**: Validation and serialization (DRF)
- **Models**: Data definitions, simple business logic
- **Services**: Complex business logic (in `services.py`)
- **Permissions**: Authorization logic
- Use Django ORM methods: `select_related()`, `prefetch_related()`

## File structure
- Models: `app_name/models.py`
- Views: `app_name/views.py` or `viewsets.py`
- Serializers: `app_name/serializers.py`
- URLs: `app_name/urls.py`
- Tests: `app_name/tests/`
- Permissions: `app_name/permissions.py`

## API conventions (Django REST Framework)
- Use proper HTTP methods and status codes
- Serializer validation with `validate_*()`
- Permission classes for authorization
- ViewSets for CRUD operations

## Quality rules
- Add tests for new functionality
- Use DRF serializer validation
- Apply permission classes
- Create migrations: `python manage.py makemigrations`
- Never edit existing migration files

## Post-implementation
1) Run tests: `python manage.py test`
2) Check migrations: `python manage.py makemigrations --check`
3) Run lint: `flake8`
4) Document API endpoints in `docs/frontend-integration.md`
