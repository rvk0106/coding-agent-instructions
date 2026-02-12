# Environment
> Tags: python, django, runtime, versions, venv
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Python: [e.g. 3.10+ / 3.11+ / 3.12+]
- Django: [e.g. 4.2 LTS / 5.0 / 5.1]
- Django REST Framework: [e.g. 3.14+]

## Virtual Environment
- Tool: [e.g. venv / poetry / pipenv / conda]
- Location: [e.g. `.venv/` / managed by poetry]
- Activate: [e.g. `source .venv/bin/activate` / `poetry shell`]

## Database & Services
- Primary DB: [e.g. PostgreSQL / MySQL / SQLite]
- Cache: [e.g. Redis / Memcached / none]
- Task broker: [e.g. Redis (for Celery) / RabbitMQ / none]
- Search: [e.g. Elasticsearch / none]

## OS / Container
- Dev: [e.g. macOS / Docker / devcontainer]
- CI: [e.g. GitHub Actions ubuntu-latest]
- Prod: [e.g. AWS ECS / Heroku / Render / Railway]

## Settings Structure
<!-- Choose your project's settings pattern -->
```python
# Option A: Split settings
project/settings/
├── __init__.py       # imports from base
├── base.py           # shared settings
├── dev.py            # development (DEBUG=True)
└── prod.py           # production (DEBUG=False)
# Use: DJANGO_SETTINGS_MODULE=project.settings.dev

# Option B: django-environ with single file
project/settings.py   # reads from .env file
# Uses: env = environ.Env()
```

## Local Setup
```bash
# Minimum commands to get running
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt           # or: poetry install
python manage.py migrate
python manage.py createsuperuser          # optional
python manage.py runserver
```

## Required Environment Variables
- `SECRET_KEY` -- Django secret key (never commit)
- `DATABASE_URL` -- primary DB connection (if using dj-database-url)
- `ALLOWED_HOSTS` -- comma-separated hostnames
- `DEBUG` -- True/False
- `DJANGO_SETTINGS_MODULE` -- settings module path
- `REDIS_URL` -- cache/Celery broker (if using Redis)
- [Add project-specific vars here]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Upgraded Python 3.10 → 3.12 -->
