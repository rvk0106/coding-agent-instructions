# Database Architecture
> Tags: database, schema, tables, relations, migrations, orm
> Scope: Schema design, key tables, ORM/ODM, migration conventions
> Last updated: [TICKET-ID or date]

## Engine
- Type: [e.g. PostgreSQL / MySQL / MongoDB]
- ORM/ODM: [e.g. Sequelize / Prisma / TypeORM / Mongoose / Knex]
- Schema source: [e.g. `prisma/schema.prisma` / `src/models/` / migrations folder]

## Key Tables / Collections
<!-- List the most important tables and their purpose -->
| Table/Collection | Purpose | Key Columns/Fields |
|------------------|---------|-------------------|
| `users` | User accounts | email, password_hash, role |
| [table] | [purpose] | [columns] |

## Key Relationships
```
users hasMany orders
orders belongsTo users
orders hasMany order_items
[add project-specific relationships]
```

## Indexes
<!-- List important/custom indexes -->
- `users`: unique on `email`
- [table]: [index description]

## Multi-Tenancy
<!-- DELETE this section if your app is single-tenant -->
- Strategy: [e.g. tenant_id column / schema-based]
- Scoping: [e.g. middleware sets tenant context / query filters]
- Tables shared across tenants: [list]
- Tables tenant-scoped: [list]

## Migration Conventions

### Sequelize
```bash
npx sequelize-cli migration:generate --name add-column-to-table
npx sequelize-cli db:migrate
npx sequelize-cli db:migrate:undo        # rollback last
```
- Always add `allowNull: false` for required columns
- Always add indexes for foreign keys
- Always test rollback

### Prisma
```bash
npx prisma migrate dev --name description   # create + apply
npx prisma migrate deploy                   # production apply
npx prisma generate                         # regenerate client
```
- Schema defined in `prisma/schema.prisma`
- Always run `npx prisma generate` after schema changes

### TypeORM
```bash
npx typeorm migration:generate -d src/data-source.ts -n MigrationName
npx typeorm migration:run -d src/data-source.ts
npx typeorm migration:revert -d src/data-source.ts   # rollback
```

### Mongoose (schemaless, no migrations)
- Schema defined in model files (`src/models/`)
- Use `mongoose-migrate` or manual scripts for data migrations

## General Rules
- Always add `NOT NULL` / `allowNull: false` for required columns
- Always add indexes for foreign keys and frequently queried columns
- Always add default values where sensible
- Always test rollback before pushing migration
- Never modify a migration that has been run in production -- create a new one

## Changelog
<!-- [PROJ-123] Added indexes for orders table -->
