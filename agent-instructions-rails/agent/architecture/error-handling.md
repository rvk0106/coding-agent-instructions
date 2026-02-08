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
| Server Error | 500 | Unhandled exception |

## Error Response Shape
```ruby
# All errors must use this shape:
{
  success: false,
  message: "Human-readable summary",
  errors: [
    { field: "email", message: "has already been taken" }
  ],
  meta: {}
}
```

## Exception → HTTP Mapping
```ruby
# In base API controller (or rescue_from blocks):
rescue_from ActiveRecord::RecordNotFound,    with: :not_found        # → 404
rescue_from ActiveRecord::RecordInvalid,     with: :unprocessable    # → 422
rescue_from ActionController::ParameterMissing, with: :bad_request   # → 400
rescue_from Pundit::NotAuthorizedError,      with: :forbidden        # → 403
# [Add project-specific rescues here]
```

## Validation Error Pattern
```ruby
# In controller:
if record.save
  render json: { success: true, data: record }, status: :created
else
  render json: {
    success: false,
    message: "Validation failed",
    errors: record.errors.map { |e| { field: e.attribute, message: e.message } }
  }, status: :unprocessable_entity
end
```

## Service Error Pattern
```ruby
# Services return result objects, not raise exceptions:
result = MyService.call(params)
if result.success?
  render json: { success: true, data: result.data }
else
  render json: { success: false, message: result.error }, status: result.status
end
```

## External Service Errors
- Wrap ALL external calls in begin/rescue
- Log the original error, return generic message to client
- Set timeouts: [e.g. 5s connect, 10s read]
- Retry: [e.g. 1 retry for transient errors]

## Rules for Agents
- NEVER return raw exception messages to clients
- ALWAYS use the standard error response shape
- ALWAYS map exceptions to appropriate HTTP codes
- Check the rescue_from chain in base controller before adding new rescues

## Changelog
<!-- [PROJ-123] Added custom error handling for Stripe webhook failures -->
