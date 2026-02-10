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
        1. authenticate (verify credentials → 401 if invalid)
        2. set_scope (user/tenant scoping, if applicable)
        3. authorize (check permissions → 403 if denied)
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
<!-- Adapt to your auth method (JWT, session, API key) -->
```
Request → extract credentials (header/cookie/param) → verify → set current_user
  ├── Valid → proceed to controller
  ├── Expired/Invalid → 401
  └── Missing → 401
```

## Authorization Flow
<!-- Adapt to your authz library (Pundit, CanCanCan, custom) -->
```
Controller → check permissions (policy/ability/inline) → allow or deny
  ├── Authorized → proceed
  └── Denied → 403
```

## Multi-Tenant Flow
<!-- DELETE this section if your app is single-tenant -->
```
Request → resolve tenant (from subdomain/header/param) → set tenant context
  ├── All queries auto-scoped to tenant
  ├── Admin routes → may cross tenant boundaries
  └── Danger: raw SQL bypasses tenant scoping
```

## Key before_actions Order
<!-- Document the actual order from your base controller -->
1. `authenticate` → sets `current_user`
2. `set_scope` → scopes data to user or tenant (if applicable)
3. `authorize` → checks permissions (if using policy library)
4. [Add project-specific before_actions]

## Background Job Flow
<!-- DELETE this section if not using background jobs -->
```
Controller → enqueue job → return 202/200 to client
  → Worker picks up job → execute → update DB
  → If failure → retry (max N times) → dead letter queue
```

## Transaction Rules
- ALWAYS wrap multi-model writes in `ActiveRecord::Base.transaction`
- NEVER call external services inside a transaction (holds DB lock on network failure)
- Pattern: DB writes in transaction → external calls after commit
- Gotchas: `after_commit` runs outside transaction; async jobs may fire before commit

## Serialization Pipeline
- Serializer: [e.g. ActiveModelSerializers / JBuilder / Blueprinter / manual]
- Format: JSON
- Naming: [e.g. snake_case / camelCase]
- Timestamps: [e.g. ISO-8601]
- Nulls: [e.g. included as null / omitted]

## Changelog
<!-- [PROJ-123] Added rate limiting middleware -->
