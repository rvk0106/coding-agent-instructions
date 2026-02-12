# Error Handling
> Tags: errors, http-status, exceptions, controlleradvice, response
> Scope: How errors are caught, mapped to HTTP codes, and returned
> Last updated: [TICKET-ID or date]

## HTTP Status Code Map
| Scenario | Status | When to Use |
|----------|:------:|-------------|
| Success | 200 | GET, PUT/PATCH success |
| Created | 201 | POST success (resource created) |
| No Content | 204 | DELETE success |
| Bad Request | 400 | Malformed request body/params, missing required fields |
| Unauthorized | 401 | Missing or invalid auth token |
| Forbidden | 403 | Valid token, insufficient permissions |
| Not Found | 404 | Resource doesn't exist |
| Conflict | 409 | Duplicate / state conflict (e.g. email already taken) |
| Unprocessable Entity | 422 | Validation failure (business rule violation) |
| Too Many Requests | 429 | Rate limit exceeded |
| Server Error | 500 | Unhandled exception |
| Service Unavailable | 503 | Downstream service down / maintenance |

## Error Response Shape
Use the standard shape defined in `architecture/api-design.md`. All error responses must follow the project's chosen format consistently.

## Exception Hierarchy
```java
// Base application exception
public abstract class AppException extends RuntimeException {
    private final HttpStatus status;
    public AppException(String message, HttpStatus status) {
        super(message);
        this.status = status;
    }
}

// Concrete exceptions
public class ResourceNotFoundException extends AppException {
    public ResourceNotFoundException(String resource, Object id) {
        super(resource + " not found with id: " + id, HttpStatus.NOT_FOUND);
    }
}

public class ValidationException extends AppException {
    public ValidationException(String message) {
        super(message, HttpStatus.UNPROCESSABLE_ENTITY);
    }
}

public class UnauthorizedException extends AppException {
    public UnauthorizedException(String message) {
        super(message, HttpStatus.UNAUTHORIZED);
    }
}

public class ForbiddenException extends AppException {
    public ForbiddenException(String message) {
        super(message, HttpStatus.FORBIDDEN);
    }
}

public class ConflictException extends AppException {
    public ConflictException(String message) {
        super(message, HttpStatus.CONFLICT);
    }
}

public class BadRequestException extends AppException {
    public BadRequestException(String message) {
        super(message, HttpStatus.BAD_REQUEST);
    }
}
```

## Global Exception Handler (@ControllerAdvice)
```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    // Application-specific exceptions
    @ExceptionHandler(AppException.class)
    public ResponseEntity<ErrorResponse> handleAppException(AppException ex) {
        ErrorResponse error = new ErrorResponse(ex.getMessage(), ex.getStatus().value());
        return ResponseEntity.status(ex.getStatus()).body(error);
    }

    // Validation errors (from @Valid)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
        List<String> errors = ex.getBindingResult().getFieldErrors().stream()
            .map(e -> e.getField() + ": " + e.getDefaultMessage())
            .toList();
        ErrorResponse error = new ErrorResponse("Validation failed", 400, errors);
        return ResponseEntity.badRequest().body(error);
    }

    // Missing request params / path variables
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ResponseEntity<ErrorResponse> handleMissingParam(MissingServletRequestParameterException ex) {
        ErrorResponse error = new ErrorResponse(ex.getMessage(), 400);
        return ResponseEntity.badRequest().body(error);
    }

    // Spring Security access denied
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDenied(AccessDeniedException ex) {
        ErrorResponse error = new ErrorResponse("Access denied", 403);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(error);
    }

    // Catch-all for unexpected errors
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleUnexpected(Exception ex) {
        log.error("Unexpected error", ex);
        ErrorResponse error = new ErrorResponse("Internal server error", 500);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }
}
```

## Validation Error Pattern
```java
// In service -- throw app-specific exceptions, not raw exceptions
public UserResponse create(CreateUserRequest request) {
    if (userRepository.existsByEmail(request.getEmail())) {
        throw new ConflictException("Email already registered");
    }
    // ... create user
}
```

## External Service Errors
- Wrap ALL external HTTP calls in try/catch
- Log the original error, return generic message to client
- Set timeouts: connect timeout (5s), read timeout (10s)
- Retry: 1 retry for transient errors (5xx from external service)

```java
// Wrap external calls at the boundary
try {
    ExternalResponse result = externalClient.call(request);
    return mapToInternal(result);
} catch (RestClientException | HttpClientErrorException ex) {
    log.error("External service error: {}", ex.getMessage(), ex);
    throw new AppException("Service temporarily unavailable", HttpStatus.SERVICE_UNAVAILABLE);
}
```

## Rules for Agents
- NEVER return raw exception messages or stack traces to clients
- ALWAYS use the project's standard error response shape (see `api-design.md`)
- ALWAYS map exceptions to appropriate HTTP codes via `@ControllerAdvice`
- ALWAYS throw app-specific exceptions -- never throw generic `RuntimeException`
- ALWAYS wrap external service exceptions at the boundary
- Check the `GlobalExceptionHandler` before adding new exception handlers
- Include meaningful messages: `"User not found with id: 42"` not `"Not found"`

## Changelog
<!-- [PROJ-123] Added custom error handling for payment gateway failures -->
