---
allowed-tools: Read, Write, Edit, Task, Glob, Grep, Bash(pwd), Bash(git:*), Bash(fd:*), Bash(head:*), Bash(wc:*), Bash(eza:*), Bash(gdate:*)
description: Improve slash commands by adding structure, tools, and best practices following principle of least privilege
argument-hint: "[command-file-path]"
---

## Context

- Current directory: !`pwd`
- Target file: $ARGUMENTS
- Target file contents: @$ARGUMENTS

## Your Task

STEP 1: Analyze Current Command

IF no command file specified:

- LIST available commands in current directory
- PROMPT user to specify a command file
- EXIT with usage guidance

- READ the command file
- CHECK command length (target: 50-300 lines, excluding YAML front matter)
- IDENTIFY current structure and format
- DETERMINE improvement needs based on style guide:
  - Has proper YAML front matter?
  - Has argument hints?
  - Has appropriate allowed-tools (only what's used)?
  - Has concise description?
  - Uses dynamic context (!\`command`\)?
  - Has programmatic structure?
  - **Check for overengineering and fictional elements** (see Common Overengineering Patterns section)

STEP 2: Apply Improvements

**Add/Update Front Matter:**

- EXTRACT allowed-tools from command usage patterns using principle of least privilege
- ONLY include tools actually used in the command
- Use granular Bash permissions: Bash(command:\*) for specific commands
- WRITE concise, action-oriented description

**Tool Security Guidelines:**

- FORBIDDEN legacy tools: grep, find, cat, ls, df, top, xxd (replace with modern alternatives)
- ALLOWED modern tools: rg, fd, bat, eza, jq, yq, fzf, delta, gh
- Common Claude tools: Read, Write, Edit, Task, Bash(specific:\*), Glob, Grep

**Add Dynamic Context (if beneficial):**

- Git commands: !\`git status\`, !\`git branch --show-current\`
- File operations: !\`pwd\`, !\`fd pattern . | head -5\`, !\`eza -la\`
- Analysis commands: !\`rg pattern\`, !\`fd --type f | wc -l\`

**CRITICAL: PRESERVE EXISTING DYNAMIC CONTEXT**

- NEVER replace existing !\`command\` syntax with static values
- NEVER convert !\`pwd\` to hardcoded directory paths
- NEVER convert !\`git status\` to static git status
- NEVER convert !\`fd\` commands to static file counts
- PRESERVE original dynamic bash commands exactly as written
- ONLY ADD new dynamic context if missing, never replace existing

**Restructure Task Definition:**

- CONVERT casual language to STEP-based structure
- ADD IF/ELSE for conditional logic
- ADD FOR EACH for iterations
- **REMOVE overengineering and fictional elements** (see Common Overengineering Patterns section)
- **FOCUS on actual Claude Code capabilities**:
  - Use only real tools (see Tool Security Guidelines above)
  - Reference actual package manager commands
  - Provide clear, actionable steps

STEP 3: Validate and Test

- ENSURE YAML front matter is valid
- VERIFY all bash commands work properly
- TEST dynamic context commands for output
- USE simple dynamic context: !\`command\`
- **VALIDATE against style guide checklist**:
  - [ ] Command has argument hints
  - [ ] Command is 50-300 lines (excluding YAML front matter)
  - [ ] No fictional performance claims
  - [ ] No parallel sub-agent references
  - [ ] Uses only real Claude Code tools
  - [ ] Has precise tools specified using principle of least privilege
  - [ ] Follows Tool Security Guidelines (no legacy tools, modern alternatives only)
  - [ ] Clear, actionable steps
  - [ ] Practical examples included
  - [ ] Focused on actual capabilities

STEP 4: Report Results

SHOW summary of improvements:

- Added/updated front matter
- Added dynamic context
- Restructured to programmatic format
- **Removed overengineering and fictional elements** (see Common Overengineering Patterns section)
- **Focused on actual capabilities**: real tools, actionable steps, practical examples
- **Validated against style guide**: length, structure, functionality

## Best Practices

1. **Security**: Follow Tool Security Guidelines and principle of least privilege
2. **Deterministic**: Same inputs produce same outputs
3. **Clear Structure**: STEP-based execution flow
4. **Token Efficiency**: Precise tools and concise instructions
5. **Testing**: Verify all bash commands work properly
6. **Length Control**: Target 50-250 lines maximum (excluding YAML front matter)
7. **Reality Check**: No fictional performance claims or parallel processing
8. **Actual Capabilities**: Focus on real Claude Code tools and features

## Common Overengineering Patterns to Remove

- **Parallel Sub-Agents**: "Deploy 8 specialized agents", "Agent coordination"
- **Performance Claims**: "10x faster", "8x speedup", "parallel execution provides X improvement"
- **Complex State Management**: Session files, checkpoints, resumability systems
- **Coordination Systems**: "Sub-agent coordination", "parallel processing frameworks"
- **Fictional Features**: Capabilities that don't exist in Claude Code

## Target Command Length

Target: 50-300 lines (excluding YAML front matter)

- YAML front matter with minimal allowed-tools
- Clear context with dynamic bash commands
- Step-based task structure
- Expected output format
- Practical examples
- Important usage notes

### Command Template Example

```markdown
---
allowed-tools: Read, Task, Bash(fd:*), Bash(git:*)
description: Brief, clear description following principle of least privilege
argument-hint: "[required-argument]"
---

## Context

- Current directory: !\`pwd\`
- Target: $ARGUMENTS

## Your Task

**Step 1: Analyze**

- READ and analyze the target
- IDENTIFY key requirements

**Step 2: Execute**

- IMPLEMENT solution using approved tools only
- FOLLOW Tool Security Guidelines

**Step 3: Report**

- SUMMARIZE changes made
- PROVIDE actionable next steps

## Examples

`/command-name "example-input"`
```
