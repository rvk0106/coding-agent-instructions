# API Design
> Tags: api, endpoints, rest, response, versioning
> Scope: API conventions, endpoint patterns, response shapes
> Last updated: [TICKET-ID or date]

## Base URL
- Pattern: `/api/v1/`
- Admin: `/api/v1/admin/`
- Public: `/api/v1/`

## Versioning
- Strategy: [e.g. URL path `/api/v1/` / header-based]
- Current version: v1

## Response Shape
```ruby
# Success
{ success: true, message: "...", data: {}, meta: {} }

# Error
{ success: false, message: "...", errors: [], meta: {} }
```

## Authentication
- Header: `Authorization: Bearer <token>`
- Unauthenticated: 401
- Unauthorized: 403

## Pagination
- Style: [e.g. page-based / cursor-based]
- Params: `?page=1&per_page=25`
- Meta: `{ total: N, page: N, per_page: N, total_pages: N }`

## Key Endpoints
<!-- List the main API groups -->
| Group | Base Path | Auth Required |
|-------|-----------|:------------:|
| Auth | `/api/v1/auth/` | No |
| Users | `/api/v1/users/` | Yes |
| Admin | `/api/v1/admin/` | Yes (admin) |
| [group] | [path] | [yes/no] |

## Naming Conventions
- Resources: plural (`/users`, `/programs`)
- Actions: RESTful (index, show, create, update, destroy)
- Custom actions: verb prefix (`/users/:id/activate`)
- Nested max depth: 2 levels (`/organizations/:id/users`)

## API Documentation
- Tool: [e.g. rswag / swagger-blocks]
- Generate: `bundle exec rake swagger:generate_modular`
- Location: [e.g. `/api-docs`]

## Changelog
<!-- [PROJ-123] Added /api/v1/programs endpoints -->
