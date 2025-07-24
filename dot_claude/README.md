# Claude Code Configuration

Personal configuration and development preferences for Claude Code CLI. This directory contains comprehensive settings, custom workflows, and slash commands to enhance development productivity.

## Directory Structure

```
.claude/
├── README.md                 # This documentation
├── CLAUDE.md                # Core development principles and workflows
├── settings.json            # Claude Code permissions and environment settings
├── commands/                # Custom slash commands organized by category
│   ├── code/               # Code analysis, refactoring, and git operations
│   ├── docs/               # Documentation generation and management
│   ├── project/            # Project management and task tracking
│   ├── research/           # Investigation and web research tools
│   └── tool/               # Utility commands and integrations
├── templates/              # Reusable templates for specs and projects
└── backup_comma/           # Archive of previous command iterations
```

## Core Files

### CLAUDE.md

Immutable system rules defining development workflows:

- **Plan-then-execute** methodology for non-trivial tasks
- Modern CLI tool preferences (`rg`, `fd`, `bat`, `eza`, etc.)
- TDD and standard development workflows
- Code standards (TypeScript, naming conventions)

### settings.json

Security-focused permissions and environment configuration:

- Whitelisted bash commands for development tools
- Denied dangerous system operations
- Environment variables (editor preferences, telemetry settings)
- MCP server enablement

## Custom Slash Commands

The `commands/` directory contains 50+ specialized workflows organized by domain:

### Code Operations (`/code/*`)

- **Analysis**: Dependencies, technical debt assessment
- **Refactoring**: Simplification, standardization, general refactoring
- **Git**: Pull requests, merge conflict resolution, branch operations
- **Security**: Code auditing and vulnerability assessment
- **Testing**: Test generation and validation

### Documentation (`/docs/*`)

- **Generation**: Automated documentation creation
- **Management**: Updates, explanations, and decision records
- **Visualization**: Diagram generation and technical illustrations

### Project Management (`/project/*` & `/spec/*`)

- **Lifecycle**: Project creation, task management, execution
- **Specifications**: Requirements gathering, design documentation
- **Status**: Progress tracking and reporting

### Research & Analysis (`/research/*`)

- **Investigation**: Deep-dive analysis workflows
- **Web Research**: Structured information gathering
- **Knowledge Extraction**: Content analysis and synthesis

## Quick Start

```bash
# Configuration is automatically loaded by Claude Code
claude-code --help

# List available slash commands
ls ~/.claude/commands/

# Example: Generate project documentation
claude /docs/document

# Example: Analyze technical debt
claude /code/analyze/technical-debt
```

## Agentic Command Guidelines

**Core Philosophy**: Treat slash commands as executable programs, not conversations.

### Design Principles

- **Deterministic Workflows**: Clear rules and explicit control flow
- **Security First**: Minimal permissions, only necessary tools
- **Dynamic Context**: Real-time data injection with backtick commands
- **Structured Format**: Front matter → Context → Task definition

### Command Structure

```markdown
---
allowed-tools: [specific tools only]
tags: [categorization]
---

# Context and dynamic data injection

`!command` for real-time information

## Task Definition

Clear, executable instructions with examples
```

## Security & Permissions

The configuration enforces strict security boundaries:

- **Allowed**: Development tools, git operations, safe file operations
- **Denied**: System-destructive commands, fork bombs, disk operations
- **Scoped**: Temporary file access limited to `/tmp/claude-*` patterns

## Integration Features

- **Modern CLI Tools**: Preference for `rg`, `fd`, `bat`, `eza` over legacy alternatives
- **Git Worktrees**: Parallel development support
- **GitHub CLI**: Complete GitHub operations via `gh` command
- **Editor Integration**: Zed editor with wait-mode git operations
- **MCP Servers**: Enabled for all projects with auto-discovery

---

_This configuration represents a comprehensive development environment optimized for AI-assisted coding workflows while maintaining security and consistency._
