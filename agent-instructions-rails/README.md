# Agent Instructions — Rails

A drop-in, tool-agnostic instruction system for using coding agents safely with Rails.

## What this is
- A set of reusable instruction files that enforce plan-first execution, phase isolation, and human review.
- Works with Claude, ChatGPT, Cursor, Copilot, and other tools.

## What this is not
- Not an agent framework or library.
- Not a replacement for engineering judgment.

## Installation

### Method 1: Quick install (recommended)
From your Rails project root:
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-rails/main/quick-install.sh | bash
```

### Method 2: Specify custom directory
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-rails/main/quick-install.sh | bash -s /path/to/your/rails/project
```

### Method 3: Clone and install
```bash
# Clone the repository
git clone https://github.com/rvk0106/agent-instructions-rails.git /tmp/agent-instructions-rails

# Run installer from your Rails project root
cd /path/to/your/rails/project
/tmp/agent-instructions-rails/install.sh .

# Clean up
rm -rf /tmp/agent-instructions-rails
```

### Method 4: Download as archive
```bash
wget https://github.com/rvk0106/agent-instructions-rails/archive/refs/heads/main.tar.gz
tar -xzf main.tar.gz
cd agent-instructions-rails-main
./install.sh /path/to/your/rails/project
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
agent-instructions-rails/
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
├── tool-adapters/
│   ├── claude.md
│   ├── cursor.md
│   ├── copilot.md
│   └── chatgpt.md
└── LICENSE
```

## Recommended loop
1) **Connect** → to ticketing system (Linear/Jira via MCP or API token)
2) **Plan** → fetch ticket and create phase-based plan in `docs/TICKET-ID-plan.md`
3) **Execute Phase N** → read from `docs/TICKET-ID-plan.md` and implement only that phase
4) **Verify** → run tests/lint/contract checks specified in the phase
5) **Stop** → wait for human review and approval
6) **Repeat** → continue to Phase N+1 after approval

## Uninstall
To remove agent instructions from your project:
```bash
# Remove the agent directory
rm -rf agent/

# Remove markers from tool config files
# Manually edit these files and remove blocks between:
# >>> agent-instructions-rails
# <<< agent-instructions-rails
# Files: .github/copilot-instructions.md, .cursorrules, CLAUDE.md
```

## Contributing
Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

This means you are free to:
- Use this software for any purpose
- Change the software to suit your needs
- Share the software with others
- Share the changes you make

Under the condition that:
- Any modifications or derivative works must also be licensed under GPL-3.0
- Source code must be made available when distributing the software

## Notes
- Human review and approval are non-negotiable.
- If any referenced instruction files are unavailable, the agent must request them from the user.
- Plans are saved to `docs/` folder - commit them to version control for team visibility.

## Support
Issues and feature requests: [GitHub Issues](https://github.com/rvk0106/agent-instructions-rails/issues)
