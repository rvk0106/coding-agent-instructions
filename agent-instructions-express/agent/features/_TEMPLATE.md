# Feature: [Feature Name]
> Tags: [relevant, keywords]
> Scope: [what this feature covers]
> Status: [active / deprecated / planned]

## Summary
<!-- 1-2 sentences: what this feature does -->

## How It Works
<!-- Step-by-step flow, keep it concise -->
1. [Step]
2. [Step]
3. [Step]

## Key Components
| Component | Location | Purpose |
|-----------|----------|---------|
| Route | `src/routes/...` | [endpoint definitions] |
| Controller | `src/controllers/...` | [request handling] |
| Service | `src/services/...` | [business logic] |
| Model | `src/models/...` | [data definition] |
| Middleware | `src/middleware/...` | [validation/auth] |

## API Endpoints
| Method | Path | Auth | Description |
|--------|------|:----:|-------------|
| GET | `/api/v1/...` | Yes | [description] |
| POST | `/api/v1/...` | Yes | [description] |

## Database Tables (if applicable)
- `table_name` --> [what it stores]
- Key columns: [list important ones]

## Middleware Used
- Authentication: [yes/no, which middleware]
- Validation: [schema file/location]
- Rate limiting: [yes/no]

## Business Rules
- [Rule 1]
- [Rule 2]

## Edge Cases / Gotchas
- [Thing to watch out for]
- [Known limitation]

## Tests
- API tests: `src/__tests__/routes/...`
- Service tests: `src/__tests__/services/...`
- Middleware tests: `src/__tests__/middleware/...`
