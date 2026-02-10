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
[Client] → [Load Balancer / Reverse Proxy] → [Rails API] → [Database]
                                                           → [Cache] (if used)
                                                           → [Background Jobs] (if used)
                                                           → [File Storage] (if used)
```
- Database: [e.g. PostgreSQL / MySQL / SQLite]
- Cache: [e.g. Redis / Memcached / none]
- Jobs: [e.g. Sidekiq / GoodJob / SolidQueue / none]
- Storage: [e.g. S3 / ActiveStorage local / none]

## Tenancy Model
<!-- DELETE this section if your app is single-tenant -->
- [e.g. account scoping via tenant_id / schema-based multi-tenancy]
- Tenant resolution: [e.g. subdomain / header / path]

## Authentication
- Method: [e.g. JWT / session / Devise + JWT / API key / OAuth2]
- Token flow: [e.g. login → access_token + refresh_token / session cookie]

## Authorization
- Library: [e.g. Pundit / CanCanCan / custom / none]
- Roles: [e.g. admin, manager, member, viewer]
- Pattern: [e.g. policy objects in app/policies/ / ability class / inline checks]

## Key Data Flows
<!-- Describe 2-3 critical flows -->
1. **User Registration**: signup → create user → send verification email → activate
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added webhook processing pipeline -->
