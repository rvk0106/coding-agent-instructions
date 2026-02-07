# Agent Instructions — Spring Boot

A drop-in, tool-agnostic instruction system for using coding agents safely with Spring Boot.

## What this is
- A set of reusable instruction files that enforce plan-first execution, phase isolation, and human review.
- Works with Claude, ChatGPT, Cursor, Copilot, and other tools.

## What this is not
- Not an agent framework or library.
- Not a replacement for engineering judgment.

## Installation

### Method 1: Quick install (recommended)
From your Spring Boot project root:
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-springboot/main/quick-install.sh | bash
```

### Method 2: Clone and install
```bash
git clone https://github.com/rvk0106/agent-instructions-springboot.git /tmp/agent-instructions-springboot
cd /path/to/your/springboot/project
/tmp/agent-instructions-springboot/install.sh .
rm -rf /tmp/agent-instructions-springboot
```

## Quick start
1) Install (see above methods)
2) Connect to your ticketing system:
   - Set up Linear API token: `export LINEAR_API_TOKEN="your_token"`
   - Or configure MCP server
3) Start planning:
   - Command: `plan architecture for TICKET-ID`
   - Output: `docs/TICKET-ID-plan.md`
4) Execute one phase at a time:
   - Command: `execute plan 1 for TICKET-ID`
   - Agent reads from `docs/TICKET-ID-plan.md`
5) Verify, review, and approve before continuing.

## Repository layout
```
agent-instructions-springboot/
├── README.md
├── install.sh
├── agent/
│   ├── master-instructions.md
│   ├── principles-and-standards.md
│   ├── ticket-access.md
│   ├── planner-instructions.md
│   ├── execution-contract.md
│   ├── implementer-instructions.md
│   ├── testing-instructions.md
│   └── examples/
│       └── sample-ticket-plan.md
└── LICENSE
```

## Recommended loop
1) **Connect** → to ticketing system (Linear/Jira via MCP or API token)
2) **Plan** → fetch ticket and create phase-based plan in `docs/TICKET-ID-plan.md`
3) **Execute Phase N** → read from `docs/TICKET-ID-plan.md` and implement only that phase
4) **Verify** → run tests/build/checkstyle specified in the phase
5) **Stop** → wait for human review and approval
6) **Repeat** → continue to Phase N+1 after approval

## Uninstall
```bash
rm -rf agent/
# Manually remove markers from IDE config files
```

## Contributing
Contributions are welcome! Please fork, create a feature branch, and submit a pull request.

## License
GNU General Public License v3.0 - see [LICENSE](LICENSE)

## Support
Issues: [GitHub Issues](https://github.com/rvk0106/agent-instructions-springboot/issues)
