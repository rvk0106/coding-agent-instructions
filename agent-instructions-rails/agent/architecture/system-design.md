# System Design
> Tags: architecture, components, data-flow, high-level
> Scope: How the system is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this app does -->
[e.g. Multi-tenant SaaS API serving a React frontend. Handles user management, billing, and content delivery.]

## Key Components
```
[Client] → [Load Balancer] → [Rails API] → [PostgreSQL]
                                          → [Redis] (cache + jobs)
                                          → [Sidekiq] (background)
                                          → [S3] (file storage)
```

## Tenancy Model
- [e.g. Schema-based multi-tenancy / single-tenant / account scoping]
- Tenant resolution: [e.g. subdomain / header / path]

## Authentication
- Method: [e.g. JWT / session / Devise + JWT]
- Token flow: [e.g. login → access_token (15m) + refresh_token (7d)]

## Authorization
- Library: [e.g. Pundit / CanCanCan / custom]
- Roles: [e.g. admin, manager, member, viewer]
- Pattern: [e.g. policy objects in app/policies/]

## Key Data Flows
<!-- Describe 2-3 critical flows -->
1. **User Registration**: signup → create user → send verification email → activate
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added webhook processing pipeline -->
