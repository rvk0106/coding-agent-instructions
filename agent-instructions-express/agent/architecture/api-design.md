# API Design
> Tags: api, endpoints, rest, response, versioning, swagger
> Scope: API conventions, endpoint patterns, response shapes
> Last updated: [TICKET-ID or date]

## Base URL
- Pattern: [e.g. `/api/v1/`]
- Admin: [e.g. `/api/v1/admin/`]
- Public: [e.g. `/api/v1/`]

## Versioning
- Strategy: [choose one]
  - **URL path**: `/api/v1/resources` -- Express convention; simpler routing, easier debugging
  - **Header-based**: `Accept: application/vnd.myapp.v1+json` -- cleaner URLs, more complex routing
- **Recommendation:** URL path is the Express standard
- Current version: [e.g. v1]

## Response Shape
<!-- Define YOUR project's standard shape. Example options: -->
```javascript
// Option A: Wrapped response (explicit success flag)
// Success: { success: true, message: "...", data: {}, meta: {} }
// Error:   { success: false, message: "...", errors: [], meta: {} }

// Option B: Bare data (simpler)
// Success: { "id": 1, "name": "..." }  or  { "data": { ... } }
// Error:   { "error": "Not found", "details": [...] }

// Option C: JSON:API format
// Success: { "data": { "type": "resources", "id": "1", "attributes": {} } }
```
**This project uses**: [describe your chosen shape here]

## Authentication
<!-- Choose your auth pattern -->
- **Bearer token (JWT)**: `Authorization: Bearer <token>`
- **Session auth**: cookie-based via `express-session`
- **API key**: `Authorization: ApiKey <key>` or `X-API-Key` header
- **This project uses**: [describe your auth method]
- Unauthenticated: 401
- Unauthorized: 403

## Pagination
- Style: [choose one]
  - **Page-based**: `?page=1&limit=25` --> meta: `{ total, page, limit, totalPages }`
  - **Cursor-based**: `?after=<cursor>&limit=25` --> meta: `{ hasNext, nextCursor }`
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
- Resources: plural nouns (`/users`, `/orders`, `/products`)
- Actions: RESTful (GET list, GET :id, POST, PUT/PATCH :id, DELETE :id)
- Custom actions: verb prefix (`/users/:id/activate`, `/orders/:id/cancel`)
- Nested max depth: 2 levels (`/users/:userId/orders`)
- Query params: camelCase (`?sortBy=createdAt&orderBy=desc`)

## API Documentation
- Tool: [e.g. swagger-jsdoc + swagger-ui-express / none]
- Generate: [e.g. auto-generated from JSDoc annotations]
- Location: [e.g. `/api-docs`]

### Swagger Setup (if using)
```javascript
// src/config/swagger.js
const swaggerJsdoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: { title: 'API', version: '1.0.0' },
    servers: [{ url: '/api/v1' }],
    components: {
      securitySchemes: {
        bearerAuth: { type: 'http', scheme: 'bearer', bearerFormat: 'JWT' }
      }
    }
  },
  apis: ['./src/routes/*.js'],
};

module.exports = swaggerJsdoc(options);
```

## Changelog
<!-- [PROJ-123] Added new API endpoints -->
