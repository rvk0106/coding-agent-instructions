# Glossary & Domain Terms
> Tags: glossary, domain, terms, definitions
> Scope: Project-specific terminology agents must understand
> Last updated: [TICKET-ID or date]

## Instructions
Fill this in with your project's domain terms. Agents read this before planning
to avoid misinterpreting requirements.

## Domain Terms
<!-- Add your project-specific terms below -->

| Term | Definition | Used In |
|------|-----------|---------|
| [e.g. Account] | [Top-level entity -- org, workspace, or user account] | [model, service, controller] |
| [e.g. Resource] | [Primary domain object your API manages] | [model, service, API] |
| [e.g. Enrollment] | [Relationship between user and a course/group] | [model, service] |

## Role Definitions
| Role | Can Do | Cannot Do |
|------|--------|-----------|
| ROLE_ADMIN | Full CRUD, manage users, system config | - |
| ROLE_MANAGER | Manage own org's resources | Cross-org access, system config |
| ROLE_USER | Read, limited write on own resources | Delete, admin functions |
| ROLE_VIEWER | Read only | Any writes |

## Status Definitions
<!-- If your entities have status fields, define them here -->
| Entity | Statuses | Transitions |
|--------|----------|-------------|
| [e.g. Order] | DRAFT, CONFIRMED, SHIPPED, COMPLETED | DRAFT-->CONFIRMED-->SHIPPED-->COMPLETED |
| [e.g. User] | PENDING, ACTIVE, SUSPENDED | PENDING-->ACTIVE<-->SUSPENDED |

## Abbreviations
| Abbr | Meaning |
|------|---------|
| [e.g. JWT] | JSON Web Token |
| [e.g. DTO] | Data Transfer Object |
| [e.g. JPA] | Java Persistence API |
| [e.g. RBAC] | Role-Based Access Control |

## Changelog
<!-- [PROJ-123] Added "Enrollment" term for new feature -->
