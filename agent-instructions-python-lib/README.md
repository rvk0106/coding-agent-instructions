# Agent Instructions — Python Library

Tool-agnostic instruction system for developing Python libraries/packages.

## Installation
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-python-lib/main/quick-install.sh | bash
```

## Quick start
1) Plan: `plan library for TICKET-ID` → `docs/TICKET-ID-plan.md`
2) Execute: `execute plan 1 for TICKET-ID`
3) Verify: `pytest && flake8 && mypy`

## License
GNU GPL v3.0
