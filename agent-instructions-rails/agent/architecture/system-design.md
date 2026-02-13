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
[Browser] → [Load Balancer / Reverse Proxy] → [Rails App] → [Database]
                                                            → [Cache] (if used)
                                                            → [Background Jobs] (if used)
                                                            → [File Storage] (if used)
```
- Database: [e.g. PostgreSQL / MySQL / SQLite]
- Cache: [e.g. Redis / Memcached / SolidCache / none]
- Jobs: [e.g. Sidekiq / GoodJob / SolidQueue / none]
- Storage: [e.g. S3 / ActiveStorage local / none]
- Asset pipeline: [e.g. Propshaft / Sprockets]
- JS bundling: [e.g. importmap / esbuild / webpack / none]
- CSS framework: [e.g. Tailwind / Bootstrap / custom / none]

## Frontend Stack
- Template engine: [e.g. ERB / Haml / Slim]
- Hotwire: [e.g. Turbo Drive + Turbo Frames + Turbo Streams / none]
- Stimulus: [e.g. Stimulus controllers in app/javascript/controllers/ / none]
- Real-time: [e.g. ActionCable / Turbo Streams over WebSocket / none]

## Tenancy Model
<!-- DELETE this section if your app is single-tenant -->
- [e.g. account scoping via tenant_id / schema-based multi-tenancy]
- Tenant resolution: [e.g. subdomain / header / path]

## Authentication
- Method: [e.g. Devise / custom session-based / OmniAuth / none]
- Session store: [e.g. cookie / Redis / DB / ActiveRecord session store]
- Flow: [e.g. login form → create session → cookie → authenticate_user!]

## Authorization
- Library: [e.g. Pundit / CanCanCan / custom / none]
- Roles: [e.g. admin, manager, member, viewer]
- Pattern: [e.g. policy objects in app/policies/ / ability class / inline checks]

## Key Data Flows
<!-- Describe 2-3 critical flows -->
1. **User Registration**: signup form → create user → send verification email → redirect to dashboard
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added webhook processing pipeline -->
