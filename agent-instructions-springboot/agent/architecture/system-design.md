# System Design
> Tags: architecture, components, data-flow, high-level
> Scope: How the system is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this app does -->
[Describe what this application does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual stack -->
```
[Client] --> [Load Balancer / Reverse Proxy] --> [Spring Boot API] --> [Database]
                                                                   --> [Cache] (if used)
                                                                   --> [Message Broker] (if used)
                                                                   --> [File Storage] (if used)
```
- Database: [e.g. PostgreSQL / MySQL / H2 (dev only)]
- Cache: [e.g. Redis / Caffeine / EhCache / none]
- Message Broker: [e.g. RabbitMQ / Kafka / none]
- Storage: [e.g. S3 / MinIO / local filesystem / none]
- Search: [e.g. Elasticsearch / OpenSearch / none]

## Tenancy Model
<!-- DELETE this section if your app is single-tenant -->
- [e.g. tenant_id column scoping / schema-based multi-tenancy / Hibernate multi-tenancy]
- Tenant resolution: [e.g. subdomain / X-Tenant-ID header / path parameter]

## Authentication
- Method: [e.g. JWT / OAuth2 / Spring Session / API key]
- Token flow: [e.g. login --> access_token + refresh_token / OAuth2 authorization code flow]
- Library: [e.g. Spring Security with spring-boot-starter-oauth2-resource-server / custom JWT filter]

## Authorization
- Library: [e.g. Spring Security method-level / @PreAuthorize / custom AccessDecisionVoter]
- Roles: [e.g. ROLE_ADMIN, ROLE_MANAGER, ROLE_USER, ROLE_VIEWER]
- Pattern: [e.g. @PreAuthorize annotations on service methods / SecurityFilterChain URL-based rules]

## Key Data Flows
<!-- Describe 2-3 critical flows -->
1. **User Registration**: POST /api/auth/register --> validate --> create user --> hash password --> return JWT
2. **[Flow Name]**: [step] --> [step] --> [step]
3. **[Flow Name]**: [step] --> [step] --> [step]

## Changelog
<!-- [PROJ-123] Added webhook processing pipeline -->
