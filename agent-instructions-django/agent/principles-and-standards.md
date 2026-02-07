# Principles & Standards — Django

## Core principles
- Plan first, execute in phases, verify, stop for review
- Agents are collaborators, not autonomous

## Django-specific standards
- Follow Django conventions and best practices
- Use Django ORM efficiently
- DRF for REST APIs
- Testing with Django TestCase

## Design patterns
- **MVT pattern**: Models, Views, Templates (or ViewSets for API)
- **Fat models, thin views**: Business logic in models or services
- **Serializers**: DRF for validation and serialization
- **Class-based views** or ViewSets for DRY code
- **Permissions**: Separate authorization logic

## Quality checklist
- Tests for all new code
- Migrations for schema changes
- DRF serializer validation
- Permission classes applied
- No N+1 queries (use select_related/prefetch_related)
- Flake8 compliance
