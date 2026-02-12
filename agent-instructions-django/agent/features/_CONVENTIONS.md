# Feature Implementation Conventions
> Tags: conventions, serialization, queries, testing, patterns, django
> Scope: Patterns to follow when implementing any feature
> Last updated: [TICKET-ID or date]

## Serialization (DRF)
- Library: Django REST Framework `ModelSerializer` / `Serializer`
- Naming: [e.g. snake_case keys (default) / camelCase via djangorestframework-camel-case]
- Timestamps: ISO-8601 (DRF default)
- Nulls: [e.g. include as null / omit]
- Nested depth max: [e.g. 2 levels -- don't nest deeper, use IDs]

### Example Serializer
```python
# apps/app_name/serializers.py
from rest_framework import serializers
from .models import Resource

class ResourceSerializer(serializers.ModelSerializer):
    owner = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = Resource
        fields = ['id', 'name', 'description', 'status', 'owner', 'created_at']
        read_only_fields = ['id', 'owner', 'created_at']

    def validate_name(self, value):
        if len(value.strip()) < 3:
            raise serializers.ValidationError("Name must be at least 3 characters.")
        return value.strip()
```

## Query Patterns
```python
# Eager loading -- prevent N+1
Resource.objects.select_related('owner', 'category').filter(is_active=True)

# When to use each:
# select_related  -> ForeignKey / OneToOneField (SQL JOIN, single query)
# prefetch_related -> ManyToManyField / reverse ForeignKey (separate query, Python-side join)

# Pagination (DRF handles via DEFAULT_PAGINATION_CLASS)
# Custom: Resource.objects.all()[:25]

# Scoping -- always scope to current user
def get_queryset(self):
    return Resource.objects.filter(owner=self.request.user)
# If multi-tenant: Resource.objects.filter(tenant=self.request.tenant)

# Filtering (django-filter)
class ResourceFilter(django_filters.FilterSet):
    class Meta:
        model = Resource
        fields = ['status', 'category', 'created_at']
```

## Test Data (factory_boy)
```python
# Factory location: apps/app_name/tests/factories.py (or conftest.py)
import factory
from apps.app_name.models import Resource
from apps.users.tests.factories import UserFactory

class ResourceFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Resource

    name = factory.Sequence(lambda n: f"Resource {n}")
    description = factory.Faker('sentence')
    status = 'active'
    owner = factory.SubFactory(UserFactory)

# Usage:
# Build (in memory, no DB hit -- use for unit tests)
resource = ResourceFactory.build()

# Create (persists to DB -- use for integration tests)
resource = ResourceFactory.create(name="Test Resource")

# Batch
resources = ResourceFactory.create_batch(5, owner=user)

# Traits
class ResourceFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Resource

    class Params:
        archived = factory.Trait(
            status='archived',
            archived_at=factory.LazyFunction(timezone.now),
        )

# ResourceFactory(archived=True)
```

## API Test Pattern (APITestCase)
```python
# apps/app_name/tests/test_views.py
from rest_framework.test import APITestCase, APIClient
from rest_framework import status
from apps.users.tests.factories import UserFactory
from .factories import ResourceFactory

class ResourceAPITest(APITestCase):
    def setUp(self):
        self.user = UserFactory()
        self.client = APIClient()
        self.client.force_authenticate(user=self.user)

    def test_list_resources(self):
        ResourceFactory.create_batch(3, owner=self.user)
        response = self.client.get('/api/v1/resources/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 3)

    def test_create_resource(self):
        data = {'name': 'New Resource', 'description': 'A test resource'}
        response = self.client.post('/api/v1/resources/', data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Resource.objects.count(), 1)

    def test_create_invalid_returns_400(self):
        data = {'name': ''}  # fails validation
        response = self.client.post('/api/v1/resources/', data)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_unauthenticated_returns_401(self):
        self.client.force_authenticate(user=None)
        response = self.client.get('/api/v1/resources/')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_other_user_resource_not_visible(self):
        other_user = UserFactory()
        ResourceFactory(owner=other_user)
        response = self.client.get('/api/v1/resources/')
        self.assertEqual(len(response.data['results']), 0)
```

## pytest-django Pattern
```python
# conftest.py or apps/app_name/tests/conftest.py
import pytest
from rest_framework.test import APIClient
from apps.users.tests.factories import UserFactory

@pytest.fixture
def api_client():
    return APIClient()

@pytest.fixture
def user():
    return UserFactory()

@pytest.fixture
def authenticated_client(api_client, user):
    api_client.force_authenticate(user=user)
    return api_client

# apps/app_name/tests/test_views.py
import pytest
from .factories import ResourceFactory

@pytest.mark.django_db
def test_list_resources(authenticated_client, user):
    ResourceFactory.create_batch(3, owner=user)
    response = authenticated_client.get('/api/v1/resources/')
    assert response.status_code == 200
    assert len(response.data['results']) == 3
```

## Serializer Test Pattern
```python
# apps/app_name/tests/test_serializers.py
from apps.app_name.serializers import ResourceSerializer
from .factories import ResourceFactory

class TestResourceSerializer:
    def test_valid_data(self):
        data = {'name': 'Valid Resource', 'description': 'A test'}
        serializer = ResourceSerializer(data=data)
        assert serializer.is_valid(), serializer.errors

    def test_name_too_short(self):
        data = {'name': 'ab', 'description': 'A test'}
        serializer = ResourceSerializer(data=data)
        assert not serializer.is_valid()
        assert 'name' in serializer.errors

    def test_serialization_output(self, db):
        resource = ResourceFactory()
        serializer = ResourceSerializer(resource)
        assert 'id' in serializer.data
        assert serializer.data['name'] == resource.name
```

## Model Test Pattern
```python
# apps/app_name/tests/test_models.py
import pytest
from django.db import IntegrityError
from .factories import ResourceFactory

@pytest.mark.django_db
class TestResourceModel:
    def test_create(self):
        resource = ResourceFactory()
        assert resource.pk is not None

    def test_str(self):
        resource = ResourceFactory(name="Test")
        assert str(resource) == "Test"

    def test_unique_constraint(self):
        ResourceFactory(name="Unique")
        with pytest.raises(IntegrityError):
            ResourceFactory(name="Unique")

    def test_archive(self):
        resource = ResourceFactory(status='active')
        resource.archive()
        resource.refresh_from_db()
        assert resource.status == 'archived'
```

## Helper Methods
```python
# conftest.py or apps/common/test_helpers.py
def auth_headers_for(user):
    """Generate auth headers for API tests. Adapt to your auth method."""
    # JWT example:
    # from rest_framework_simplejwt.tokens import RefreshToken
    # refresh = RefreshToken.for_user(user)
    # return {"HTTP_AUTHORIZATION": f"Bearer {refresh.access_token}"}

    # Token example:
    # from rest_framework.authtoken.models import Token
    # token, _ = Token.objects.get_or_create(user=user)
    # return {"HTTP_AUTHORIZATION": f"Token {token.key}"}

    # Or use client.force_authenticate(user=user) -- simplest for tests
    pass
```

## Changelog
<!-- Update when conventions change -->
