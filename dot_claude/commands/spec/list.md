---
allowed-tools: [LS, Read, Bash]
description: List all specs with current phase and completion status
---

# /spec-list

List all specs with current phase and completion status.

## Context

- Current directory: !`pwd`
- Specs directory: !`ls .claude/specs/ 2>/dev/null || echo "No specs directory"`
- Total specs: !`ls .claude/specs/ 2>/dev/null | wc -l || echo "0"` found

## Usage

```
/spec-list
```

## Your Task

**STEP 1: Check Specs Directory**

IF `.claude/specs/` directory doesn't exist:

- INFORM user no specs found
- SUGGEST using `/spec-create` to create first spec
- EXIT with usage guidance

ELSE:

- LIST all subdirectories in `.claude/specs/`
- IF empty directory, inform user no specs exist

**STEP 2: Analyze Each Spec**

FOR EACH spec directory:

- READ spec name from directory name
- CHECK which files exist (requirements.md, design.md, tasks.md)
- DETERMINE current phase based on file presence and completion
- COUNT completed vs total tasks if tasks.md exists
- GET last modified date from newest file

**STEP 3: Determine Phase Status**

FOR EACH spec:

- IF only requirements.md exists: Phase = "Requirements"
- IF requirements.md + design.md exist: Phase = "Design"
- IF all three files exist: Phase = "Tasks" or "Implementation"
- IF all tasks marked [x]: Phase = "Complete"

**STEP 4: Display Formatted List**

SHOW comprehensive overview:

- Total spec count
- Each spec with name, phase, progress, and last updated
- Visual indicators for completion status
- Suggested next actions for incomplete specs

## Expected Output

Displays formatted list of all specs:

```
📋 Project Specs Overview (3 specs)

1. user-authentication ✅ Complete
   Phase: Implementation (7/8 tasks)
   Last updated: 2025-01-15
   Next: Execute remaining task

2. data-export 🔄 In Progress
   Phase: Design
   Last updated: 2025-01-14
   Next: Run /spec-tasks data-export

3. notification-system 📝 Planning
   Phase: Requirements
   Last updated: 2025-01-13
   Next: Complete requirements approval
```

## Examples

### Example 1: Multiple Specs

```
/spec-list
```

Shows overview of all specs with current phase and progress.

### Example 2: No Specs

```
/spec-list
```

Displays message about no specs found and suggests creating first spec.

## Important Notes

- **Phase Detection**: Automatically determines current phase from file presence
- **Progress Tracking**: Shows task completion ratios where applicable
- **Visual Indicators**: Uses emojis for quick status recognition
- **Next Actions**: Provides specific guidance for advancing each spec
- **No Arguments**: Command takes no parameters, always shows all specs
