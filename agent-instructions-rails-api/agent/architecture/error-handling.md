# Error Handling
> Tags: errors, http-status, exceptions, rescue, response
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
| Unprocessable | 422 | Validation failure (model errors) |
| Conflict | 409 | Duplicate / state conflict |
| Too Many Requests | 429 | Rate limit exceeded |
| Server Error | 500 | Unhandled exception |
| Service Unavailable | 503 | Downstream service down / maintenance |

## Error Response Shape
Use the standard shape defined in `architecture/api-design.md`. All error responses must follow the project's chosen format consistently.

## Exception → HTTP Mapping
```ruby
# In base API controller (or rescue_from blocks):
rescue_from ActiveRecord::RecordNotFound,    with: :not_found        # → 404
rescue_from ActiveRecord::RecordInvalid,     with: :unprocessable    # → 422
rescue_from ActionController::ParameterMissing, with: :bad_request   # → 400
# Authorization error (adapt to your library):
# rescue_from Pundit::NotAuthorizedError,  with: :forbidden        # → 403 (Pundit)
# rescue_from CanCan::AccessDenied,        with: :forbidden        # → 403 (CanCanCan)
# [Add project-specific rescues here]
```

## Validation Error Pattern
```ruby
# In controller (adapt response shape to match api-design.md):
if record.save
  render json: success_response(record), status: :created
else
  render json: error_response("Validation failed", record.errors), status: :unprocessable_entity
end
```

## Service Error Pattern
```ruby
# Services return result objects, not raise exceptions:
result = MyService.call(params)
if result.success?
  render json: success_response(result.data)
else
  render json: error_response(result.error), status: result.status
end
```

## External Service Errors
- Wrap ALL external calls in begin/rescue
- Log the original error, return generic message to client
- Set timeouts: [e.g. 5s connect, 10s read]
- Retry: [e.g. 1 retry for transient errors]

```ruby
# Timeout errors to rescue:
rescue Net::OpenTimeout, Net::ReadTimeout, Timeout::Error => e
  Rails.logger.error("External service timeout: #{e.class} — #{e.message}")
  # Return 503 or 504 depending on context
  render json: error_response("Service temporarily unavailable"), status: :service_unavailable
end
```

## Rules for Agents
- NEVER return raw exception messages to clients
- ALWAYS use the project's standard response shape (see `api-design.md`)
- ALWAYS map exceptions to appropriate HTTP codes
- Check the rescue_from chain in base controller before adding new rescues

## Changelog
<!-- [PROJ-123] Added custom error handling for Stripe webhook failures -->
