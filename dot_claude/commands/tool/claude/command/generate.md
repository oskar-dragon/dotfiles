---
allowed-tools: Read, Write, Bash(mkdir:*), Bash(git:*), Bash(gdate:*)
description: Interactive generator for Claude slash commands with best practices validation and namespace organization
argument-hint: "[namespace] | [command-name]"
---

# /generate-command

Interactively generate new Claude slash commands, ensuring best practices, proper namespace organization, and dynamic context integration.

## Context

- Current directory: !`pwd`
- Git status: !`git status`
- Existing .claude directory: !`ls -la .claude`

## Usage

```
/generate-command
/generate-command --namespace analysis
```

## Your Task

STEP 1: Analyze Current Environment and Gather Requirements

IF no command specification provided:

- ANALYZE existing command structure and project patterns
- IDENTIFY command namespace requirements
- PROMPT user for:
  - **Command Purpose**: What specific task should this command automate?
  - **Command Name**: Kebab-case, descriptive, follows namespace conventions
  - **Parameters Needed**: None, single (`$ARGUMENTS`), or multiple structured inputs
  - **Command Type**: Simple utility, Code analysis, Web research, File operations, Git workflow
  - **Namespace Selection**: Existing or new namespace (e.g., `analyze/`, `code/`, `git/`)
  - **Dynamic Context Requirements**: Real-time information needed (e.g., file system, Git state)

STEP 2: Generate and Validate Command Structure

- GENERATE command structure using appropriate template:
  - **Simple utility**: Basic structure with dynamic context
  - **Code analysis**: File reading, pattern matching, reporting
  - **Web research**: WebSearch/WebFetch with structured output
  - **File operations**: Read/Write/Edit with validation
  - **Git workflow**: Git commands with status checking

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

STEP 3: Create Command File and Provide Usage Instructions

- ENSURE `.claude/commands` (for project-level) or `claude/commands` (for global) directory exists
- CREATE namespace directory if needed
- WRITE command file to the determined path
- CHECK for existing command and PROMPT for overwrite confirmation
- VALIDATE generated command syntax and test all bash commands
- DISPLAY command usage (e.g., `/project:command-name` or `/command-name`)
- SHOW command file location for editing
- SUGGEST testing the command before team distribution
- PROVIDE maintenance guidelines for future command updates

## Expected Output

The command generates:

- New slash command file with proper YAML front matter
- Structured markdown with Context, Usage, Your Task, Expected Output, and Examples sections
- Validation report confirming adherence to style guide
- Usage instructions and maintenance recommendations

## Examples

### Example 1: Simple Utility Command

`/generate-command`
_User specifies: analyze-imports, code analysis, simple utility_

Generates `/analyze-imports.md` with file scanning and import analysis functionality.

### Example 2: Git Workflow Command

`/generate-command --namespace git`
_User specifies: smart-commit, git operations, commit with AI-generated messages_

Generates `/git/smart-commit.md` with git status checking and intelligent commit message generation.

### Example 3: Complete Generation Process

`/generate-command`

**Interactive Session:**

```
Command Purpose: Scan JavaScript/TypeScript files for unused imports and suggest removals
Command Name: cleanup-imports
Command Type: Code analysis
Namespace: analysis
Tools Required: Read, Glob, Grep
Dynamic Context: File count, Git status
```

**Generated Command Preview:**

```markdown
---
allowed-tools: Task, Read, Bash(fd:*), Bash(rg:*), Bash(wc:*), Bash(jq:*), Bash(gdate:*), Bash(eza:*)
description: Discover and propose new Claude command opportunities through systematic analysis and parallel research.
argument-hint: "[focus-area] | [technology-stack]"
---

## Context

- Current directory: !`pwd`
- JavaScript/TypeScript files: !`fd '\.(js|ts|jsx|tsx)$' . | wc -l`
- Git status: !`git status --porcelain 2>/dev/null || echo "Clean"`

## Your Task

STEP 1: Scan Project Files

- GLOB all JS/TS files in project
- READ each file and extract import statements
  ...
```

**Validation Results:**

- ✅ Passes all style guide checks

**Final Output:**

- Created: `/Users/project/.claude/commands/analysis/cleanup-imports.md`
- Usage: `/analysis:cleanup-imports`
- Tested: All bash context commands validated
- Next: Test command execution before team sharing

## Best Practices & Generation Principles

### Commands Must Include:

- **STEP-based structure** with clear, actionable instructions
- **Follows Tool Security Guidelines:**
  - FORBIDDEN legacy tools: grep, find, cat, ls, df, top, xxd (replace with modern alternatives)
  - ALLOWED modern tools: rg, fd, bat, eza, jq, yq, fzf, delta, gh
  - Common Claude tools: Read, Write, Edit, Task, Bash(specific:\*), Glob, Grep
- **Dynamic context** using real bash commands
- **Practical examples** showing actual usage scenarios
- **Proper validation** of all bash commands

### Commands Must Never Include:

- **Fictional performance claims** ("10x faster", "parallel processing")
- **Session state files** (/tmp/ files, checkpoints, resumability)
- **Parallel sub-agents** or coordination systems
- **Complex state management** beyond simple task execution
- **Pseudo-technical features** that don't exist in Claude Code

### Target Command Length:

- **Simple utilities**: 30-80 lines
- **Most commands**: 50-250 lines
- **Complex analysis**: Maximum 300 lines

**IMPORTANT**: All generated commands must follow the standard template structure with YAML front matter, Context section with dynamic bash commands, step-based task structure, expected output format, practical examples, and important usage notes.
