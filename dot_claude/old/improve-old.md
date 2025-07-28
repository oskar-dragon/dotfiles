---
allowed-tools: Read, Write, Edit, Task, Glob, Grep, Bash(pwd), Bash(git:*), Bash(fd:*), Bash(head:*), Bash(wc:*), Bash(eza:*), Bash(gdate:*)
description: Improve slash commands by adding structure, tools, and best practices following principle of least privilege
argument-hint: "[command-file-path]"
---

## Context

- Current directory: !`pwd`
- Target file: $ARGUMENTS

## Your Task

First, carefully analyze the command structure and identify specific improvement opportunities. Be explicit about what constitutes a well-improved command.

STEP 1: Analyze Current Command

IF no command file specified:

- LIST available commands in current directory
- PROMPT user to specify a command file
- EXIT with usage guidance

- READ the command file completely
- CHECK command length (target: 50-300 lines, excluding YAML front matter)
- IDENTIFY current structure and format
- DETERMINE improvement needs based on comprehensive style guide:
  - Has proper YAML front matter with minimal required tools?
  - Has clear argument hints that guide user input?
  - Has appropriate allowed-tools (only what's actually used)?
  - Has concise, action-oriented description?
  - Uses dynamic context (!\`command`\) for real-time information?
  - Has programmatic structure with clear STEP/IF/FOR patterns?
  - Includes structured thinking for complex operations
  - Optimizes tool usage patterns for efficiency

STEP 2: Apply Improvements

**Add/Update Front Matter:**

- EXTRACT allowed-tools from command usage patterns using principle of least privilege
- ONLY include tools actually used in the command
- Use granular Bash permissions: Bash(command:\*) for specific commands
- WRITE concise, action-oriented description

**Tool Security Guidelines:**

- FORBIDDEN legacy bash commands: grep, find, cat, ls, df, top, xxd (replace with modern alternatives)
- ALLOWED modern bash tools: rg, fd, bat, eza, jq, yq, fzf, delta, gh
- ALLOWED Claude tools: Read, Write, Edit, MultiEdit, Task, Bash(specific:\*), Glob, Grep
- Never allow: Bash without constraints (too permissive)
- Prefer: Bash(command:\*) for specific command families
- Always test: Each bash permission in actual usage
- Document: Why each tool is needed in the command

**Granular Bash Permissions:**

- Use specific command patterns: Bash(git:\*), Bash(fd:\*), Bash(rg:\*)
- Individual commands: Bash(pwd), Bash(gdate:\*), Bash(head:\*)
- Network tools: Bash(curl:\*), Bash(wget:\*)
- Development tools: Bash(npm:\*), Bash(bun:\*), Bash(pnpm:\*), Bash(turbo:\*) etc.
- System info: Bash(uname), Bash(whoami), Bash(which:\*)

**Dynamic Context Management:**

**IF command has existing dynamic context:**

- PRESERVE all existing !\`command\` syntax exactly as written
- NEVER replace !\`pwd\`, !\`git status\`, !\`fd\` commands with static values
- NEVER convert dynamic commands to hardcoded outputs

**IF command lacks dynamic context, ADD these as beneficial:**

- Git commands: !\`git status\`, !\`git branch --show-current\`
- File operations: !\`pwd\`, !\`fd pattern . | head -5\`, !\`eza -la\`
- Analysis commands: !\`rg pattern\`, !\`fd --type f | wc -l\`

**Rule: PRESERVE existing, ADD missing - never replace**

**Restructure Task Definition:**

- CONVERT casual language to STEP-based structure
- ADD IF/ELSE for conditional logic
- ADD FOR EACH for iterations
- ADD TRY/CATCH for error-prone operations
- **REMOVE overengineering and fictional elements**
- **FOCUS on actual Claude Code capabilities**:
  - Use only real tools (follow Tool Security Guidelines)
  - Reference actual package manager commands
  - Provide clear, actionable steps

**Integrate Thinking Capabilities:**

For complex analysis and multi-step workflows:

- ADD thinking prompts: "Think carefully about the optimal approach before proceeding"
- INCLUDE reflection checkpoints: "After receiving tool results, carefully reflect on their quality and determine optimal next steps"
- USE interleaved thinking for complex decisions: "Consider multiple approaches and select the most effective one"
- APPLY thinking to tool result analysis: "Analyze the results and plan your next actions based on what you've learned"

**Enhanced Error Handling:**

- Add fallback patterns for bash commands:

  ```markdown
  - Current status: !\`git status 2>/dev/null || echo "Not a git repository"`\
  - File count: !\`fd --type f | wc -l 2>/dev/null || echo "0"`\
  ```

- Include TRY/CATCH blocks for risky operations:

  ```markdown
  TRY:

  - EXECUTE command that might fail
  - VERIFY expected output
    CATCH:
  - HANDLE error gracefully
  - PROVIDE fallback approach
  ```

- Test all dynamic context commands (see Critical Bash Command Testing section)

**Optimize Tool Usage Patterns:**

- ADD explicit parallel tool calling instructions: "For maximum efficiency, whenever you need to perform multiple independent operations, invoke all relevant tools simultaneously rather than sequentially"
- INCLUDE batch operation guidance: "When multiple file reads or searches are needed, perform them in parallel using multiple tool calls in a single message"
- SPECIFY concurrent execution patterns: "Execute git status, git diff, and git log commands simultaneously to gather comprehensive repository information"
- PROVIDE examples of efficient tool combinations

STEP 3: Validate and Test

- ENSURE YAML front matter is valid
- VERIFY all bash commands work properly
- TEST dynamic context commands for output
- USE simple dynamic context: !\`command\`
- **VALIDATE against comprehensive testing checklist**:
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

## Critical Bash Command Testing

**Test EVERY bash command before including in Context section:**

**Essential Testing Rules:**

- Add error handling with \`2>/dev/null || echo "fallback"`
- Escape ! in markdown: !\`command\`
- Use proper quotes for patterns: 'pattern' or "path with spaces"
- Test commands in actual shell before including

**Common Safe Patterns:**

```markdown
# Good - with fallback

- Branch: !\`git branch --show-current 2>/dev/null || echo "unknown"`\
- Files: !\`fd '\*.js' . | head -5 2>/dev/null || echo "No JS files"`\

# Bad - no error handling

- Branch: !\`git branch --show-current\`
```

STEP 4: Report Results

SHOW summary of improvements:

- Added/updated front matter with explicit behavior expectations
- Added dynamic context with proper error handling
- Restructured to programmatic format with thinking capabilities
- Optimized tool usage patterns for parallel execution
- **Removed overengineering and fictional elements**
- **Focused on actual capabilities**: real tools, actionable steps, practical examples
- **Strengthened solution quality**: robust, general-purpose implementations
- **Validated against comprehensive style guide**: length, structure, functionality

## Best Practices

1. **Security**: Follow Tool Security Guidelines and principle of least privilege
2. **Deterministic**: Same inputs produce same outputs
3. **Clear Structure**: STEP-based execution flow with explicit instructions
4. **Token Efficiency**: Precise tools and concise instructions
5. **Testing**: Verify all bash commands work properly
6. **Length Control**: Target 50-300 lines maximum (excluding YAML front matter)
7. **Reality Check**: No fictional performance claims or parallel processing
8. **Checkpoint Patterns**: Add simple resumability for long operations expectations
9. **Solution Quality**: Emphasize robust, general-purpose implementations over test-specific solutions

## Extended Thinking Guidelines

Use structured thinking prompts for complex commands involving:

- Multi-phase workflows with dependencies
- Architecture decisions and workflow strategies
- Security analysis and vulnerability assessment
- Performance optimization and token usage
- Complex code analysis and improvement decisions

**Application examples:**

```yaml
description: Complex analysis requiring careful consideration of multiple approaches
```

```markdown
Think carefully about the optimal approach for this multi-step workflow. After receiving tool results, reflect on their quality and determine the best next steps.

Consider multiple implementation strategies and select the most effective approach based on the specific requirements and constraints.
```

## Command-Type-Specific Improvement Patterns

### Pattern 1: Git/GitHub Commands

**Add comprehensive git context:**

```markdown
## Context

- Repository: !\`git remote -v | head -1 | awk '{print $2}' 2>/dev/null || echo "none"\`
- Current branch: !\`git branch --show-current 2>/dev/null || echo "not a git repo"\`
- Status: !\`git status --porcelain 2>/dev/null || echo "clean"\`
- Recent commits: !\`git log --oneline -3 2>/dev/null || echo "no commits"\`
```

### Pattern 2: Code Analysis Commands

**Enable extended thinking for complex analysis:**

```markdown
## Your Task

Think deeply about the codebase structure and patterns before proceeding.

STEP 1: Initial exploration

- USE extended thinking to understand architecture
- ANALYZE dependencies and relationships
```

### Pattern 3: Package Management Commands

**Add environment detection:**

```markdown
## Context

- Package manager: !\`[ -f package.json ] && echo "npm/yarn/pnpm/bun" || echo "unknown"\`
- Dependencies: !\`jq -r '.dependencies | keys | length' package.json 2>/dev/null || echo "0"\`
```

### Pattern 4: Testing Commands

**Add test framework detection:**

```markdown
## Context

- Test framework: !\`jq -r '.devDependencies | keys[]' package.json 2>/dev/null | grep -E "(jest|vitest|mocha)" | head -1 || echo "unknown"\`
- Test files: !\`fd -e test.js -e spec.js . | wc -l 2>/dev/null || echo "0"\`
```

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
