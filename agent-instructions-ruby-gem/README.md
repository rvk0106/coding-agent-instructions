# Agent Instructions — Ruby Gem

Tool-agnostic instruction system for developing Ruby gems/libraries.

## Installation
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-ruby-gem/main/quick-install.sh | bash
```

## Quick start
1) Set up your workflow:
   - Create `agent-config.md` in your project root
   - Choose: Ticketing integration OR manual `tickets/TICKET-ID.md` files
2) Plan: `plan gem for TICKET-ID` → `docs/TICKET-ID-plan.md`
3) Execute: `execute plan 1 for TICKET-ID`
4) Verify: `bundle exec rspec && bundle exec rubocop`

## License
GNU GPL v3.0
