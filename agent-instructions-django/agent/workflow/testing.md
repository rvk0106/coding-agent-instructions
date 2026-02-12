# Testing
> Tags: test, verify, pytest, django, drf, flake8
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
pytest apps/app_name/tests/test_file.py       # tests for touched files
flake8 apps/app_name/                          # lint (or: ruff check apps/app_name/)
```

## Full Checks (when required)
```bash
pytest --cov=apps --cov-report=term-missing    # full suite with coverage
flake8 .                                        # full lint (or: ruff check .)
black --check .                                 # formatting check
isort --check-only .                            # import ordering check
python manage.py check                          # Django system checks
```

## API Changes (if endpoints added/modified)
```bash
# If using drf-spectacular:
python manage.py spectacular --validate         # validate schema
python manage.py spectacular --file schema.yml  # generate schema
```

## DB Changes (if migrations added)
```bash
python manage.py makemigrations --check --dry-run  # verify no missing migrations
python manage.py migrate                           # apply migrations
python manage.py migrate app_name zero             # verify rollback works
python manage.py migrate                           # re-apply
python manage.py showmigrations                    # verify status
```

## Django-Specific Test Patterns
```python
# Using DRF's APITestCase
from rest_framework.test import APITestCase, APIClient
from rest_framework import status

class ResourceAPITest(APITestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = UserFactory()
        self.client.force_authenticate(user=self.user)

    def test_list_resources(self):
        ResourceFactory.create_batch(3, owner=self.user)
        response = self.client.get('/api/v1/resources/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 3)

    def test_create_resource(self):
        data = {'name': 'Test Resource', 'status': 'active'}
        response = self.client.post('/api/v1/resources/', data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_unauthenticated_returns_401(self):
        self.client.force_authenticate(user=None)
        response = self.client.get('/api/v1/resources/')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
```

```python
# Using pytest-django with factory_boy
import pytest
from rest_framework.test import APIClient

@pytest.fixture
def api_client():
    return APIClient()

@pytest.fixture
def authenticated_client(api_client, user):
    api_client.force_authenticate(user=user)
    return api_client

@pytest.fixture
def user():
    return UserFactory()

def test_list_resources(authenticated_client, user):
    ResourceFactory.create_batch(3, owner=user)
    response = authenticated_client.get('/api/v1/resources/')
    assert response.status_code == 200
    assert len(response.data['results']) == 3
```

## CI Commands
```bash
pytest --cov=apps --cov-report=xml             # tests + coverage
flake8 .                                        # lint (or: ruff check .)
black --check .                                 # formatting
python manage.py check --deploy                 # production security checks
python manage.py makemigrations --check --dry-run  # missing migrations
```

## Reporting Format
```
Commands run:
- `pytest apps/.../test_file.py` -> PASS/FAIL
- `flake8 apps/...` -> PASS/FAIL (N violations)
If FAIL -> STOP and ask before continuing
```
