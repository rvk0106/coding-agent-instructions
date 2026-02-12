# Error Handling
> Tags: errors, http-status, exceptions, drf, response
> Scope: How errors are caught, mapped to HTTP codes, and returned
> Last updated: [TICKET-ID or date]

## HTTP Status Code Map
| Scenario | Status | When to Use |
|----------|:------:|-------------|
| Success | 200 | GET, PUT/PATCH success |
| Created | 201 | POST success |
| No Content | 204 | DELETE success |
| Bad Request | 400 | Malformed request body/params |
| Unauthorized | 401 | Missing or invalid auth token |
| Forbidden | 403 | Valid token, insufficient permissions |
| Not Found | 404 | Resource doesn't exist |
| Method Not Allowed | 405 | Wrong HTTP method |
| Unprocessable | 422 | Validation failure (serializer errors) |
| Conflict | 409 | Duplicate / state conflict |
| Too Many Requests | 429 | Rate limit exceeded (DRF throttling) |
| Server Error | 500 | Unhandled exception |
| Service Unavailable | 503 | Downstream service down / maintenance |

## Error Response Shape
Use the standard shape defined in `architecture/api-design.md`. All error responses must follow the project's chosen format consistently.

## DRF Exception Classes
```python
from rest_framework.exceptions import (
    ValidationError,          # → 400
    AuthenticationFailed,     # → 401
    NotAuthenticated,         # → 401
    PermissionDenied,         # → 403
    NotFound,                 # → 404
    MethodNotAllowed,         # → 405
    Throttled,                # → 429
    APIException,             # → 500 (base class)
)
```

## Custom Exception Handler
```python
# project/exception_handler.py
from rest_framework.views import exception_handler
from rest_framework.response import Response
from rest_framework import status

def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)

    if response is not None:
        response.data = {
            'success': False,
            'message': str(exc.detail) if hasattr(exc, 'detail') else str(exc),
            'errors': response.data if isinstance(response.data, (list, dict)) else [response.data],
            'status_code': response.status_code,
        }

    return response

# settings.py
REST_FRAMEWORK = {
    'EXCEPTION_HANDLER': 'project.exception_handler.custom_exception_handler',
}
```

## Serializer Validation Errors
```python
# DRF returns field-level errors automatically:
# {"name": ["This field is required."], "email": ["Enter a valid email."]}

# Custom validation in serializer:
class ResourceSerializer(serializers.ModelSerializer):
    def validate_name(self, value):
        if Resource.objects.filter(name=value).exists():
            raise serializers.ValidationError("Resource with this name already exists.")
        return value

    def validate(self, attrs):
        if attrs.get('end_date') and attrs['end_date'] < attrs.get('start_date', attrs['end_date']):
            raise serializers.ValidationError({"end_date": "End date must be after start date."})
        return attrs
```

## View-Level Error Handling
```python
# Using @api_view
@api_view(['POST'])
def create_resource(request):
    serializer = ResourceSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)  # auto-returns 400 on failure
    serializer.save()
    return Response(serializer.data, status=status.HTTP_201_CREATED)

# Using ViewSet -- DRF handles errors via exception handler
class ResourceViewSet(ModelViewSet):
    # DRF automatically catches:
    # - Serializer validation → 400
    # - DoesNotExist → 404
    # - PermissionDenied → 403
    pass
```

## Django Model-Level Errors
```python
# Catching IntegrityError (unique constraint violations)
from django.db import IntegrityError
from rest_framework.exceptions import ValidationError

try:
    resource.save()
except IntegrityError as e:
    raise ValidationError({"detail": "Resource already exists."})
```

## External Service Errors
- Wrap ALL external calls in try/except
- Log the original error, return generic message to client
- Set timeouts on all HTTP calls

```python
import requests
from rest_framework.exceptions import APIException

class ServiceUnavailable(APIException):
    status_code = 503
    default_detail = 'Service temporarily unavailable.'

try:
    response = requests.get(url, timeout=(5, 10))
    response.raise_for_status()
except requests.exceptions.Timeout:
    logger.error(f"External service timeout: {url}")
    raise ServiceUnavailable()
except requests.exceptions.RequestException as e:
    logger.error(f"External service error: {e}")
    raise ServiceUnavailable()
```

## Rules for Agents
- NEVER return raw exception messages or tracebacks to clients
- ALWAYS use DRF exception classes (not plain Django Http404, etc. in API views)
- ALWAYS use the project's custom exception handler for consistent response shapes
- ALWAYS map exceptions to appropriate HTTP codes
- Check the custom exception handler before adding new exception classes

## Changelog
<!-- [PROJ-123] Added custom exception handler for consistent API error responses -->
