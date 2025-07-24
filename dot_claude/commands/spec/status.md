---
allowed-tools: [LS, Read, Bash, Grep]
description: Show detailed status of all specs or a specific spec
---

## Context

- Feature name: $ARGUMENTS (optional)
- Current directory: !`pwd`
- Available specs: !`ls .claude/specs/ 2>/dev/null || echo "No specs found"`
- Total specs: !`ls .claude/specs/ 2>/dev/null | wc -l || echo "0"` found

## Usage

```
/spec-status [feature-name]
/spec-status                    # Show all specs
/spec-status user-authentication # Show specific spec
```

## Your Task

**STEP 1: Determine Scope**

IF no feature-name provided:

- SHOW status summary for all specs (similar to /spec-list but more detailed)
- LIST each spec with phase, progress, and next actions
- PROVIDE overall project status

ELSE:

- VALIDATE specified spec exists in `.claude/specs/{feature-name}/`
- IF spec not found, list available specs and ask user to choose
- SHOW detailed status for that specific spec

**STEP 2: Analyze Spec Files**

FOR target spec(s):

- CHECK file existence: requirements.md, design.md, tasks.md
- READ file contents to determine completion status
- COUNT total vs completed tasks if tasks.md exists
- IDENTIFY next pending task if in implementation phase

**STEP 3: Determine Phase and Progress**

FOR each spec:

- **Requirements Phase**: Check if requirements.md exists and approved
- **Design Phase**: Check if design.md exists and approved
- **Tasks Phase**: Check if tasks.md exists and approved
- **Implementation Phase**: Count [x] vs [ ] tasks in tasks.md
- **Complete Phase**: All tasks marked [x]

**STEP 4: Display Status Information**

SHOW detailed status including:

- Current workflow phase
- Completion status for each phase (✅/🔄/⏸️)
- Task progress ratios where applicable
- Next recommended action with specific command
- Time estimates or priorities if determinable

## Expected Output

### All Specs Status

```
📊 Project Specs Status

user-authentication
├─ Requirements ✅ Complete
├─ Design ✅ Complete
├─ Tasks ✅ Complete
└─ Implementation 🔄 3/8 tasks (38%)
   Next: /spec-execute user-authentication

data-export
├─ Requirements ✅ Complete
├─ Design 🔄 In Progress
├─ Tasks ⏸️ Pending
└─ Implementation ⏸️ Pending
   Next: /spec-design data-export
```

### Specific Spec Status

```
🔍 Spec: user-authentication
Phase: Implementation
Progress: Requirements ✅ | Design ✅ | Tasks ✅

Implementation Progress: 3/8 tasks complete (38%)
├─ ✅ 1. Setup project structure
├─ ✅ 2. Implement data models
├─ ✅ 3. Create authentication service
├─ 🔄 4. Implement password validation (NEXT)
├─ ⏸️ 5. Add JWT token management
├─ ⏸️ 6. Create login endpoints
├─ ⏸️ 7. Add error handling
└─ ⏸️ 8. Write integration tests

Next Action: /spec-execute user-authentication 4
```

## Examples

### Example 1: All Specs

```
/spec-status
```

Shows status overview for all specs in the project.

### Example 2: Specific Spec

```
/spec-status user-authentication
```

Shows detailed status for user-authentication spec with task-level progress.

### Example 3: Non-existent Spec

```
/spec-status nonexistent-feature
```

Lists available specs and asks user to choose valid option.

## Important Notes

- **Phase Detection**: Automatically determines current phase from file analysis
- **Task Granularity**: Shows individual task progress when in implementation phase
- **Next Actions**: Provides specific commands to advance the workflow
- **Visual Indicators**: Uses emojis for quick status recognition (✅🔄⏸️)
- **Progress Tracking**: Shows completion percentages for implementation phase
