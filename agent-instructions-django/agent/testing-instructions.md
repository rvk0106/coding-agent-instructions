# Testing Instructions — Django

## Source: `docs/TICKET-ID-plan.md` verification commands

## Fast checks
- Unit tests: `python manage.py test app_name`
- Specific test: `python manage.py test app_name.tests.TestClass`
- Lint: `flake8 app_name/`

## Full checks
- All tests: `python manage.py test`
- Coverage: `coverage run --source='.' manage.py test && coverage report`
- Type checking: `mypy .`

## Django-specific
- Check migrations: `python manage.py makemigrations --check --dry-run`
- Run server: `python manage.py runserver`
- Test endpoints with curl or Postman

## Report: List commands, pass/fail, stop if failures
