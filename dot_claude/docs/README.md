# Claude Slash Commands Documentation

**Version:** 2.0
**Last Updated:** 2025-07-22
**Total Commands:** 41 active commands

## Overview

This directory contains a comprehensive ecosystem of custom slash commands designed to enhance development workflows with Claude Code. Commands are organized by functional namespace and follow strict security and quality standards.

## Quick Start

### Basic Usage

```bash
/command-name [arguments]
```

### Popular Commands

- `/bug-fix [description]` - Diagnose and fix bugs systematically
- `/pr [action]` - Create and manage GitHub pull requests
- `/investigate [topic]` - Research topics with codebase analysis
- `/document [type]` - Generate project documentation
- `/dependencies` - Analyze project dependencies for security and updates

## Command Namespaces

| Namespace                  | Commands | Purpose                                     |
| -------------------------- | -------- | ------------------------------------------- |
| **[agent/](agent/)**       | 1        | Browser automation and testing              |
| **[analyze/](analyze/)**   | 6        | Code analysis, research, and thinking tools |
| **[code/](code/)**         | 12       | Development workflows and code management   |
| **[docs/](docs/)**         | 2        | Documentation generation and analysis       |
| **[git/](git/)**           | 2        | Version control operations                  |
| **[github/](github/)**     | 1        | GitHub platform integration                 |
| **[meta/](meta/)**         | 4        | Command ecosystem management                |
| **[project/](project/)**   | 5        | Project lifecycle management                |
| **[scaffold/](scaffold/)** | 1        | Project setup and initialization            |
| **[security/](security/)** | 1        | Security auditing and analysis              |
| **[test/](test/)**         | 1        | Test generation and automation              |
| **[tool/](tool/)**         | 5        | Development utilities and helpers           |

## Security Model

### Tool Permissions

Commands use **least-privilege access** with specific tool permissions:

#### ✅ Secure Pattern

```yaml
allowed-tools: Bash(git:*), Bash(npm:*), Read, Write, Edit
```

#### ❌ Insecure Pattern

```yaml
allowed-tools: [Bash, Read, Write, Edit] # Unrestricted shell access
```

### Security Levels

- **🟢 Restricted**: File operations only (Read, Write, Edit)
- **🟡 Controlled**: Specific command access (Bash(git:\*))
- **🔴 Elevated**: Multiple command domains (requires justification)

## Command Structure

### Required Components

1. **YAML Front Matter** - Tool permissions and metadata
2. **Context Section** - Dynamic environment information
3. **Task Description** - Clear, actionable instructions
4. **Usage Examples** - Practical implementation guidance

### Example Command Structure

```markdown
---
allowed-tools: [Read, Edit, Bash(git:*)]
description: "Fix merge conflicts with guided resolution"
argument-hint: "[conflict-type] | [files]"
---

# /resolve-conflicts

Systematically resolve git merge conflicts with AI assistance.

## Context

- Current branch: !`git branch --show-current`
- Conflicted files: !`git diff --name-only --diff-filter=U`
- Recent commits: !`git log --oneline -3`

## Your Task

[Detailed instructions...]
```

## Best Practices

### YAML Front Matter

- **Always** include `allowed-tools` and `description`
- **Recommended**: Add `argument-hint` for better UX
- **Format**: Use JSON array syntax for consistency
- **Order**: `allowed-tools`, `description`, `argument-hint`

### Dynamic Context

- Use `!`command`` syntax for live environment data
- Keep commands lightweight and fast
- Handle command failures gracefully with `|| echo "fallback"`

### Security

- Request minimal necessary permissions
- Use specific command patterns: `Bash(git:*)` not `Bash`
- Document why elevated permissions are needed
- Regular security audits of command permissions

## Development Guidelines

### Creating New Commands

1. **Plan** - Define scope and required tools
2. **Secure** - Apply least-privilege permissions
3. **Test** - Verify all dynamic context commands
4. **Document** - Include clear usage examples
5. **Review** - Security and quality validation

### Avoiding Anti-Patterns

- ❌ No fictional performance claims ("10x faster")
- ❌ No parallel sub-agent references
- ❌ No complex state management or session files
- ❌ No overly broad tool permissions
- ❌ No overengineering - keep commands focused

## Maintenance

### Regular Tasks

- **Security Audit**: Review tool permissions quarterly
- **Performance Check**: Ensure dynamic context commands are fast
- **Quality Review**: Validate metadata completeness
- **Usage Analysis**: Identify unused or redundant commands

### Command Lifecycle

1. **Active**: Regularly used, well-maintained
2. **Deprecated**: Marked for removal, with migration path
3. **Archived**: Moved to archive/ for reference

## Troubleshooting

### Common Issues

- **YAML Parse Error**: Check quotes and array formatting
- **Permission Denied**: Verify required tools in allowed-tools
- **Context Failure**: Test dynamic context commands individually
- **Performance**: Replace expensive operations with cached alternatives

### Getting Help

- Check [STYLE_GUIDE.md](STYLE_GUIDE.md) for detailed standards
- Use `/analyze-slash-commands` for ecosystem health checks
- Review security guidelines in [SECURITY.md](SECURITY.md)

## Contributing

### Pull Request Guidelines

1. Follow security model and least-privilege access
2. Include argument-hint for discoverability
3. Test all dynamic context commands
4. Update documentation as needed
5. Security review for commands with Bash access

### Quality Standards

- Commands must be 50-250 lines maximum
- All dynamic context must handle failures gracefully
- YAML front matter must validate without errors
- No fictional capabilities or performance claims

## Resources

- [Command Style Guide](STYLE_GUIDE.md) - Detailed creation standards
- [Security Guidelines](SECURITY.md) - Security model and best practices
- [API Reference](API.md) - Tool permissions and dynamic context
- [Examples](examples/) - Sample implementations and patterns

---

**📈 Ecosystem Health**: 73 total issues identified, 27 critical/high priority
**🔒 Security Score**: 49/100 (21 commands need permission hardening)
**📝 Documentation**: 85% missing argument hints - improvement in progress

For questions or contributions, see the [Contributing Guide](CONTRIBUTING.md).
