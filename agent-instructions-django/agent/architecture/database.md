# Database Architecture
> Tags: database, schema, models, relations, migrations, django-orm
> Scope: Schema design, key models, relationships, migration conventions
> Last updated: [TICKET-ID or date]

## Engine
- Type: [e.g. PostgreSQL / MySQL / SQLite]
- Django ORM: Models define schema (no separate schema file)
- Migrations: `apps/*/migrations/` (auto-generated, version-controlled)

## Key Models
<!-- List the most important models and their purpose -->
| Model | App | Purpose | Key Fields |
|-------|-----|---------|------------|
| `User` | users | User accounts | email, username, is_active |
| [Model] | [app] | [purpose] | [fields] |

## Key Relationships
```python
# ForeignKey (many-to-one)
class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='orders')

# ManyToManyField
class Product(models.Model):
    tags = models.ManyToManyField(Tag, related_name='products')

# OneToOneField
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')

# [Add project-specific relationships]
```

## Indexes
<!-- List important/custom indexes -->
```python
class Meta:
    indexes = [
        models.Index(fields=['email'], name='idx_user_email'),
        models.Index(fields=['created_at', 'status'], name='idx_order_created_status'),
    ]
    constraints = [
        models.UniqueConstraint(fields=['email'], name='unique_user_email'),
    ]
```
- `User`: unique on `email`
- [Model]: [index description]

## Custom Managers and QuerySets
```python
# Custom manager for reusable query logic
class ActiveManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(is_active=True)

class Resource(models.Model):
    objects = models.Manager()       # default
    active = ActiveManager()         # Resource.active.all()
```

## Migration Conventions
- Generate: `python manage.py makemigrations`
- Apply: `python manage.py migrate`
- Check pending: `python manage.py makemigrations --check --dry-run`
- Squash: `python manage.py squashmigrations app_name start_migration end_migration`
- **Rules:**
  - Always add `null=False` for required columns (use `default=` or data migration)
  - Always add `db_index=True` for frequently queried fields
  - Always add indexes for ForeignKey fields (Django adds automatically)
  - Always add `on_delete=` explicitly for ForeignKey/OneToOneField
  - Never edit existing migration files -- always create new ones
  - Always test migrations: `python manage.py migrate` then `python manage.py migrate app_name zero` (verify rollback)
  - Use `RunPython` for data migrations, keep separate from schema migrations

## Multi-Tenancy
<!-- DELETE this section if your app is single-tenant -->
- Strategy: [e.g. tenant_id column / schema-based via django-tenants]
- Scoping: [e.g. custom manager filtering by tenant / middleware setting tenant context]
- Models shared across tenants: [list]
- Models tenant-scoped: [list]

## Changelog
<!-- [PROJ-123] Added indexes for orders table -->
