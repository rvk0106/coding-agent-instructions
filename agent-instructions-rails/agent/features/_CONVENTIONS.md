# Feature Implementation Conventions
> Tags: conventions, serialization, queries, testing, patterns
> Scope: Patterns to follow when implementing any feature
> Last updated: [TICKET-ID or date]

## Serialization
- Library: [e.g. ActiveModelSerializers / JBuilder / Blueprinter / manual to_json]
- Naming: [e.g. snake_case keys / camelCase keys]
- Timestamps: [e.g. ISO-8601 / Unix epoch]
- Nulls: [e.g. include as null / omit]
- Nested depth max: [e.g. 2 levels -- don't nest deeper, use IDs]

### Example Serializer
```ruby
# app/serializers/resource_serializer.rb (adapt to your library)
class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at
  belongs_to :user
end
```

## Query Patterns
```ruby
# Eager loading -- prevent N+1
Resource.includes(:user, :tags).where(active: true)

# When to use each:
# includes  → preloads associations (separate queries)
# eager_load → LEFT JOIN (single query, use for filtering on association)
# joins      → INNER JOIN (use for filtering only, not loading data)
# preload    → always separate queries (use for has_many with limit)

# Pagination (adapt to your pagination gem — Kaminari, will_paginate, Pagy, etc.)
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

## Request Spec Pattern
```ruby
# spec/requests/api/v1/resources_spec.rb
RSpec.describe "Resources API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user) }

  describe "GET /api/v1/resources" do
    it "returns paginated resources" do
      create_list(:resource, 3)
      get "/api/v1/resources", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json_body[:data].size).to eq(3)
    end
  end

  describe "POST /api/v1/resources" do
    it "creates a resource" do
      post "/api/v1/resources", params: { resource: valid_attrs }, headers: headers
      expect(response).to have_http_status(:created)
    end

    it "returns 422 for invalid params" do
      post "/api/v1/resources", params: { resource: invalid_attrs }, headers: headers
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
# spec/support/auth_helpers.rb
# Adapt to your auth method (JWT, session, API key)
def auth_headers_for(user)
  # JWT example:
  # token = generate_jwt_for(user)
  # { "Authorization" => "Bearer #{token}" }
  #
  # Session example:
  # sign_in(user)  # Devise test helper
  # {}
  #
  # API key example:
  # { "X-API-Key" => user.api_key }
end

def json_body
  JSON.parse(response.body, symbolize_names: true)
end
```

## Changelog
<!-- Update when conventions change -->
