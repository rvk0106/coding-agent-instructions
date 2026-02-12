# API Design
> Tags: api, endpoints, rest, response, versioning, swagger, openapi
> Scope: API conventions, endpoint patterns, response shapes
> Last updated: [TICKET-ID or date]

## Base URL
- Pattern: [e.g. `/api/v1/` or `/api/`]
- Admin: [e.g. `/api/v1/admin/`]
- Public: [e.g. `/api/v1/`]
- Actuator: [e.g. `/actuator/` (management endpoints)]

## Versioning
- Strategy: [choose one]
  - **URL path**: `/api/v1/resources` -- Spring Boot convention; simpler routing, easier debugging
  - **Header-based**: `Accept: application/vnd.myapp.v1+json` -- cleaner URLs, more complex
  - **Request parameter**: `?version=1` -- least common
- **Recommendation:** URL path versioning is the most common in Spring Boot APIs
- Current version: [e.g. v1]

## Response Shape
<!-- Define YOUR project's standard shape. Example options: -->
```java
// Option A: Wrapped response (explicit)
// Success: { "success": true, "message": "...", "data": {...}, "meta": {} }
// Error:   { "success": false, "message": "...", "errors": [...] }

// Option B: Bare data (simpler)
// Success: { "id": 1, "name": "..." }  or  { "data": { ... } }
// Error:   { "error": "Not found", "message": "...", "timestamp": "..." }

// Option C: Spring Boot default error format
// Error:   { "timestamp": "...", "status": 404, "error": "Not Found", "path": "/api/v1/..." }
```
**This project uses**: [describe your chosen shape here]

## Authentication
<!-- Choose your auth pattern -->
- **Bearer token (JWT)**: `Authorization: Bearer <token>`
- **OAuth2 Resource Server**: JWT validation via Spring Security
- **Session auth**: Spring Session with Redis/JDBC
- **API key**: `X-API-Key` header
- **This project uses**: [describe your auth method]
- Unauthenticated: 401
- Unauthorized: 403

## Pagination
- Style: [choose one]
  - **Page-based**: `?page=0&size=25` --> meta: `{ "totalElements", "totalPages", "number", "size" }` (Spring Data default)
  - **Cursor-based**: `?after=<cursor>&limit=25` --> meta: `{ "hasNext", "nextCursor" }`
- **This project uses**: [describe your pagination style]
- Default page size: [e.g. 20]
- Max page size: [e.g. 100]

## Key Endpoints
<!-- List the main API groups -->
| Group | Base Path | Auth Required |
|-------|-----------|:------------:|
| Auth | [e.g. `/api/v1/auth/`] | No |
| Users | [e.g. `/api/v1/users/`] | Yes |
| Admin | [e.g. `/api/v1/admin/`] | Yes (ROLE_ADMIN) |
| [group] | [path] | [yes/no] |

## Naming Conventions
- Resources: plural, kebab-case for multi-word (`/users`, `/order-items`)
- Actions: RESTful (GET list, GET by ID, POST create, PUT/PATCH update, DELETE)
- Custom actions: verb prefix (`/users/{id}/activate`, `/orders/{id}/cancel`)
- Nested max depth: 2 levels (`/courses/{id}/enrollments`)
- Request/response: camelCase JSON fields (Java convention)

## API Documentation
- Tool: [e.g. springdoc-openapi / springfox / none]
- Swagger UI: [e.g. `http://localhost:8080/swagger-ui.html`]
- OpenAPI spec: [e.g. `http://localhost:8080/v3/api-docs`]
- Annotations: Use `@Operation`, `@ApiResponse`, `@Schema` from `io.swagger.v3.oas.annotations`
- Generate: [e.g. automatic via springdoc-openapi at runtime]

## Changelog
<!-- [PROJ-123] Added enrollment endpoints -->
