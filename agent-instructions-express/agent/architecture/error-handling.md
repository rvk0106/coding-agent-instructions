# Error Handling
> Tags: errors, http-status, middleware, error-classes, response
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
| Conflict | 409 | Duplicate / state conflict |
| Unprocessable | 422 | Validation failure (model errors) |
| Too Many Requests | 429 | Rate limit exceeded |
| Server Error | 500 | Unhandled exception |
| Service Unavailable | 503 | Downstream service down / maintenance |

## Custom AppError Class
```javascript
class AppError extends Error {
  constructor(message, statusCode, errors = []) {
    super(message);
    this.statusCode = statusCode;
    this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
    this.isOperational = true;
    this.errors = errors;
    Error.captureStackTrace(this, this.constructor);
  }
}
```

## Error Subclasses
```javascript
class NotFoundError extends AppError {
  constructor(resource = 'Resource') {
    super(`${resource} not found`, 404);
  }
}

class ValidationError extends AppError {
  constructor(errors = []) {
    super('Validation failed', 422, errors);
  }
}

class UnauthorizedError extends AppError {
  constructor(message = 'Authentication required') {
    super(message, 401);
  }
}

class ForbiddenError extends AppError {
  constructor(message = 'Insufficient permissions') {
    super(message, 403);
  }
}

class ConflictError extends AppError {
  constructor(message = 'Resource already exists') {
    super(message, 409);
  }
}
```

## Global Error Handler Middleware
```javascript
// src/middleware/errorHandler.js
// MUST be registered LAST in the middleware chain (after all routes)
const errorHandler = (err, req, res, next) => {
  err.statusCode = err.statusCode || 500;
  err.status = err.status || 'error';

  if (process.env.NODE_ENV === 'production') {
    // Production: no stack traces, generic message for 500s
    res.status(err.statusCode).json({
      success: false,
      message: err.isOperational ? err.message : 'Internal server error',
      errors: err.errors || [],
    });
  } else {
    // Development: include stack trace
    res.status(err.statusCode).json({
      success: false,
      message: err.message,
      errors: err.errors || [],
      stack: err.stack,
    });
  }
};
```

## Async Error Wrapper
```javascript
// Option A: Use express-async-errors (recommended -- zero boilerplate)
require('express-async-errors');
// Then just throw inside async handlers -- Express catches it automatically

// Option B: Manual wrapper function
const catchAsync = (fn) => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

// Usage:
router.get('/users/:id', catchAsync(async (req, res) => {
  const user = await userService.findById(req.params.id);
  if (!user) throw new NotFoundError('User');
  res.json({ success: true, data: user });
}));
```

## Error Response Shape
All errors MUST follow the project's standard shape (see `api-design.md`):
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": [
    { "field": "email", "message": "Email is required" },
    { "field": "password", "message": "Password must be at least 8 characters" }
  ]
}
```

## Validation Error Pattern
```javascript
// Using joi
const validate = (schema) => (req, res, next) => {
  const { error } = schema.validate(req.body, { abortEarly: false });
  if (error) {
    const errors = error.details.map(d => ({
      field: d.path.join('.'),
      message: d.message,
    }));
    throw new ValidationError(errors);
  }
  next();
};

// Using zod
const validate = (schema) => (req, res, next) => {
  const result = schema.safeParse(req.body);
  if (!result.success) {
    const errors = result.error.issues.map(i => ({
      field: i.path.join('.'),
      message: i.message,
    }));
    throw new ValidationError(errors);
  }
  req.body = result.data;
  next();
};
```

## External Service Errors
- Wrap ALL external calls in try-catch
- Log the original error, return generic message to client
- Set timeouts (e.g. 5s connect, 10s read via axios timeout)
- Retry transient errors (1 retry max)

```javascript
try {
  const result = await axios.get(externalUrl, { timeout: 5000 });
  return result.data;
} catch (error) {
  logger.error('External service error:', { url: externalUrl, error: error.message });
  throw new AppError('Service temporarily unavailable', 503);
}
```

## Rules for Agents
- NEVER send raw error stacks to clients in production
- ALWAYS use `next(error)` to pass errors to the global error handler
- ALWAYS use the project's standard response shape (see `api-design.md`)
- ALWAYS map errors to appropriate HTTP status codes
- ALWAYS use AppError or subclasses for operational errors
- Check the error handler middleware before adding custom error handling

## Changelog
<!-- [PROJ-123] Added custom error handling for Stripe webhook failures -->
