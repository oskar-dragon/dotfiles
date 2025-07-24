---
allowed-tools: [Read, Write, Edit, LS, Bash, Task, Grep, Glob]
description: Execute implementation tasks from approved task list
---

# /spec-execute

Execute implementation tasks from approved task list.

## Context

- Spec name: $ARGUMENTS (first argument)
- Task ID: $ARGUMENTS (second argument, optional)
- Current directory: !`pwd`
- Available specs: !`ls .claude/specs/ 2>/dev/null || echo "No specs found"`
- Tasks status: !`find .claude/specs/ -name "tasks.md" -exec grep -l "\- \[x\]" {} \; 2>/dev/null | wc -l || echo "0"` specs with completed tasks

## Usage

```
/spec-execute <spec-name> [task-id]
/spec-execute user-authentication          # Execute next pending task
/spec-execute user-authentication 1        # Execute task 1
/spec-execute user-authentication 2.1      # Execute sub-task 2.1
```

## Your Task

**STEP 1: Validate Prerequisites**

IF no spec-name provided:

- LIST available specs in `.claude/specs/` directory
- ASK user to specify which spec to execute
- EXIT with usage guidance

ELSE:

- VALIDATE spec directory exists at `.claude/specs/{spec-name}/`
- CHECK tasks.md exists and contains approved tasks
- LOAD requirements.md, design.md, and tasks.md for context
- VALIDATE tasks are approved (check for approval marker)

**STEP 2: Identify Target Task**

IF task-id provided:

- FIND specific task by ID in tasks.md
- VALIDATE task exists and is executable
- CHECK task dependencies are complete

ELSE:

- FIND next pending task (first `- [ ]` in tasks.md)
- IF no pending tasks found, INFORM user spec is complete

**STEP 3: Execute Single Task**

IMPLEMENT the identified task:

- FOCUS on ONE task only, never multiple tasks
- FOLLOW implementation details from design.md
- USE existing code patterns and conventions discovered via Task tool
- INCLUDE appropriate error handling and validation
- ADD unit tests where specified in task requirements
- VERIFY against acceptance criteria referenced in task

**STEP 4: Validate Implementation**

- RUN tests if they exist in the project
- CHECK for lint/type errors using project commands
- VERIFY integration with existing codebase
- ENSURE implementation meets task requirements

**STEP 5: Mark Completion and Stop**

- **CRITICAL**: UPDATE tasks.md by changing `- [ ]` to `- [x]` for completed task
- CONFIRM task completion status to user
- STOP execution and wait for user review
- **DO NOT** automatically proceed to next task
- **DO NOT** execute multiple tasks in sequence

## Expected Output

Executes a single task with validation and completion tracking:

```
Executing task 1: Setup project structure
- Created src/auth/ directory structure
- Defined AuthService interface in src/auth/types.ts
- Setup test directory structure
- Requirements 1.1 satisfied

Task 1 has been marked as complete in tasks.md.

Next steps: Run /spec-execute user-authentication to continue with task 2.
```

## Examples

### Example 1: Next Pending Task

```
/spec-execute user-authentication
```

Executes the next incomplete task in the user-authentication spec.

### Example 2: Specific Task

```
/spec-execute user-authentication 2.1
```

Executes task 2.1 specifically, if dependencies are met.

### Example 3: Different Spec

```
/spec-execute data-export
```

Executes next pending task in the data-export specification.

## Important Notes

- **Single Task Focus**: Only executes ONE task per command invocation
- **Task Completion**: Always marks completed tasks as `[x]` in tasks.md
- **Stop and Wait**: Never automatically proceeds to next task
- **User Approval**: Requires user to run command again for next task
- **Dependency Checking**: Validates task prerequisites before execution
- **Code Integration**: Uses Task tool to understand existing codebase patterns

## Error Handling

- **Missing Spec**: Lists available specs if spec-name not found
- **Missing Tasks**: Directs to `/spec-tasks {spec-name}` if tasks.md doesn't exist
- **Invalid Task ID**: Shows available tasks if task-id not found
- **No Pending Tasks**: Informs user when spec implementation is complete
