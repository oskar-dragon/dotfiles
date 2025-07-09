---
allowed-tools: Read, Write, Bash(mkdir:*), Bash(fd:*), Bash(ls:*), Bash(git:*), Bash(gdate:*), Bash(eza:*)
description: Interactive generator for Claude slash commands with best practices validation and namespace organization.
---

# /generate-command

Interactively generate new Claude slash commands, ensuring best practices, proper namespace organization, and dynamic context integration.

## Context

- Session ID: !`gdate +%s%N`
- Current directory: !`pwd`
- Existing .claude directory: !`ls -la .claude 2>/dev/null || echo "No .claude directory found"`
- Claude commands directory: !`eza -la claude/commands 2>/dev/null | head -10 || echo "Not in dotfiles directory"`
- Git status: !`git status --porcelain 2>/dev/null | head -3 || echo "Not a git repository"`

## Your Task

STEP 1: Initialize Command Generation Session

- ANALYZE existing command structure and project patterns
- IDENTIFY command namespace requirements

STEP 2: Interactive Command Specification Gathering

- PROMPT user for:
  - **Command Purpose**: What specific task should this command automate?
  - **Command Name**: Kebab-case, descriptive, follows namespace conventions.
  - **Parameters Needed**: None, single (`$ARGUMENTS`), or multiple structured inputs.
  - **Command Type**: Simple utility, Code analysis, Web research, File operations, Git workflow.
  - **Namespace Selection**: Existing or new namespace (e.g., `analyze/`, `code/`, `git/`).
  - **Dynamic Context Requirements**: Real-time information needed (e.g., file system, Git state).
  - **Tools Required**: Read, Write, Edit, Bash commands, WebFetch, WebSearch, Task.

STEP 3: Generate Command File with Best Practices Validation

- GENERATE command structure using the embedded template below:
  - **Simple utility**: Basic structure with dynamic context (50-80 lines)
  - **Code analysis**: File reading, pattern matching, reporting (80-120 lines)
  - **Web research**: WebSearch/WebFetch with structured output (100-150 lines)
  - **File operations**: Read/Write/Edit with validation (60-100 lines)
  - **Git workflow**: Git commands with status checking (70-120 lines)
- VALIDATE against style guide checklist:
  - [ ] Command is 50-150 lines maximum
  - [ ] No fictional performance claims or parallel processing
  - [ ] Uses only real Claude Code tools
  - [ ] Clear, actionable steps with STEP-based structure
  - [ ] Practical examples included
  - [ ] Front matter completeness and minimal `allowed-tools`
  - [ ] Safe and tested Bash commands
  - [ ] Adherence to namespace conventions

STEP 4: Create Command Directory Structure and File

- ENSURE `.claude/commands` (for project-level) or `claude/commands` (for global) directory exists.
- CREATE namespace directory if needed.
- WRITE command file to the determined path.
- CHECK for existing command and PROMPT for overwrite confirmation.

STEP 5: Write and Validate Generated Command

- VALIDATE generated command syntax
- TEST all Bash commands in `Context` section for compatibility
- **VERIFY command follows style guide**:
  - No session state files or complex state management
  - No parallel processing or coordination systems
  - Uses only real Claude Code tools and capabilities
  - Clear, actionable steps without fictional elements

STEP 6: Provide Usage Instructions and Next Steps

- DISPLAY command usage (e.g., `/project:command-name` or `/command-name`)
- SHOW command file location for editing
- SUGGEST testing the command before team distribution
- RECOMMEND documenting the command in project README if applicable
- PROVIDE maintenance guidelines for future command updates

## Command Generation Principles

### Generate Commands That Include:

- **50-150 lines maximum** - Focused, lean functionality
- **Real Claude Code tools only** - Read, Write, Edit, Bash, Grep, WebFetch, WebSearch, Task
- **Clear, actionable steps** - STEP-based structure with specific instructions
- **Practical examples** - Actual usage scenarios
- **Dynamic context** - Real bash commands for context gathering

### Never Generate Commands With:

- **Fictional performance claims** - "10x faster", "parallel processing"
- **Session state files** - /tmp/ files, checkpoints, resumability
- **Parallel sub-agents** - Non-existent coordination systems
- **Complex state management** - Elaborate TRY/CATCH patterns for simple tasks
- **Pseudo-technical features** - Capabilities that don't exist in Claude Code

### Template Structure

All generated commands follow the template in `/commands/STYLE_GUIDE.md`:

- YAML front matter with minimal allowed-tools
- Clear context with dynamic bash commands
- Step-based task structure
- Expected output format
- Practical examples
- Important usage notes

#### Example

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

## Reference

See `/commands/STYLE_GUIDE.md` for complete guidelines and validation checklist.
