# Database Architecture
> Tags: database, schema, tables, relations, migrations
> Scope: Schema design, key tables, relationships
> Last updated: [TICKET-ID or date]

## Engine
- Type: [e.g. PostgreSQL 15.x]
- Schema file: `db/schema.rb` or `db/structure.sql`

## Key Tables
<!-- List the most important tables and their purpose -->
| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `users` | User accounts | email, role, tenant_id |
| `organizations` | Tenant accounts | name, slug, plan |
| [table] | [purpose] | [columns] |

## Key Relationships
```
organizations has_many :users
users has_many :posts
users belongs_to :organization
[add project-specific relationships]
```

## Indexes
<!-- List important/custom indexes -->
- `users`: unique on `[email]`, index on `[tenant_id]`
- [table]: [index description]

## Multi-Tenancy (if applicable)
- Strategy: [e.g. tenant_id column / schema-based / none]
- Scoping: [e.g. default_scope / controller before_action]
- Tables shared across tenants: [list]
- Tables tenant-scoped: [list]

## Migration Conventions
- Always add `null: false` for required columns
- Always add indexes for foreign keys
- Always add default values where sensible
- Always test rollback: `rails db:rollback STEP=1`

## Changelog
<!-- [PROJ-123] Added programs table with parent_id for hierarchy -->
