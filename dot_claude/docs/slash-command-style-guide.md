# Slash Command Style Guide

This document defines the canonical standards for creating and improving slash commands. Reference this guide instead of duplicating style rules across individual commands.

## Table of Contents

1. [Tool Security Guidelines](#tool-security-guidelines)
2. [YAML Front Matter Standards](#yaml-front-matter-standards)
3. [Command Structure Best Practices](#command-structure-best-practices)
4. [Dynamic Context Management](#dynamic-context-management)
5. [Testing and Validation Guidelines](#testing-and-validation-guidelines)
6. [Command Templates and Patterns](#command-templates-and-patterns)
7. [Thinking Integration Guidelines](#thinking-integration-guidelines)
8. [Error Handling Patterns](#error-handling-patterns)

## Tool Security Guidelines

Follow the **principle of least privilege** - only include tools actually used in the command.

### FORBIDDEN Legacy Commands

**Never allow these legacy bash commands:**

- `grep` → use `rg` (ripgrep)
- `find` → use `fd`
- `cat` → use `bat` or Read tool
- `ls` → use `eza` or LS tool
- `df`, `top`, `xxd` → use modern alternatives

### ALLOWED Modern Bash Tools

- **Search/Files**: `rg`, `fd`, `bat`, `eza`
- **Data**: `jq`, `yq`, `fzf`, `delta`
- **Development**: `gh`

### ALLOWED Claude Tools

- **Core**: `Read`, `Write`, `Edit`, `MultiEdit`, `Task`, `Glob`, `Grep`
- **Constrained Bash**: `Bash(specific:*)` patterns only

### Granular Bash Permissions

Use specific command patterns instead of broad permissions:

```yaml
# Good - Specific patterns
allowed-tools: Bash(git:*), Bash(fd:*), Bash(rg:*)

# Good - Individual commands
allowed-tools: Bash(pwd), Bash(gdate:*), Bash(head:*)

# Good - Command families
allowed-tools: Bash(npm:*), Bash(curl:*), Bash(uname)

# Bad - Too permissive
allowed-tools: Bash
```

**Common Permission Patterns:**

- **Git**: `Bash(git:*)`
- **File operations**: `Bash(fd:*)`, `Bash(head:*)`, `Bash(wc:*)`
- **Development**: `Bash(npm:*)`, `Bash(bun:*)`, `Bash(pnpm:*)`, `Bash(turbo:*)`
- **Network**: `Bash(curl:*)`, `Bash(wget:*)`
- **System info**: `Bash(uname)`, `Bash(whoami)`, `Bash(which:*)`

## YAML Front Matter Standards

Every command must include:

```yaml
---
allowed-tools: [minimal set following principle of least privilege]
description: [concise, action-oriented description]
argument-hint: "[guidance for user input]"
---
```

### Description Guidelines

- Action-oriented (starts with verb)
- Concise (under 80 characters)
- Specific about what the command does
- No vague terms like "improve" or "optimize"

### Argument Hints

- Use square brackets: `"[command-file-path]"`
- Be specific about expected input format
- Include examples when helpful: `"[package-name] or [package@version]"`

## Command Structure Best Practices

### Length Requirements

- **Target**: 50-300 lines (excluding YAML front matter)
- Commands shorter than 50 lines may lack necessary structure
- Commands longer than 300 lines should be split or simplified

### Programmatic Structure

Use clear, step-based execution flow:

```markdown
## Your Task

**STEP 1: Analysis**

- READ target files
- IDENTIFY requirements
- DETERMINE approach

**STEP 2: Implementation**

- EXECUTE planned changes
- VERIFY results
- HANDLE errors

**STEP 3: Validation**

- TEST all changes
- CONFIRM functionality
- REPORT results
```

### Conditional Logic Patterns

```markdown
IF condition:

- ACTION when true
- VERIFY outcome
  ELSE:
- ALTERNATIVE action
- FALLBACK approach

FOR EACH item in list:

- PROCESS item
- VALIDATE result

TRY:

- RISKY operation
- VERIFY success
  CATCH:
- HANDLE error
- PROVIDE fallback
```

## Dynamic Context Management

### Preservation Rules

**NEVER modify existing dynamic context:**

- PRESERVE all existing `!command` syntax exactly
- NEVER replace `!pwd`, `!git status`, `!fd` with static values
- NEVER convert dynamic commands to hardcoded outputs

### Adding Context

**Add these beneficial patterns when missing:**

```markdown
## Context

- Current directory: !`pwd`
- Git status: !`git status --porcelain 2>/dev/null || echo "not a git repo"`
- Current branch: !`git branch --show-current 2>/dev/null || echo "unknown"`
- File count: !`fd --type f | wc -l 2>/dev/null || echo "0"`
```

### Error Handling in Context

Always include fallback values:

```markdown
# Good - with fallback

- Branch: !`git branch --show-current 2>/dev/null || echo "unknown"`
- Files: !`fd '*.js' . | head -5 2>/dev/null || echo "No JS files"`

# Bad - no error handling

- Branch: !`git branch --show-current`
```

## Testing and Validation Guidelines

### Command Testing Checklist

Test EVERY bash command before including:

- [ ] Command executes without errors
- [ ] Output is meaningful and expected
- [ ] Error handling works (`2>/dev/null || echo "fallback"`)
- [ ] Shell quoting is correct (escape `!` in markdown: `!command`)
- [ ] Patterns use proper quotes: `'pattern'` or `"path with spaces"`

### Safe Command Patterns

```markdown
# File operations

- JS files: !`fd '*.js' . | head -5 2>/dev/null || echo "No JS files"`
- Line count: !`wc -l file 2>/dev/null || echo "0"`

# Git operations

- Status: !`git status --porcelain 2>/dev/null || echo "clean"`
- Remote: !`git remote -v | head -1 | awk '{print $2}' 2>/dev/null || echo "none"`

# Package detection

- Package manager: !`[ -f package.json ] && echo "npm-based" || echo "unknown"`
- Dependencies: !`jq -r '.dependencies | keys | length' package.json 2>/dev/null || echo "0"`
```

### Comprehensive Command Validation Checklist

Use this complete checklist when improving or validating commands:

- [ ] Command has argument hints
- [ ] Command is 50-300 lines (excluding YAML front matter)
- [ ] No fictional performance claims
- [ ] Has precise tools specified using principle of least privilege
- [ ] Follows Tool Security Guidelines
- [ ] Clear, actionable steps with explicit expectations
- [ ] Practical examples included
- [ ] Focused on actual capabilities
- [ ] Includes robust, general-purpose solution guidance
- [ ] Avoids hard-coding and test-specific solutions
- [ ] Emphasizes maintainable, extendable implementations
- [ ] Includes thinking prompts for complex operations
- [ ] Optimizes for parallel tool execution where applicable
- [ ] All bash commands tested individually for output
- [ ] Shell quoting issues resolved (no unescaped !, proper quotes)
- [ ] Fallback values provided for all dynamic commands
- [ ] TRY/CATCH blocks added for error-prone operations

## Command Templates and Patterns

### Basic Command Template

```markdown
---
allowed-tools: Read, Task, Bash(specific:*)
description: Brief, clear action description
argument-hint: "[required-argument]"
---

## Context

- Current directory: !`pwd`
- Target: $ARGUMENTS

## Your Task

**STEP 1: Analyze**

- READ and analyze the target
- IDENTIFY key requirements

**STEP 2: Execute**

- IMPLEMENT solution using approved tools only
- FOLLOW all security guidelines

**STEP 3: Report**

- SUMMARIZE changes made
- PROVIDE actionable next steps

## Examples

`/command-name "example-input"`
```

### Git/GitHub Commands

```markdown
## Context

- Repository: !`git remote -v | head -1 | awk '{print $2}' 2>/dev/null || echo "none"`
- Current branch: !`git branch --show-current 2>/dev/null || echo "not a git repo"`
- Status: !`git status --porcelain 2>/dev/null || echo "clean"`
- Recent commits: !`git log --oneline -3 2>/dev/null || echo "no commits"`
```

### Package Management Commands

```markdown
## Context

- Package manager: !`[ -f package.json ] && echo "npm/yarn/pnpm/bun" || echo "unknown"`
- Dependencies: !`jq -r '.dependencies | keys | length' package.json 2>/dev/null || echo "0"`
- Scripts: !`jq -r '.scripts | keys[]' package.json 2>/dev/null | head -3 || echo "none"`
```

### Testing Commands

```markdown
## Context

- Test framework: !`jq -r '.devDependencies | keys[]' package.json 2>/dev/null | grep -E "(jest|vitest|mocha)" | head -1 || echo "unknown"`
- Test files: !`fd -e test.js -e spec.js . | wc -l 2>/dev/null || echo "0"`
```

## Thinking Integration Guidelines

### When to Use Extended Thinking

Add thinking prompts for commands involving:

- Multi-phase workflows with dependencies
- Architecture decisions and strategy planning
- Security analysis and vulnerability assessment
- Performance optimization and token usage
- Complex code analysis and improvement decisions

### Thinking Prompt Patterns

```markdown
Think carefully about the optimal approach before proceeding.

After receiving tool results, carefully reflect on their quality and determine optimal next steps.

Consider multiple approaches and select the most effective one based on the specific requirements and constraints.

Analyze the results and plan your next actions based on what you've learned.
```

### Integration Example

```markdown
## Your Task

Think deeply about the codebase structure and patterns before proceeding.

**STEP 1: Analysis**

- USE extended thinking to understand architecture
- ANALYZE dependencies and relationships
- REFLECT on optimal implementation strategy

**STEP 2: Implementation**

- APPLY the chosen approach systematically
- MONITOR results and adjust as needed
```

## Error Handling Patterns

### TRY/CATCH Blocks

```markdown
TRY:

- EXECUTE potentially failing operation
- VERIFY expected output
- CONTINUE with next step
  CATCH:
- HANDLE error gracefully
- PROVIDE fallback approach
- LOG issue for user awareness
```

### Fallback Strategies

```markdown
# Command with fallback

!`primary-command 2>/dev/null || fallback-command || echo "default-value"`

# Conditional execution

!`[ condition ] && success-action || fallback-action`

# Multiple fallbacks

!`cmd1 2>/dev/null || cmd2 2>/dev/null || echo "none"`
```

## Tool Usage Optimization

### Parallel Execution Guidance

Include explicit instructions for efficient tool usage:

```markdown
For maximum efficiency, whenever you need to perform multiple independent operations, invoke all relevant tools simultaneously rather than sequentially.

When multiple file reads or searches are needed, perform them in parallel using multiple tool calls in a single message.

Execute git status, git diff, and git log commands simultaneously to gather comprehensive repository information.
```

### Batch Operation Examples

```markdown
# Efficient - parallel execution

READ file1.js, file2.js, and file3.js simultaneously
SEARCH for "pattern1" and "pattern2" in parallel
EXECUTE git status and git diff concurrently

# Inefficient - sequential execution

READ file1.js, then file2.js, then file3.js
SEARCH for "pattern1", wait, then search "pattern2"
```

---

## Usage

Reference this guide in commands with:

```markdown
FOLLOW the slash command style guide at docs/slash-command-style-guide.md for:

- Tool security guidelines
- YAML front matter standards
- Dynamic context management
- Testing and validation requirements
```

This eliminates duplication and ensures consistency across all commands.
