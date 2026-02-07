# Agent Instructions — Django

A drop-in, tool-agnostic instruction system for using coding agents safely with Django.

## Installation

### Quick install
From your Django project root:
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-django/main/quick-install.sh | bash
```

## Quick start
1) Install and connect to ticketing system
2) Plan: `plan architecture for TICKET-ID` → saves to `docs/TICKET-ID-plan.md`
3) Execute: `execute plan 1 for TICKET-ID`
4) Verify: `python manage.py test && flake8`
5) Stop and wait for review

## Recommended loop
Connect → Plan → Execute Phase N → Verify → Stop → Repeat

## License
GNU General Public License v3.0 - see [LICENSE](LICENSE)
