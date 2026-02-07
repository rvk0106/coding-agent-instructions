# Planner Instructions — Django

> When user says: "plan architecture for TICKET-ID"

## Analyze existing Django patterns
- Review `models.py` for data model patterns
- Check `views.py` or `viewsets.py` for API patterns
- Examine `serializers.py` for DRF serialization
- Review `urls.py` for routing patterns
- Check `permissions.py` for authorization patterns
- Review `tests/` for test structure
- Examine `settings.py` for configuration
- Check `requirements.txt` or `Pipfile` for dependencies

## Django danger zones
- Custom user models
- Database migrations (never edit existing)
- Security settings (SECRET_KEY, ALLOWED_HOSTS)
- CORS, CSRF configurations
- Celery/async task definitions

## Phase guidelines
- Keep views/viewsets thin
- Business logic in services or model methods
- Use Django ORM efficiently (avoid N+1)
- Serializers for request/response validation
- Permissions for authorization
- Migrations for schema changes

## Verification commands
- Tests: `python manage.py test`
- Specific app: `python manage.py test app_name`
- Migrations: `python manage.py makemigrations --dry-run`
- Lint: `flake8` or `pylint`
- Run: `python manage.py runserver`

## Save to: `docs/TICKET-ID-plan.md`
