# Security Rules
> Tags: security, auth, owasp, injection, xss, csrf, tenant
> Scope: Security constraints agents must follow -- prevents vulnerabilities
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `params` directly -- always use strong parameters
- Never use raw SQL with user input -- use parameterized queries
- Never expose internal IDs in error messages
- Never log passwords, tokens, or PII
- Never disable CSRF protection (full-stack Rails requires it)
- Never hardcode secrets in code
- Never trust client-side data for authorization
- Never use `find(params[:id])` without scoping to current user (or tenant if multi-tenant)
- Never use `html_safe` or `raw` on user-provided content
- Never render user input without sanitization

## Always Do These
- Always scope queries to current user (or tenant if multi-tenant)
- Always use strong parameters in every controller
- Always validate file uploads (type, size, content)
- Always sanitize user input before rendering
- Always use HTTPS-only cookies for sessions
- Always rate-limit authentication endpoints
- Always use `content_security_policy` headers
- Always escape output in views (ERB auto-escapes by default -- don't bypass it)

## Query Scoping
```ruby
# CORRECT: scoped to current user
current_user.resources.find(params[:id])

# WRONG: unscoped -- may leak other users' data
Resource.find(params[:id])
```
<!-- If multi-tenant, also scope to tenant: current_tenant.resources.find(params[:id]) -->

## Parameter Safety
```ruby
# CORRECT: explicit whitelist
params.require(:resource).permit(:name, :description, :status)

# WRONG: mass assignment vulnerability
Resource.create(params[:resource])
```

## SQL Injection Prevention
```ruby
# CORRECT: parameterized
User.where("email = ?", params[:email])
User.where(email: params[:email])

# WRONG: string interpolation
User.where("email = '#{params[:email]}'")
```

## XSS Prevention
```erb
<%# CORRECT: ERB auto-escapes by default %>
<%= user.name %>

<%# WRONG: bypasses escaping -- XSS risk %>
<%= raw user.bio %>
<%= user.bio.html_safe %>

<%# CORRECT: if you need to render HTML, sanitize it %>
<%= sanitize user.bio, tags: %w[b i em strong p br] %>
```

## CSRF Protection
- Full-stack Rails: `protect_from_forgery with: :exception` is enabled by default
- DO NOT disable CSRF protection
- Forms: `form_with` includes authenticity token automatically
- AJAX: ensure `csrf-meta-tags` in layout, and Turbo/Rails UJS sends token
- API endpoints (if any): may need `skip_forgery_protection` with token-based auth only

## Authentication Checks
- Every controller action must authenticate (unless explicitly public)
- Use `before_action :authenticate_user!` (Devise) or equivalent
- Public pages: list them explicitly with `skip_before_action :authenticate_user!`
- Session timeout: [e.g. 30 min idle / configurable via Devise]

## Authorization Checks
- Every mutating action must authorize
- Use your project's authorization library (Pundit / CanCanCan / custom) consistently
- Test authorization in system/request specs:
  ```ruby
  it "redirects unauthorized user" do
    sign_in(member)
    get admin_users_path
    expect(response).to redirect_to(root_path)
  end
  ```

## Secure Headers
- Use `secure_headers` gem or Rack middleware
- Must set: X-Frame-Options, X-Content-Type-Options, HSTS, CSP, Referrer-Policy
- Content Security Policy: configure in `config/initializers/content_security_policy.rb`

## Session / Cookie Security
- `secure: true`, `httponly: true`, `SameSite: Lax` on all session cookies
- Session store: [e.g. cookie store / Redis / ActiveRecord]
- Cookie-based sessions: default in Rails, ensure `secret_key_base` is set

## Rate Limiting
- Use `rack-attack` or similar
- Auth endpoints: limit per IP
- Form submissions: limit per user/session
- Return 429 with `Retry-After` header

## File Upload Security
- Validate content type (not just extension)
- Limit file size
- Store uploads outside public directory (use ActiveStorage)
- Scan for malware if handling sensitive files

## Secrets Management
- Location: [e.g. Rails credentials / ENV vars]
- Never commit `.env` files with real secrets
- Rotate: [process for rotating secrets]

## Changelog
<!-- [PROJ-123] Added rate limiting to login endpoint -->
