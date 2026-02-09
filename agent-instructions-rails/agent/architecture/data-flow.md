# Data Flow & Request Lifecycle
> Tags: request, middleware, pipeline, controller, service, response
> Scope: How a request flows through the app from entry to response
> Last updated: [TICKET-ID or date]

## Request Pipeline
```
Client Request
  → Rack Middleware (logging, CORS, rate limiting)
    → Rails Router (config/routes.rb)
      → Controller before_actions:
        1. authenticate_user (JWT/session check → 401 if invalid)
        2. set_tenant (multi-tenant scoping, if applicable)
        3. authorize (Pundit/CanCanCan → 403 if denied)
      → Controller action
        → Strong parameters (whitelist input)
        → Service object (business logic)
          → Model (DB read/write)
          → External service calls (if any)
        → Serialize response
      → Controller after_actions (logging, cleanup)
    → Render JSON response
  → Rack Middleware (response headers, compression)
Client Response
```

## Authentication Flow
```
Request → Authorization header → decode JWT → find user → set current_user
  ├── Token valid → proceed to controller
  ├── Token expired → 401 { message: "Token expired" }
  └── Token missing → 401 { message: "Authentication required" }
```

## Authorization Flow
```
Controller → authorize(resource) → Policy class → check role/permissions
  ├── Authorized → proceed
  └── Denied → 403 { message: "Not authorized" }
```

## Multi-Tenant Flow (if applicable)
```
Request → resolve tenant (from subdomain/header/param) → set tenant context
  ├── All queries auto-scoped to tenant
  ├── Admin routes → may cross tenant boundaries
  └── Danger: raw SQL bypasses tenant scoping
```

## Key before_actions Order
<!-- Document the actual order from your base controller -->
1. `authenticate_user` → sets `current_user`
2. `set_tenant` → sets tenant context (if multi-tenant)
3. `authorize` → checks permissions
4. [Add project-specific before_actions]

## Background Job Flow
```
Controller → enqueue job (Sidekiq) → return 202/200 to client
  → Worker picks up job → execute → update DB
  → If failure → retry (max N times) → dead letter queue
```

## Transaction Management
```ruby
# Multi-step operations -- wrap in transaction
ActiveRecord::Base.transaction do
  order = Order.create!(order_params)
  order.line_items.create!(items_params)
  PaymentService.charge!(order)       # raises on failure → rolls back
end
# If any step raises → entire transaction rolls back

# Gotchas:
# - after_commit callbacks run OUTSIDE the transaction
# - Sidekiq jobs enqueued inside a transaction may fire before commit
# - Nested transactions use savepoints (rescue inner without rolling outer)
```
- ALWAYS wrap multi-model writes in `ActiveRecord::Base.transaction`
- NEVER call external services inside a transaction (network failures hold DB lock)
- Pattern: write to DB in transaction → call external service after commit
  ```ruby
  ActiveRecord::Base.transaction do
    record = Record.create!(params)
  end
  # External call AFTER successful commit
  ExternalService.notify(record)
  ```

## Serialization Pipeline
- Serializer: [e.g. ActiveModelSerializers / JBuilder / Blueprinter / manual]
- Format: JSON
- Naming: [e.g. snake_case / camelCase]
- Timestamps: [e.g. ISO-8601]
- Nulls: [e.g. included as null / omitted]

## Changelog
<!-- [PROJ-123] Added rate limiting middleware -->
