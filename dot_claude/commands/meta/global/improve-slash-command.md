---
allowed-tools: Read, Write, Edit, Bash(git add:*), Bash(git commit:*), Bash(git status:*)
description: Improve slash commands by adding structure, tools, and best practices
---

# /improve-slash-command

Improve slash commands by adding proper structure, tools, and following best practices.

## Context

- Current directory: !`pwd`
- Git status: !`git status --porcelain 2>/dev/null || echo "Clean working directory"`
- Target file: $ARGUMENTS

## Your Task

STEP 1: Analyze Current Command

IF no command file specified:

- LIST available commands in current directory
- PROMPT user to specify a command file
- EXIT with usage guidance

- READ the command file
- CHECK command length (target: 50-200 lines)
- IDENTIFY current structure and format
- DETERMINE improvement needs based on style guide:
  - Has proper YAML front matter?
  - Has appropriate allowed-tools (only what's used)?
  - Has concise description?
  - Uses dynamic context (!`command`)?
  - Has programmatic structure?
  - **Check for overengineering**: parallel agents, performance claims, complex state management
  - **Validate against fictional elements**: session files, coordination systems, resumability

STEP 2: Apply Improvements

**Add/Update Front Matter:**

- EXTRACT allowed-tools from command usage patterns
- Common tools: Read, Write, Edit, Bash, Glob, Grep
- WRITE concise, action-oriented description

**Add Dynamic Context (if beneficial):**

- Git commands: !`git status`, !`git branch --show-current`
- File operations: !`pwd`, !`fd pattern . | head -5`
- Analysis commands: project structure discovery

**CRITICAL: PRESERVE EXISTING DYNAMIC CONTEXT**

- NEVER replace existing !`command` syntax with static values
- NEVER convert !`pwd` to hardcoded directory paths
- NEVER convert !`git status` to static git status
- NEVER convert !`fd` commands to static file counts
- PRESERVE original dynamic bash commands exactly as written
- ONLY ADD new dynamic context if missing, never replace existing

**Restructure Task Definition:**

- CONVERT casual language to STEP-based structure
- ADD IF/ELSE for conditional logic
- ADD FOR EACH for iterations
- **REMOVE fictional elements**:
  - Delete "parallel sub-agents" and "8 specialized agents"
  - Remove "10x faster" and performance claims
  - Eliminate "/tmp/" session files and checkpoints
  - Remove "coordination systems" and "parallel processing"
- **FOCUS on actual Claude Code capabilities**:
  - Use only real tools: Read, Write, Edit, Bash, Grep, WebFetch, WebSearch, Task
  - Reference actual package manager commands
  - Provide clear, actionable steps

STEP 3: Validate and Test

- ENSURE YAML front matter is valid
- VERIFY all bash commands work properly
- TEST dynamic context commands for output
- PROVIDE fallback values: !`command || echo "fallback"`
- **VALIDATE against style guide checklist**:
  - [ ] Command is 50-200 lines
  - [ ] No fictional performance claims
  - [ ] No parallel sub-agent references
  - [ ] Uses only real Claude Code tools
  - [ ] Clear, actionable steps
  - [ ] Practical examples included
  - [ ] Focused on actual capabilities

STEP 5: Report Results

SHOW summary of improvements:

- Added/updated front matter
- Added dynamic context
- Restructured to programmatic format
- **Removed fictional elements**: parallel agents, performance claims, session files
- **Simplified overengineered sections**: coordination systems, complex state management
- **Focused on actual capabilities**: real tools, actionable steps, practical examples
- **Validated against style guide**: length, structure, functionality

## Best Practices

1. **Security**: Minimal allowed-tools (only what's used)
2. **Deterministic**: Same inputs produce same outputs
3. **Clear Structure**: STEP-based execution flow
4. **Token Efficiency**: Precise tools and concise instructions
5. **Testing**: Verify all bash commands work properly
6. **Length Control**: Target 50-200 lines maximum
7. **Reality Check**: No fictional performance claims or parallel processing
8. **Actual Capabilities**: Focus on real Claude Code tools and features

## Common Overengineering Patterns to Remove

- **Parallel Sub-Agents**: "Deploy 8 specialized agents", "Agent coordination"
- **Performance Claims**: "10x faster", "8x speedup", "parallel execution provides X improvement"
- **Complex State Management**: Session files, checkpoints, resumability systems
- **Coordination Systems**: "Sub-agent coordination", "parallel processing frameworks"
- **Fictional Features**: Capabilities that don't exist in Claude Code

## Target Command Length

- **Minimum**: 30 lines (simple utilities)
- **Target**: 50-150 lines (most commands)
- **Maximum**: 200 lines (complex analysis)

- YAML front matter with minimal allowed-tools
- Clear context with dynamic bash commands
- Step-based task structure
- Expected output format
- Practical examples
- Important usage notes

### Example

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
