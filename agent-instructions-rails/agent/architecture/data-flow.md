# Data Flow & Request Lifecycle
> Tags: request, middleware, pipeline, controller, turbo, response
> Scope: How a request flows through the app from entry to response
> Last updated: [TICKET-ID or date]

## Request Pipeline (standard HTML)
```
Browser Request
  -> Rack Middleware (logging, session, cookies, CSRF verification)
    -> Rails Router (config/routes.rb)
      -> Controller before_actions:
        1. authenticate (verify session/credentials -> redirect to sign in if invalid)
        2. set_scope (user/tenant scoping, if applicable)
        3. authorize (check permissions -> 403 if denied)
      -> Controller action
        -> Strong parameters (whitelist input)
        -> Service object (business logic, if complex)
          -> Model (DB read/write)
          -> External service calls (if any)
        -> Set instance variables for view
      -> Controller after_actions (logging, cleanup)
    -> Render view template (layout + view + partials)
  -> Rack Middleware (response headers, compression)
Browser Response (full HTML page)
```

## Turbo Drive Request (navigation)
```
Browser Click / Form Submit
  -> Turbo Drive intercepts (no full page reload)
  -> Fetch request with Accept: text/html
  -> Same server pipeline as standard HTML
  -> Server returns full HTML page
  -> Turbo Drive replaces <body>, merges <head>
  -> Browser updates URL, no full reload
```

## Turbo Frame Request
```
Browser Interaction inside <turbo-frame>
  -> Turbo fetches URL with Turbo-Frame header
  -> Server renders full page (or frame-specific partial)
  -> Turbo extracts matching <turbo-frame id="..."> from response
  -> Only the frame content is replaced in the DOM
```

## Turbo Stream Request (form submit)
```
Form Submit (with Turbo)
  -> POST/PATCH/DELETE request
  -> Controller processes action
  -> respond_to do |format|
       format.turbo_stream { render turbo_stream: ... }
       format.html { redirect_to ... }
     end
  -> Turbo Stream response: targeted DOM updates (append, replace, remove, etc.)
```

## Turbo Stream Broadcast (real-time)
<!-- DELETE this section if not using Turbo Stream broadcasts -->
```
Model change (create/update/destroy)
  -> broadcasts_to / broadcast_append_to (ActionCable)
  -> WebSocket delivers Turbo Stream to subscribed clients
  -> DOM updated in real time (no request needed)
```

## Authentication Flow
<!-- Adapt to your auth method (Devise, custom sessions) -->
```
Request -> check session cookie -> find user
  +-- Valid session -> set current_user -> proceed to controller
  +-- Invalid/missing -> redirect to sign_in_path (Devise) or login page
  +-- Remember me -> check remember token -> restore session
```

## Authorization Flow
<!-- Adapt to your authz library (Pundit, CanCanCan, custom) -->
```
Controller -> check permissions (policy/ability/inline) -> allow or deny
  +-- Authorized -> proceed
  +-- Denied -> redirect with flash alert (or render 403)
```

## Multi-Tenant Flow
<!-- DELETE this section if your app is single-tenant -->
```
Request -> resolve tenant (from subdomain/header/param) -> set tenant context
  +-- All queries auto-scoped to tenant
  +-- Admin routes -> may cross tenant boundaries
  +-- Danger: raw SQL bypasses tenant scoping
```

## Key before_actions Order
<!-- Document the actual order from your ApplicationController -->
1. `authenticate_user!` -> ensures user is signed in (Devise)
2. `set_scope` -> scopes data to user or tenant (if applicable)
3. `authorize` -> checks permissions (if using policy library)
4. [Add project-specific before_actions]

## Background Job Flow
<!-- DELETE this section if not using background jobs -->
```
Controller -> enqueue job -> redirect with flash notice
  -> Worker picks up job -> execute -> update DB
  -> If using broadcasts: Turbo Stream broadcast to user
  -> If failure -> retry (max N times) -> dead letter queue
```

## Transaction Rules
- ALWAYS wrap multi-model writes in `ActiveRecord::Base.transaction`
- NEVER call external services inside a transaction (holds DB lock on network failure)
- Pattern: DB writes in transaction -> external calls after commit
- Gotchas: `after_commit` runs outside transaction; async jobs may fire before commit

## Mailer Flow
```
Controller/Service -> enqueue mailer (deliver_later)
  -> Job worker picks up -> render mailer view -> send via ActionMailer
  -> Delivery method: [e.g. SMTP / SendGrid / SES]
```

## Changelog
<!-- [PROJ-123] Added Turbo Stream broadcast for real-time updates -->
