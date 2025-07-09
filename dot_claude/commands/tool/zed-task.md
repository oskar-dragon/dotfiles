---
allowed-tools: Read, Write, Bash(test:*), Bash(fd:*)
description: Generate Zed task configuration with intelligent defaults
---

## Context

- Task description: $ARGUMENTS
- Existing .zed directory: !`test -d .zed && echo "exists" || echo "not found"`
- Current tasks file: !`test -f .zed/tasks.json && echo "found" || echo "not found"`
- Project type: !`fd -t f "(package.json|go.mod)" -d 1 | head -3`

## Your task

STEP 1: Parse task description

- Extract task requirements from $ARGUMENTS
- Determine project type and appropriate defaults
- Identify task category (test, build, dev, format, etc.)

STEP 2: Analyze existing Zed configuration

- Check if .zed directory exists
- IF .zed/tasks.json exists:
  - Read current configuration
  - Identify existing task patterns
  - Avoid duplicate task labels
- ELSE:
  - Prepare to create new tasks.json

STEP 3: Generate task configuration

- Create task object with:
  - Descriptive label
  - Appropriate command
  - Working directory ($ZED_WORKTREE_ROOT)
  - Terminal and concurrency settings
  - Reveal behavior

- Apply Zed variable best practices:
  - $ZED_WORKTREE_ROOT for project operations
  - $ZED_FILE for file-specific tasks
  - $ZED_COLUMN/$ZED_ROW for cursor-aware operations

STEP 4: Create or update tasks.json

- IF .zed/tasks.json doesn't exist:
  - Create .zed directory
  - Generate new tasks.json with task array
- ELSE:
  - Merge new task into existing configuration
  - Preserve existing tasks
  - Maintain JSON formatting

STEP 5: Provide usage instructions

- Show task configuration in formatted JSON
- Explain Zed keyboard shortcuts:
  - `cmd-shift-p` → `task: spawn`
  - `task: rerun` for last task
- Document Zed variable usage

## Task Templates

**Test Runner:**

```json
{
  "label": "Test current file",
  "command": "bun test $ZED_FILE",
  "cwd": "$ZED_WORKTREE_ROOT",
  "use_new_terminal": false,
  "allow_concurrent_runs": true,
  "reveal": "on_error"
}
```

**Development Server:**

```json
{
  "label": "Start dev server",
  "command": "bun dev",
  "cwd": "$ZED_WORKTREE_ROOT",
  "use_new_terminal": true,
  "allow_concurrent_runs": false,
  "reveal": "always"
}
```

**Formatter:**

```json
{
  "label": "Format file",
  "command": "bun fmt $ZED_FILE",
  "cwd": "$ZED_WORKTREE_ROOT",
  "use_new_terminal": false,
  "allow_concurrent_runs": true,
  "reveal": "never"
}
```

## Zed Variables

- `$ZED_WORKTREE_ROOT`: Project root directory
- `$ZED_FILE`: Currently selected file
- `$ZED_COLUMN`: Current cursor column
- `$ZED_ROW`: Current cursor row

## Usage

After task creation:

1. Use `cmd-shift-p` and search for "task: spawn"
2. Select your task from the list
3. Use "task: rerun" to repeat the last task
4. Consider creating keybindings for frequently used tasks
