---
allowed-tools: [Read, Write, Edit, LS, Bash, Task, Grep, Glob]
description: Execute project tasks
---

# /project-execute

Execute project tasks

## Context

- Project name: $ARGUMENTS (first argument)
- Task ID: $ARGUMENTS (second argument, optional)
- Current directory: !`pwd`
- Vault directory: Current directory (assumes running from Obsidian vault)
- Available projects: !`ls .claude/specs 2>/dev/null || echo "No projects yet"`

## Usage

```
/project:03-execute <project-name> [task-id]
/project:03-execute website-redesign            # Execute next pending task
/project:03-execute website-redesign 1          # Execute task 1
/project:03-execute website-redesign 2.1        # Execute sub-task 2.1
```

## Your Task

**STEP 1: Validate Prerequisites**

IF no project-name provided:

- LIST available projects in `.claude/specs/` directory
- ASK user to specify which project to execute
- EXIT with usage guidance

ELSE:

- USE current directory as vault
- VALIDATE project directory exists at `.claude/specs/{project-name}/`
- CHECK tasks.md exists and contains approved tasks
- LOAD project.md and tasks.md for context
- VALIDATE tasks are approved (check for approval marker)

**STEP 2: Identify Target Task**

IF task-id provided:

- FIND specific task by ID in tasks.md
- VALIDATE task exists and is executable
- CHECK task dependencies are complete

ELSE:

- FIND next pending task (first `- [ ]` in tasks.md)
- IF no pending tasks found, INFORM user project is complete

**STEP 3: Execute Single Task**

IMPLEMENT the identified task:

- FOCUS on ONE task only, never multiple tasks
- FOLLOW project context and goals from project.md
- APPLY task-specific requirements and deliverables
- INCLUDE appropriate validation and quality checks
- VERIFY against task completion criteria

**STEP 4: Validate Implementation**

- CHECK deliverable matches task specification
- VERIFY quality standards are met
- ENSURE task contributes to project goals
- VALIDATE any dependencies for subsequent tasks

**STEP 5: Mark Completion and Stop**

- **CRITICAL**: UPDATE tasks.md by changing `- [ ]` to `- [x]` for completed task
- CONFIRM task completion status to user
- STOP execution and wait for user review
- **DO NOT** automatically proceed to next task
- **DO NOT** execute multiple tasks in sequence

## Expected Output

Executes a single task with validation and completion tracking:

```
Executing task 1: Research competitor websites
- Analyzed 5 competitor websites for design patterns
- Documented key UX elements and features
- Created comparison matrix in project notes
- Identified 3 design trends to incorporate

Task 1 has been marked as complete in tasks.md.

Next steps: Run /project:03-execute website-redesign to continue with task 2.
```

## Examples

### Example 1: Next Pending Task

```
/project:03-execute website-redesign
```

Executes the next incomplete task in the website-redesign project.

### Example 2: Specific Task

```
/project:03-execute website-redesign 2.1
```

Executes task 2.1 specifically, if dependencies are met.

### Example 3: Different Project

```
/project:03-execute blog-content-strategy
```

Executes next pending task in the Blog Content Strategy project.

## Important Notes

- **Single Task Focus**: Only executes ONE task per command invocation
- **Task Completion**: Always marks completed tasks as `[x]` in tasks.md
- **Stop and Wait**: Never automatically proceeds to next task
- **User Approval**: Requires user to run command again for next task
- **Dependency Checking**: Validates task prerequisites before execution
- **Obsidian Integration**: Works with files in `.claude/specs/` directory

## Error Handling

- **Missing Project**: Lists available projects if project name not found
- **Missing Tasks**: Directs to `/project:02-tasks {project-name}` if tasks.md doesn't exist
- **Invalid Task ID**: Shows available tasks if task-id not found
- **No Pending Tasks**: Informs user when project implementation is complete
