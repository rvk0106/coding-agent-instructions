# Agent Instructions — Express.js

Tool-agnostic instruction system for using coding agents safely with Express.js/Node.js.

## Installation
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-express/main/quick-install.sh | bash
```

## Quick start
1) Set up your workflow:
   - Create `agent-config.md` in your project root
   - Choose: Ticketing integration OR manual `tickets/TICKET-ID.md` files
2) Plan: `plan architecture for TICKET-ID` → `docs/TICKET-ID-plan.md`
3) Execute: `execute plan 1 for TICKET-ID`
4) Verify: `npm test && npm run lint`

## License
GNU GPL v3.0
