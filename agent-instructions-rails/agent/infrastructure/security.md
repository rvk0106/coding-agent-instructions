# Security Rules
> Tags: security, auth, owasp, injection, xss, tenant
> Scope: Security constraints agents must follow -- prevents vulnerabilities
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `params` directly -- always use strong parameters
- Never use raw SQL with user input -- use parameterized queries
- Never expose internal IDs in error messages
- Never log passwords, tokens, or PII
- Never disable CSRF protection
- Never hardcode secrets in code
- Never trust client-side data for authorization
- Never use `find(params[:id])` without scoping to tenant/user

## Always Do These
- Always scope queries to current user/tenant
- Always use strong parameters in every controller
- Always validate file uploads (type, size, content)
- Always sanitize user input before rendering
- Always use HTTPS-only cookies for tokens
- Always rate-limit authentication endpoints

## Multi-Tenant Boundaries
```ruby
# CORRECT: scoped to tenant
current_tenant.programs.find(params[:id])

# WRONG: unscoped -- leaks data across tenants
Program.find(params[:id])
```

## Parameter Safety
```ruby
# CORRECT: explicit whitelist
params.require(:program).permit(:name, :description, :parent_id)

# WRONG: mass assignment vulnerability
Program.create(params[:program])
```

## SQL Injection Prevention
```ruby
# CORRECT: parameterized
User.where("email = ?", params[:email])
User.where(email: params[:email])

# WRONG: string interpolation
User.where("email = '#{params[:email]}'")
```

## Authentication Checks
- Every controller action must authenticate (unless explicitly public)
- Public endpoints: list them in `architecture/api-design.md`
- Token expiration: [e.g. 15 min access, 7 day refresh]

## Authorization Checks
- Every mutating action must authorize
- Use [Pundit/CanCanCan] policies -- not inline if-checks
- Test authorization in request specs:
  ```ruby
  it "returns 403 for unauthorized user" do
    get resource_path, headers: member_headers
    expect(response).to have_http_status(:forbidden)
  end
  ```

## Secure Headers
- Use `secure_headers` gem or Rack middleware
- Must set: X-Frame-Options, X-Content-Type-Options, HSTS, CSP, Referrer-Policy

## Session / Cookie Security
- `secure: true`, `httponly: true`, `SameSite: Lax` on all auth cookies
- Prefer httpOnly cookies over localStorage for tokens

## CSRF Protection
- API-only (Bearer token): CSRF disabled OK
- Session auth: `protect_from_forgery` required

## Rate Limiting
- Use `rack-attack` or similar
- Auth endpoints: limit per IP; API endpoints: limit per user
- Return 429 with `Retry-After` header

## Secrets Management
- Location: [e.g. Rails credentials / ENV vars]
- Never commit `.env` files with real secrets
- Rotate: [process for rotating secrets]

## Changelog
<!-- [PROJ-123] Added rate limiting to login endpoint -->
