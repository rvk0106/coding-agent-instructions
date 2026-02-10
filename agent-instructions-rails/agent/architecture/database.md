# Database Architecture
> Tags: database, schema, tables, relations, migrations
> Scope: Schema design, key tables, relationships
> Last updated: [TICKET-ID or date]

## Engine
- Type: [e.g. PostgreSQL / MySQL / SQLite]
- Schema file: `db/schema.rb` or `db/structure.sql`

## Key Tables
<!-- List the most important tables and their purpose -->
| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `users` | User accounts | email, role |
| [table] | [purpose] | [columns] |

## Key Relationships
```
users has_many :resources
resources belongs_to :user
[add project-specific relationships]
```

## Indexes
<!-- List important/custom indexes -->
- `users`: unique on `[email]`
- [table]: [index description]

## Multi-Tenancy
<!-- DELETE this section if your app is single-tenant -->
- Strategy: [e.g. tenant_id column / schema-based]
- Scoping: [e.g. default_scope / controller before_action]
- Tables shared across tenants: [list]
- Tables tenant-scoped: [list]

## Migration Conventions
- Always add `null: false` for required columns
- Always add indexes for foreign keys
- Always add default values where sensible
- Always test rollback: `rails db:rollback STEP=1`

## Changelog
<!-- [PROJ-123] Added indexes for new table -->
