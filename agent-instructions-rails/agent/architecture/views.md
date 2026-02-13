# Views & Frontend Architecture
> Tags: views, layouts, partials, helpers, turbo, stimulus, hotwire
> Scope: How the view layer is structured — templates, components, frontend interactivity
> Last updated: [TICKET-ID or date]

## Template Engine
- Engine: [e.g. ERB / Haml / Slim]
- Location: `app/views/`

## Layout Structure
<!-- Describe your layout hierarchy -->
```
app/views/layouts/
├── application.html.erb       # Default layout (navbar, flash, yield, footer)
├── [admin.html.erb]           # Admin layout (if different)
├── [mailer.html.erb]          # Email layout
└── [devise.html.erb]          # Auth pages layout (if customized)
```
- Default layout: `application`
- Layout switching: [e.g. `layout "admin"` in AdminController / conditional in ApplicationController]

## Partial Conventions
- Naming: `_partial_name.html.erb` (underscore prefix)
- Location: same directory as parent view, or `app/views/shared/` for reusable partials
- Collection rendering: `render collection: @items, partial: "item"`
- Locals: always pass explicit locals, avoid instance variables in partials
```ruby
# CORRECT: explicit locals
render partial: "form", locals: { resource: @resource }

# WRONG: relying on instance variables inside partials
render partial: "form"  # partial uses @resource directly
```

## View Helpers
- Location: `app/helpers/`
- One helper module per controller by default (e.g. `UsersHelper`)
- Shared helpers: `ApplicationHelper`
- Keep helpers simple — complex logic belongs in presenters/decorators or models

## Presenters / Decorators
<!-- DELETE this section if not using presenters/decorators -->
- Library: [e.g. Draper / custom POROs / none]
- Location: [e.g. `app/decorators/` / `app/presenters/`]
- Pattern: wrap model, add display logic
```ruby
# app/decorators/user_decorator.rb (Draper example)
class UserDecorator < Draper::Decorator
  delegate_all

  def display_name
    object.name.presence || object.email
  end
end
```

## Turbo Drive
<!-- DELETE this section if not using Turbo -->
- Enabled: [yes/no — Turbo Drive is on by default in Rails 7+]
- Opt-out pages: [list pages that disable Turbo, e.g. `data-turbo="false"`]
- Turbo cache: [e.g. enabled / disabled for specific pages]

## Turbo Frames
<!-- DELETE this section if not using Turbo Frames -->
- Used for: [e.g. inline editing, lazy loading, tab content, modal content]
- Naming convention: `<turbo-frame id="resource_123">` — model + ID
- Lazy loading: `<turbo-frame id="..." src="/path" loading="lazy">`
```erb
<%# Index page with inline edit frames %>
<%= turbo_frame_tag dom_id(resource) do %>
  <%= render resource %>
<% end %>
```

## Turbo Streams
<!-- DELETE this section if not using Turbo Streams -->
- Used for: [e.g. real-time updates, form responses, broadcasts]
- Actions: append, prepend, replace, update, remove, before, after
- Broadcast: [e.g. `broadcasts_to :channel` in model / manual broadcast from jobs]
```ruby
# Controller responding with Turbo Stream
respond_to do |format|
  format.turbo_stream
  format.html { redirect_to resources_path }
end
```

## Stimulus Controllers
<!-- DELETE this section if not using Stimulus -->
- Location: `app/javascript/controllers/`
- Registration: [e.g. auto-registered via `controllers/index.js` / importmap pins]
- Naming: `hello_controller.js` → `data-controller="hello"`
- Conventions:
  - One behavior per controller
  - Use targets for DOM references (`data-hello-target="output"`)
  - Use values for configuration (`data-hello-url-value="/path"`)
  - Use actions for events (`data-action="click->hello#greet"`)

## Form Patterns
- Builder: [e.g. `form_with` / SimpleForm / Formtastic]
- CSRF: authenticity token included automatically
- Error display: [e.g. inline errors, error summary at top, both]
```erb
<%# Standard form_with pattern %>
<%= form_with(model: resource) do |f| %>
  <% if resource.errors.any? %>
    <div id="error_explanation">
      <ul>
        <% resource.errors.full_messages.each do |msg| %>
          <li><%= msg %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

## Flash Messages
- Types used: [e.g. `:notice`, `:alert`, `:error`, `:success`]
- Display location: [e.g. `application.html.erb` layout, shared partial]
- Turbo compatibility: use `flash.now` for Turbo Stream responses
```erb
<%# app/views/layouts/application.html.erb %>
<% flash.each do |type, message| %>
  <div class="flash flash-<%= type %>"><%= message %></div>
<% end %>
```

## Asset Pipeline
- Pipeline: [e.g. Propshaft / Sprockets]
- CSS: [e.g. Tailwind / Bootstrap / custom SCSS]
- JS: [e.g. importmap / esbuild / webpack]
- Images: `app/assets/images/`
- Stylesheets: [e.g. `app/assets/stylesheets/` / `app/assets/builds/`]

## Changelog
<!-- [PROJ-123] Added Turbo Frame patterns for inline editing -->
