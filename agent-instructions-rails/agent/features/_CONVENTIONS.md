# Feature Implementation Conventions
> Tags: conventions, views, forms, queries, testing, patterns
> Scope: Patterns to follow when implementing any feature
> Last updated: [TICKET-ID or date]

## View Patterns

### Partials
```erb
<%# CORRECT: explicit locals %>
<%= render partial: "resources/card", locals: { resource: resource } %>

<%# CORRECT: collection rendering %>
<%= render partial: "resources/card", collection: @resources, as: :resource %>

<%# WRONG: relying on instance variables in partials %>
<%= render partial: "resources/card" %>
```

### Layouts
```erb
<%# Yield for page-specific content in layout %>
<%= yield %>

<%# Content_for for page-specific head/scripts %>
<%= content_for :head %>
```

## Form Patterns
```erb
<%# Standard form_with (Rails 7+) %>
<%= form_with(model: @resource, class: "form") do |f| %>
  <div class="field">
    <%= f.label :name %>
    <%= f.text_field :name %>
  </div>

  <div class="field">
    <%= f.label :description %>
    <%= f.text_area :description %>
  </div>

  <%= f.submit %>
<% end %>
```

### Form Error Display
```erb
<%# Shared error partial: app/views/shared/_form_errors.html.erb %>
<% if resource.errors.any? %>
  <div id="error_explanation" class="error-messages">
    <h2><%= pluralize(resource.errors.count, "error") %> prohibited saving:</h2>
    <ul>
      <% resource.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
  </div>
<% end %>

<%# Usage in form: %>
<%= render "shared/form_errors", resource: @resource %>
```

## Turbo Patterns

### Turbo Frame (inline editing)
```erb
<%# Index page %>
<%= turbo_frame_tag dom_id(resource) do %>
  <%= render resource %>
<% end %>

<%# Edit form responds within frame %>
<%= turbo_frame_tag dom_id(@resource) do %>
  <%= render "form", resource: @resource %>
<% end %>
```

### Turbo Stream (create/update response)
```ruby
# Controller
def create
  @resource = Resource.new(resource_params)
  if @resource.save
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to resources_path, notice: "Created." }
    end
  else
    render :new, status: :unprocessable_entity
  end
end
```
```erb
<%# app/views/resources/create.turbo_stream.erb %>
<%= turbo_stream.prepend "resources", partial: "resources/resource", locals: { resource: @resource } %>
<%= turbo_stream.update "flash", partial: "shared/flash" %>
```

### Stimulus Controller
```javascript
// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = { open: { type: Boolean, default: false } }

  toggle() {
    this.openValue = !this.openValue
    this.contentTarget.classList.toggle("hidden", !this.openValue)
  }
}
```
```erb
<%# Usage in view %>
<div data-controller="toggle">
  <button data-action="click->toggle#toggle">Toggle</button>
  <div data-toggle-target="content" class="hidden">
    Content here
  </div>
</div>
```

## Query Patterns
```ruby
# Eager loading -- prevent N+1
Resource.includes(:user, :tags).where(active: true)

# When to use each:
# includes  -> preloads associations (separate queries)
# eager_load -> LEFT JOIN (single query, use for filtering on association)
# joins      -> INNER JOIN (use for filtering only, not loading data)
# preload    -> always separate queries (use for has_many with limit)

# Pagination (adapt to your pagination gem -- Kaminari, will_paginate, Pagy, etc.)
@resources = Resource.page(params[:page]).per(params[:per_page] || 25)

# Scoping -- always scope to current user
current_user.resources.where(active: true)
# If multi-tenant: current_tenant.resources.where(active: true)
```

## Test Data (FactoryBot)
```ruby
# Factory location: spec/factories/

# Build (in memory, no DB hit -- use for unit tests)
build(:resource)

# Create (persists to DB -- use for integration tests)
create(:resource, name: "Test Resource")

# Traits for common variants
create(:resource, :archived)
create(:user, :admin)

# Sequences for unique values
sequence(:email) { |n| "user#{n}@example.com" }
```

## System Spec Pattern (Capybara)
```ruby
# spec/system/resources_spec.rb
RSpec.describe "Resources", type: :system do
  let(:user) { create(:user) }

  before { sign_in user }

  it "creates a new resource" do
    visit new_resource_path
    fill_in "Name", with: "Test Resource"
    click_button "Create Resource"

    expect(page).to have_content("Resource created")
    expect(page).to have_content("Test Resource")
  end

  it "shows validation errors" do
    visit new_resource_path
    click_button "Create Resource"

    expect(page).to have_content("can't be blank")
  end
end
```

## Request Spec Pattern
```ruby
# spec/requests/resources_spec.rb
RSpec.describe "Resources", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /resources" do
    it "returns success" do
      create_list(:resource, 3, user: user)
      get resources_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /resources" do
    it "creates a resource" do
      post resources_path, params: { resource: { name: "Test" } }
      expect(response).to redirect_to(resource_path(Resource.last))
      follow_redirect!
      expect(response.body).to include("Resource created")
    end

    it "re-renders form on invalid params" do
      post resources_path, params: { resource: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
```

## Model Spec Pattern
```ruby
# spec/models/resource_spec.rb
RSpec.describe Resource, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "scopes" do
    # test custom scopes
  end
end
```

## Helper Methods
```ruby
# spec/support/auth_helpers.rb (or use Devise test helpers)
# If using Devise:
# include Devise::Test::IntegrationHelpers  (request specs)
# include Devise::Test::Helpers             (controller specs)

# Warden helper for system specs:
# include Warden::Test::Helpers
# before { login_as(user, scope: :user) }
```

## Changelog
<!-- Update when conventions change -->
