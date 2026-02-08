# Tool adapters (all agents)

Short, agent-specific setup notes so the same instruction set works in **Cursor**, **GitHub Copilot**, **Claude Code**, **Windsurf**, **ChatGPT**, and other AI coding tools.

After you run `install.sh` for your framework, the installer writes pointers into each tool’s expected file. You usually don’t need to do anything else. Use these adapters as reference if you install manually or need to troubleshoot.

| Adapter | File | Used by |
|--------|------|--------|
| [cursor.md](cursor.md) | `.cursorrules`, `.cursor/rules/*.mdc` | Cursor |
| [copilot.md](copilot.md) | `.github/copilot-instructions.md` | GitHub Copilot |
| [claude.md](claude.md) | `CLAUDE.md` | Claude Code |
| [windsurf.md](windsurf.md) | `.windsurfrules` | Windsurf (Codeium) |
| [chatgpt.md](chatgpt.md) | (manual paste or AGENTS.md) | ChatGPT and others |

See **[docs/AGENT-COMPATIBILITY.md](../docs/AGENT-COMPATIBILITY.md)** for the full compatibility matrix and uninstall steps.
