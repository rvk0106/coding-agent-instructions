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
| [e.g. Account] | [Top-level entity -- org, workspace, or user account] | [models, controllers, services] |
| [e.g. Resource] | [Primary domain object your API manages] | [models, services, API] |
| [e.g. Membership] | [Relationship between user and account/group] | [models, services] |

## Role Definitions
| Role | Can Do | Cannot Do |
|------|--------|-----------|
| admin | Full CRUD, manage users, system config | - |
| manager | Manage own org's resources | Cross-org access, system config |
| member | Read, limited write | Delete, admin functions |
| viewer | Read only | Any writes |

## Status Definitions
<!-- If your models have status fields, define them here -->
| Model | Statuses | Transitions |
|-------|----------|-------------|
| [e.g. Order] | draft, confirmed, shipped, completed | draft-->confirmed-->shipped-->completed |
| [e.g. User] | pending, active, suspended | pending-->active<-->suspended |

## Abbreviations
| Abbr | Meaning |
|------|---------|
| JWT | JSON Web Token |
| RBAC | Role-Based Access Control |
| ORM | Object-Relational Mapping |
| ODM | Object-Document Mapping |

## Changelog
<!-- [PROJ-123] Added "Resource" term for new feature -->
