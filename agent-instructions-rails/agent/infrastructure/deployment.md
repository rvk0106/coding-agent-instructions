# Deployment
> Tags: deploy, hosting, environments, infra
> Scope: How the app is deployed and where
> Last updated: [TICKET-ID or date]

## Environments
| Env | URL | Branch | Deploy Method |
|-----|-----|--------|---------------|
| Dev | localhost:3000 | any | manual |
| Staging | [url] | [branch] | [auto/manual] |
| Production | [url] | main | [auto/manual] |

## Deploy Process
- [e.g. Push to main -> GitHub Actions -> Docker build -> ECS deploy]
- [e.g. `git push heroku main`]
- Migrations: [auto-run on deploy? manual step?]
- Assets: [precompiled during deploy? CDN?]
- Rollback: [process for rollback]

## Secrets Management
- Method: [e.g. Rails credentials / ENV vars / AWS Secrets Manager]
- Edit: `rails credentials:edit --environment production`

## Infrastructure Notes
- [e.g. Multi-tenant via schema-based isolation]
- [e.g. Load balancer in front, sticky sessions disabled]
- [e.g. Background jobs run on separate worker dynos]
- [e.g. Assets served via CDN]

## Changelog
<!-- [PROJ-123] Migrated from Heroku to AWS ECS -->
