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
| Model | `apps/app_name/models.py` | [what it does] |
| Serializer | `apps/app_name/serializers.py` | [what it does] |
| ViewSet | `apps/app_name/views.py` | [what it does] |
| Permission | `apps/app_name/permissions.py` | [what it does] |
| Task | `apps/app_name/tasks.py` | [what it does] |

## API Endpoints
| Method | Path | Auth | Permission | Description |
|--------|------|:----:|:----------:|-------------|
| GET | `/api/v1/...` | Yes | IsAuthenticated | [description] |
| POST | `/api/v1/...` | Yes | IsAuthenticated | [description] |

## Serializers
| Serializer | Used For | Key Fields |
|------------|----------|------------|
| [Name]Serializer | List/Create | [fields] |
| [Name]DetailSerializer | Retrieve/Update | [fields] |

## Models / Database
- `table_name` -> [what it stores]
- Key fields: [list important ones]
- Relationships: [ForeignKey, ManyToMany, etc.]

## Permissions
- [Who can do what]
- Permission class: [class name and location]

## Business Rules
- [Rule 1]
- [Rule 2]

## Edge Cases / Gotchas
- [Thing to watch out for]
- [Known limitation]

## Tests
- View tests: `apps/app_name/tests/test_views.py`
- Model tests: `apps/app_name/tests/test_models.py`
- Serializer tests: `apps/app_name/tests/test_serializers.py`
