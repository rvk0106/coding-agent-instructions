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
# app/serializers/program_serializer.rb (adapt to your library)
class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at
  belongs_to :organization
  has_many :enrollments
end
```

## Query Patterns
```ruby
# Eager loading -- prevent N+1
Program.includes(:organization, :enrollments).where(active: true)

# When to use each:
# includes  → preloads associations (separate queries)
# eager_load → LEFT JOIN (single query, use for filtering on association)
# joins      → INNER JOIN (use for filtering only, not loading data)
# preload    → always separate queries (use for has_many with limit)

# Pagination
@programs = Program.page(params[:page]).per(params[:per_page] || 25)

# Scoping (always scope to tenant/user)
current_tenant.programs.where(active: true)
```

## Test Data (FactoryBot)
```ruby
# Factory location: spec/factories/

# Build (in memory, no DB hit -- use for unit tests)
build(:program)

# Create (persists to DB -- use for integration tests)
create(:program, name: "Test Program")

# Traits for common variants
create(:program, :archived)
create(:user, :admin)

# Sequences for unique values
sequence(:email) { |n| "user#{n}@example.com" }
```

## Request Spec Pattern
```ruby
# spec/requests/api/v1/programs_spec.rb
RSpec.describe "Programs API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user) }

  describe "GET /api/v1/programs" do
    it "returns paginated programs" do
      create_list(:program, 3)
      get "/api/v1/programs", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json_body[:data].size).to eq(3)
    end
  end

  describe "POST /api/v1/programs" do
    it "creates a program" do
      post "/api/v1/programs", params: { program: valid_attrs }, headers: headers
      expect(response).to have_http_status(:created)
    end

    it "returns 422 for invalid params" do
      post "/api/v1/programs", params: { program: invalid_attrs }, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
```

## Model Spec Pattern
```ruby
# spec/models/program_spec.rb
RSpec.describe Program, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_many(:enrollments) }
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
def auth_headers_for(user)
  token = generate_jwt_for(user)
  { "Authorization" => "Bearer #{token}" }
end

def json_body
  JSON.parse(response.body, symbolize_names: true)
end
```

## Changelog
<!-- Update when conventions change -->
