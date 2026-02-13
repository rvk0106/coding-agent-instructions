# Error Handling
> Tags: errors, flash, error-pages, exceptions, rescue, response
> Scope: How errors are caught, displayed to users, and logged
> Last updated: [TICKET-ID or date]

## Error Display Strategy
- **Form validation errors**: inline on form, re-render with `status: :unprocessable_entity`
- **Flash messages**: success/failure feedback after actions (`:notice`, `:alert`)
- **Error pages**: static or dynamic pages for 404, 422, 500
- **Turbo Stream errors**: use `flash.now` and render Turbo Stream replace

## HTTP Status Codes Used
| Scenario | Status | Controller Response |
|----------|:------:|---------------------|
| Page found, rendered | 200 | `render` (implicit) |
| Resource created, redirect | 302 | `redirect_to` |
| Form validation failed | 422 | `render :new/:edit, status: :unprocessable_entity` |
| Not found | 404 | `raise ActiveRecord::RecordNotFound` or error page |
| Unauthorized | 401 | Redirect to sign in (Devise) or custom |
| Forbidden | 403 | Custom error page or flash + redirect |
| Server error | 500 | Rails default error page |

## Flash Message Conventions
```ruby
# Success — redirect with notice
redirect_to resource_path(@resource), notice: "Resource updated successfully."

# Failure — render with flash.now (important for Turbo)
flash.now[:alert] = "Could not save resource."
render :edit, status: :unprocessable_entity

# Destroy
redirect_to resources_path, notice: "Resource deleted."
```

## Form Validation Pattern
```ruby
# Controller
def create
  @resource = Resource.new(resource_params)
  if @resource.save
    redirect_to @resource, notice: "Created."
  else
    render :new, status: :unprocessable_entity
  end
end
```
```erb
<%# View — display validation errors %>
<% if @resource.errors.any? %>
  <div id="error_explanation">
    <h2><%= pluralize(@resource.errors.count, "error") %> prohibited this from being saved:</h2>
    <ul>
      <% @resource.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
  </div>
<% end %>
```

## Exception -> Response Mapping
```ruby
# In ApplicationController (or rescue_from blocks):
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActionController::RoutingError, with: :not_found
# Authorization error (adapt to your library):
# rescue_from Pundit::NotAuthorizedError, with: :forbidden
# rescue_from CanCan::AccessDenied, with: :forbidden

private

def not_found
  respond_to do |format|
    format.html { render "errors/not_found", status: :not_found }
    format.any { head :not_found }
  end
end

def forbidden
  respond_to do |format|
    format.html { redirect_to root_path, alert: "You are not authorized to perform this action." }
    format.any { head :forbidden }
  end
end
```

## Error Pages
- Location: `public/404.html`, `public/422.html`, `public/500.html` (static)
- Or dynamic: `app/views/errors/not_found.html.erb` etc. with custom routes
- Custom error routes: [e.g. `config.exceptions_app = routes` in application.rb / default static]

## Service Error Pattern
```ruby
# Services return result objects, not raise exceptions:
result = MyService.call(params)
if result.success?
  redirect_to resource_path(result.data), notice: "Done."
else
  flash.now[:alert] = result.error
  render :new, status: :unprocessable_entity
end
```

## External Service Errors
- Wrap ALL external calls in begin/rescue
- Log the original error, show generic message to user
- Set timeouts: [e.g. 5s connect, 10s read]
- Retry: [e.g. 1 retry for transient errors]

## Turbo Error Handling
- CRITICAL: `render :action, status: :unprocessable_entity` — Turbo requires non-200 status to replace the form
- For Turbo Stream responses, errors can target specific DOM elements:
```ruby
respond_to do |format|
  format.turbo_stream do
    render turbo_stream: turbo_stream.replace("resource_form", partial: "form", locals: { resource: @resource })
  end
  format.html { render :new, status: :unprocessable_entity }
end
```

## Rules for Agents
- NEVER swallow exceptions silently
- ALWAYS use flash messages to inform users of action results
- ALWAYS use `status: :unprocessable_entity` when re-rendering forms (required for Turbo)
- Check the rescue_from chain in ApplicationController before adding new rescues

## Changelog
<!-- [PROJ-123] Added custom error handling for Stripe webhook failures -->
