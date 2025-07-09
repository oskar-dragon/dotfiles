# Claude Code Configuration

Personal configuration and development preferences for Claude Code CLI.

## Quick Start

```bash
# Configuration is automatically loaded by Claude Code
claude-code --help
```

## Agentic Prompt Guidelines

**TL;DR:** Treat slash commands as executable programs, not conversations. Use minimal permissions, and explicit control flow.

### Core Principles

- **Think "Program" not "Conversation"** - Design deterministic workflows with clear rules, and explicit control flow.
- **Security First** - Only allow necessary tools with minimal permissions
- **Programming Constructs** - Use explicit control flow: sequential steps, conditionals etc.

### Key Requirements

2. **Dynamic Context** - Use `!`command`` for real-time data injection
3. **Minimal Permissions** - Only allow required commands in `allowed-tools`
4. **Clear Structure** - Front matter → Context → Task definition with examples

See the full guidelines in `.claude/commands/improve-slash-commands.md`.
