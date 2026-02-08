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
| [e.g. Organization] | [Top-level tenant account] | [models, controllers, policies] |
| [e.g. Program] | [A structured learning path] | [models, services] |
| [e.g. Enrollment] | [User's registration in a program] | [models, API] |
| [e.g. Cohort] | [A group of users in a program] | [models, services] |

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
| [e.g. Program] | draft, active, archived | draft→active→archived |
| [e.g. User] | pending, active, suspended | pending→active↔suspended |

## Abbreviations
| Abbr | Meaning |
|------|---------|
| [e.g. LMS] | Learning Management System |
| [e.g. SSO] | Single Sign-On |

## Changelog
<!-- [PROJ-123] Added "Cohort" term for new grouping feature -->
