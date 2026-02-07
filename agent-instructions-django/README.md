# Agent Instructions — Django

A drop-in, tool-agnostic instruction system for using coding agents safely with Django.

## Installation

### Quick install
From your Django project root:
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-django/main/quick-install.sh | bash
```

## Quick start
1) Install (see above)
2) Set up your workflow:
   - Create `agent-config.md` in your project root
   - Choose your ticket source:
     - **Option A**: Configure ticketing integration (Linear, Jira, GitHub Issues)
     - **Option B**: Create `tickets/` folder and add `TICKET-ID.md` files manually
3) Plan: `plan architecture for TICKET-ID` → saves to `docs/TICKET-ID-plan.md`
4) Execute: `execute plan 1 for TICKET-ID`
5) Verify: `python manage.py test && flake8`
6) Stop and wait for review

## Recommended loop
Connect → Plan → Execute Phase N → Verify → Stop → Repeat

## License
GNU General Public License v3.0 - see [LICENSE](LICENSE)
