# System Design
> Tags: architecture, components, data-flow, high-level
> Scope: How the system is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this app does -->
[Describe what this app does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual stack -->
```
[Client] --> [Load Balancer / Reverse Proxy] --> [Express API] --> [Database]
                                                                --> [Cache] (if used)
                                                                --> [Queue] (if used)
                                                                --> [File Storage] (if used)
```
- Database: [e.g. PostgreSQL / MySQL / MongoDB]
- Cache: [e.g. Redis / Memcached / none]
- Queue: [e.g. BullMQ / RabbitMQ / SQS / none]
- Storage: [e.g. S3 / local disk / none]

## Project Structure
```
src/
  routes/          --> route definitions (thin, delegate to controllers)
  controllers/     --> request/response handling
  services/        --> business logic
  models/          --> data models (Sequelize, Prisma, Mongoose, TypeORM)
  middleware/       --> auth, validation, logging, error handling
  utils/           --> helper functions
  config/          --> app config, DB config, env loading
  types/           --> TypeScript interfaces/types (if TS)
```

## Tenancy Model
<!-- DELETE this section if your app is single-tenant -->
- [e.g. tenant scoping via tenant_id / schema-based multi-tenancy]
- Tenant resolution: [e.g. subdomain / header / path param]

## Authentication
- Method: [e.g. JWT (jsonwebtoken) / Passport.js / session (express-session) / API key]
- Token flow: [e.g. login --> access_token + refresh_token / session cookie]
- Library: [e.g. jsonwebtoken / passport / passport-jwt]

## Authorization
- Strategy: [e.g. middleware-based RBAC / CASL / custom / none]
- Roles: [e.g. admin, manager, member, viewer]
- Pattern: [e.g. role-checking middleware in src/middleware/authorize.js]

## Key Data Flows
<!-- Describe 2-3 critical flows -->
1. **User Registration**: POST /api/v1/auth/register --> validate input --> hash password --> create user --> return JWT
2. **[Flow Name]**: [step] --> [step] --> [step]
3. **[Flow Name]**: [step] --> [step] --> [step]

## Changelog
<!-- [PROJ-123] Added webhook processing pipeline -->
