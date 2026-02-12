# Deployment
> Tags: deploy, hosting, environments, infra, gunicorn, docker
> Scope: How the app is deployed and where
> Last updated: [TICKET-ID or date]

## Environments
| Env | URL | Branch | Deploy Method |
|-----|-----|--------|---------------|
| Dev | localhost:8000 | any | manual |
| Staging | [url] | [branch] | [auto/manual] |
| Production | [url] | main | [auto/manual] |

## WSGI / ASGI Server
- **WSGI**: gunicorn (`gunicorn project.wsgi:application --workers 4`)
- **ASGI**: uvicorn (`uvicorn project.asgi:application --host 0.0.0.0 --port 8000`) or daphne
- Which this project uses: [WSGI / ASGI]

## Deploy Process
- [e.g. Push to main → GitHub Actions → Docker build → ECS deploy]
- [e.g. `git push heroku main`]
- Static files: `python manage.py collectstatic --noinput`
- Migrations: [auto-run on deploy? manual step?]
- Rollback: [process for rollback]

## Docker (if used)
```dockerfile
# Example Dockerfile structure
FROM python:3.12-slim
WORKDIR /app
COPY requirements/ requirements/
RUN pip install -r requirements/prod.txt
COPY . .
RUN python manage.py collectstatic --noinput
CMD ["gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000"]
```

## Secrets Management
- Method: [e.g. django-environ + .env / AWS Secrets Manager / Vault / Heroku config vars]
- Local: `.env` file (never commit; `.env.example` for reference)
- Production: [environment variable source]

## Migration on Deploy
```bash
# Run before starting the new version:
python manage.py migrate --noinput
# If zero-downtime needed: ensure migrations are backward-compatible
```

## Infrastructure Notes
- [e.g. Multi-tenant via tenant_id column scoping]
- [e.g. Load balancer with health check at /api/health/]
- [e.g. Celery workers run on separate containers]
- [e.g. Static files served via whitenoise or S3 + CloudFront]

## Changelog
<!-- [PROJ-123] Migrated from Heroku to AWS ECS -->
