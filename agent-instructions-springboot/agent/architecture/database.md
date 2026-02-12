# Database Architecture
> Tags: database, schema, tables, relations, migrations, jpa, hibernate
> Scope: Schema design, key tables, JPA conventions, migration strategy
> Last updated: [TICKET-ID or date]

## Engine
- Type: [e.g. PostgreSQL / MySQL / H2 (dev only)]
- ORM: JPA / Hibernate (via spring-boot-starter-data-jpa)
- DDL strategy: [e.g. Flyway / Liquibase / hibernate.ddl-auto=validate]

## Key Tables
<!-- List the most important tables and their purpose -->
| Table | Entity Class | Purpose | Key Columns |
|-------|-------------|---------|-------------|
| `users` | `User` | User accounts | email, password_hash, role |
| [table] | [Entity] | [purpose] | [columns] |

## Key Relationships
```
User @OneToMany --> Resource
Resource @ManyToOne --> User
Resource @ManyToMany --> Tag
[add project-specific relationships]
```

## Indexes
<!-- List important/custom indexes -->
- `users`: unique on `email`
- [table]: [index description]

## Multi-Tenancy
<!-- DELETE this section if your app is single-tenant -->
- Strategy: [e.g. discriminator column (tenant_id) / separate schemas / separate databases]
- Implementation: [e.g. Hibernate @TenantId / custom filter / Spring Data specification]
- Tables shared across tenants: [list]
- Tables tenant-scoped: [list]

## JPA / Hibernate Conventions
- Entity classes in: `src/main/java/.../model/` or `.../entity/`
- Use `@Entity`, `@Table(name = "...")` explicitly
- Primary key: `@Id @GeneratedValue(strategy = GenerationType.IDENTITY)` (or SEQUENCE for PostgreSQL)
- Audit fields: `createdAt`, `updatedAt` via `@EntityListeners(AuditingEntityListener.class)` or `@CreationTimestamp` / `@UpdateTimestamp`
- Relationships: always set `fetch = FetchType.LAZY` (override to EAGER only when justified)
- Cascade: be explicit -- avoid `CascadeType.ALL` unless intended
- Use `@Column(nullable = false)` for required fields
- Avoid `@Data` (Lombok) on entities -- use `@Getter @Setter` to prevent hashCode/equals issues

## Migration Conventions
- Tool: [e.g. Flyway / Liquibase]
- Location: [e.g. `src/main/resources/db/migration/` (Flyway) or `src/main/resources/db/changelog/` (Liquibase)]
- Naming: [e.g. `V1__create_users_table.sql` (Flyway) or `001-create-users.xml` (Liquibase)]
- Always add `NOT NULL` for required columns
- Always add indexes for foreign keys
- Always add default values where sensible
- Always test rollback: verify migration can be reversed cleanly
- Never modify an already-applied migration -- create a new one

## Changelog
<!-- [PROJ-123] Added indexes for enrollment table -->
