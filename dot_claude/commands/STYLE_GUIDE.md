# Claude Commands Style Guide

## Overview

This guide defines best practices for creating lean, functional Claude commands that align with Anthropic's official Claude Code capabilities. Commands should be **50-170 lines maximum** and focus on **actual functionality** rather than fictional performance claims.

## Command Template

Use this template for all new commands:

```markdown
---
allowed-tools: [List only tools that will actually be used]
description: Brief, clear description of what this command does
---

# /command-name

One-sentence description of the command's purpose.

## Context

Brief context about when to use this command:

- Key variable: $ARGUMENTS
- Current directory: !`pwd`
- [Other relevant context using actual bash commands]

## Usage
```

/command-name [arguments]
/command-name [arguments] --flag # Optional flags if needed

```

## Your Task

**Step 1: [Clear Action]**

Describe what Claude should do in clear, actionable terms:
- Use bullet points for specific actions
- Reference actual tools and commands
- Avoid complex pseudo-code

**Step 2: [Next Action]**

Continue with logical progression:
- Keep steps simple and focused
- Use real package manager commands when applicable
- Reference actual file operations

**Step 3: [Final Action]**

Complete the workflow:
- Generate clear output
- Provide actionable recommendations
- Focus on practical next steps

## Expected Output

Describe what the command will produce:
- Specific format (markdown, JSON, etc.)
- Key sections and content
- Actionable recommendations

## Examples

### Example 1: [Use Case]
`/command-name "specific example"`

Explanation of what this would do and expected outcome.

### Example 2: [Another Use Case]
`/command-name "different example"`

Explanation of different scenario and result.

**IMPORTANT**: [Any critical notes about usage or limitations]
```

## Style Guidelines

### ✅ DO Include

- **Clear, actionable steps** that Claude can actually perform
- **Real tool references** (Read, Write, Bash, Grep, etc.)
- **Practical examples** showing actual usage
- **Specific output formats** with clear structure
- **Actual bash commands** for context gathering
- **Focused functionality** that solves a specific problem

### ❌ DON'T Include

- **Fictional performance claims** ("10x faster", "8x speedup")
- **Parallel sub-agents** (these don't exist in Claude Code)
- **Complex state management** (/tmp/ session files, checkpoints)
- **Elaborate coordination systems** (agent deployment, parallel processing)
- **Pseudo-technical jargon** without actual functionality
- **Complex TRY/CATCH/FINALLY blocks** for simple operations
- **JSON schemas** for session state management
- **Resumability systems** (Claude commands are stateless)

## Tool Usage Best Practices

### Allowed Tools Reference

Only include tools that will actually be used:

```yaml
# Common tools for different command types
allowed-tools: [Task, Read, Write, Edit, Bash, Grep, WebFetch, WebSearch]

# Code analysis commands
allowed-tools: [Read, Grep, Bash(rg:*), Bash(fd:*), Task]

# Web research commands
allowed-tools: [WebSearch, WebFetch, Task]

# File manipulation commands
allowed-tools: [Read, Write, Edit, MultiEdit, Bash(git:*)]
```

### Context Gathering

Use actual bash commands for context:

```markdown
## Context

Current directory: !`pwd`
Git status: !`git status --porcelain | head -5 || echo "Not a git repository"`
Package files: !`fd "(package\.json|go\.mod)" . | head -5 || echo "No package files"`
```

## Command Length Guidelines

- **Target**: 50-200 lines total
- **Minimum**: 30 lines (for simple utilities)
- **Maximum**: 200 lines (for complex analysis)
- **Average**: 80-120 lines for most commands

## Output Structure

### Markdown Reports

Use consistent structure for analysis reports:

```markdown
# [Report Title]

## Executive Summary

- [Key finding 1]
- [Key finding 2]
- [Primary recommendation]

## Detailed Analysis

[Specific findings with evidence]

## Recommendations

[Actionable next steps]

## Resources

[Relevant links and documentation]
```

### Code Examples

Always include practical examples:

```markdown
## Examples

### Example 1: [Scenario]

`/command "specific input"`

Expected outcome and explanation.

### Example 2: [Different Scenario]

`/command "different input"`

Different outcome and use case.
```

## Well-Designed Command Examples

Reference these commands as good examples:

- **`git/pr.md`** (71 lines) - Focused, actionable PR creation
- **`analyze/think/think.md`** (153 lines) - Appropriate complexity for thinking
- **`meta/command/generate-command.md`** (71 lines) - Well-scoped utility
- **`code/refactor/simplify.md`** (99 lines) - Clear code improvement workflow

## Common Pitfalls to Avoid

1. **Overengineering**: Don't create complex coordination systems for simple tasks
2. **Fictional Features**: Don't reference capabilities that don't exist
3. **Performance Claims**: Don't make unfounded speedup claims
4. **State Management**: Don't create complex session tracking for stateless commands
5. **Pseudo-Code**: Don't write elaborate programming patterns instead of clear instructions

## Validation Checklist

Before submitting a command, verify:

- [ ] Command is 50-170 lines
- [ ] No fictional performance claims
- [ ] No parallel sub-agent references
- [ ] Uses only real Claude Code tools
- [ ] Clear, actionable steps
- [ ] Practical examples included
- [ ] Focused on actual capabilities
- [ ] Follows template structure

## Migration from Overengineered Commands

When simplifying existing commands:

1. **Remove fictional elements** first (parallel agents, performance claims)
2. **Eliminate complex state management** (session files, checkpoints)
3. **Simplify coordination** (remove elaborate pseudo-code)
4. **Focus on actual capabilities** (use real tools only)
5. **Test simplified version** to ensure functionality is preserved

## Summary

Great Claude commands are **lean, focused, and practical**. They use **real tools** to accomplish **specific tasks** with **clear instructions**. Avoid the temptation to overcomplicate - simple, working commands are far more valuable than elaborate fictional systems.

Remember: **Claude Code is powerful because it's simple and reliable**, not because it has complex coordination systems or fictional performance optimizations.
