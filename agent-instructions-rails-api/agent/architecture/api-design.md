# API Design
> Tags: api, endpoints, rest, response, versioning
> Scope: API conventions, endpoint patterns, response shapes
> Last updated: [TICKET-ID or date]

## Base URL
- Pattern: [e.g. `/api/v1/` or `/api/`]
- Admin: [e.g. `/api/v1/admin/`]
- Public: [e.g. `/api/v1/`]

## Versioning
- Strategy: [choose one]
  - **URL path**: `/api/v1/resources` — Rails convention; simpler routing, easier debugging
  - **Header-based**: `Accept: application/vnd.myapp.v1+json` — cleaner URLs, more complex routing
- **Recommendation:** URL path is the Rails standard (used by ~90% of Rails APIs)
- Current version: [e.g. v1]

## Response Shape
<!-- Define YOUR project's standard shape. Example options: -->
```ruby
# Option A: Wrapped response (explicit success flag)
# Success: { success: true, message: "...", data: {}, meta: {} }
# Error:   { success: false, message: "...", errors: [], meta: {} }

# Option B: Bare data (simpler)
# Success: { "id": 1, "name": "..." }  or  { "data": { ... } }
# Error:   { "error": "Not found", "details": [...] }

# Option C: JSON:API format
# Success: { "data": { "type": "resources", "id": "1", "attributes": {} } }
```
**This project uses**: [describe your chosen shape here]

## Authentication
<!-- Choose your auth pattern -->
- **Bearer token (JWT)**: `Authorization: Bearer <token>`
- **Session auth**: cookie-based, server-side session
- **API key**: `Authorization: ApiKey <key>` or `X-API-Key` header
- **This project uses**: [describe your auth method]
- Unauthenticated: 401
- Unauthorized: 403

## Pagination
- Style: [choose one]
  - **Page-based**: `?page=1&per_page=25` → meta: `{ total, page, per_page, total_pages }`
  - **Cursor-based**: `?after=<cursor>&limit=25` → meta: `{ has_next, next_cursor }`
- **This project uses**: [describe your pagination style]

## Key Endpoints
<!-- List the main API groups -->
| Group | Base Path | Auth Required |
|-------|-----------|:------------:|
| Auth | [e.g. `/api/v1/auth/`] | No |
| Users | [e.g. `/api/v1/users/`] | Yes |
| Admin | [e.g. `/api/v1/admin/`] | Yes (admin) |
| [group] | [path] | [yes/no] |

## Naming Conventions
- Resources: plural (`/users`, `/orders`)
- Actions: RESTful (index, show, create, update, destroy)
- Custom actions: verb prefix (`/users/:id/activate`)
- Nested max depth: 2 levels (`/accounts/:id/users`)

## API Documentation
- Tool: [e.g. rswag / swagger-blocks / none]
- Generate: [e.g. `bundle exec rake swagger:generate_modular`]
- Location: [e.g. `/api-docs`]

## Changelog
<!-- [PROJ-123] Added new API endpoints -->
