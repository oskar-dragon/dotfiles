---
allowed-tools: [Read, Write, Edit, LS, Bash]
description: Generate implementation task breakdown based on approved design
---

## Context

- Feature name: $ARGUMENTS
- Current directory: !`pwd`
- Existing specs: !`ls .claude/specs/ 2>/dev/null || echo "No specs found"`
- Tasks template: !`ls ~/.claude/templates/tasks-template.md 2>/dev/null || echo "No template"`
- Design status: !`ls .claude/specs/*/design.md 2>/dev/null | wc -l || echo "0"` designs found

## Usage

```
/code:spec:04-task [feature-name]
/code:spec:04-task user-authentication
```

## Your Task

**STEP 1: Validate Prerequisites**

IF no feature-name provided:

- LIST available specs in `.claude/specs/` directory
- ASK user to specify which spec to work on
- EXIT with usage guidance

ELSE:

- VALIDATE spec directory exists at `.claude/specs/{feature-name}/`
- CHECK design.md exists and is complete
- LOAD both requirements.md and design.md for context
- VALIDATE design is approved (check for approval marker)

**STEP 2: Load Tasks Template**

- READ tasks template from `~/.claude/templates/tasks-template.md`
- IF template not found, use built-in task structure
- PREPARE template structure for task breakdown

**STEP 3: Generate Task Breakdown**

CREATE atomic, executable coding tasks:

- BREAK design into concrete implementation steps
- USE checkbox format with numbered hierarchy
- INCLUDE specific file names and components to create/modify
- REFERENCE requirements using _Requirements: X.Y_ format
- BUILD incrementally (each task builds on previous)
- FOCUS on coding tasks only (exclude deployment, user testing, documentation)

**STEP 4: Apply Task Guidelines**

ENSURE each task:

- Has clear, actionable objective
- Specifies files to create or modify
- References specific requirements
- Uses test-driven development approach where applicable
- Builds incrementally on previous tasks

**STEP 5: Present and Request Approval**

- DISPLAY complete task breakdown
- ASK: "Do the tasks look good?"
- IF feedback provided, REVISE tasks accordingly
- CONTINUE revision cycle until explicit approval received

**STEP 6: Complete Phase**

- WRITE final tasks.md to `.claude/specs/{feature-name}/`
- CONFIRM tasks phase is complete
- **CRITICAL**: Do not run any implementation commands yet
- **NEXT STEP**: Tasks ready for execution using `/spec-execute {feature-name}`

## Expected Output

Creates tasks.md with implementation breakdown:

```markdown
# Implementation Plan

- [ ] 1. Setup project structure
  - Create src/auth/ directory structure
  - Define AuthService types in src/auth/types.ts
  - Setup test directory structure
  - _Requirements: 1.1_

- [ ] 2. Implement data models
  - Create User model in src/auth/models/User.ts
  - Add validation methods for email/password
  - Write unit tests for User model
  - _Requirements: 2.1, 2.2_

- [ ] 3. Create authentication service
  - Implement login method in AuthService
  - Add password hashing utilities
  - Create JWT token generation
  - Write integration tests
  - _Requirements: 1.2, 2.3_
```

## Task Guidelines

**Included Task Types:**

- Component/module creation
- Types definitions
- Business logic implementation
- Database model creation
- Unit and integration tests
- API endpoint implementation

**Excluded Task Types:**

- User acceptance testing
- Production deployment
- Performance metrics gathering
- User training documentation
- Business process changes

## Examples

### Example 1: Authentication Tasks

```
/spec-tasks user-authentication
```

Creates task breakdown for login/signup implementation with security patterns.

### Example 2: Data Export Tasks

```
/spec-tasks data-export
```

Creates task breakdown for export functionality with multiple format support.

## Important Notes

- **Prerequisites**: Requires approved design.md
- **Template Source**: Uses global `~/.claude/templates/tasks-template.md`
- **Task Format**: Checkbox format with requirement references
- **Approval Required**: Must receive explicit user approval before proceeding
- **No Implementation**: Only creates task breakdown, does not execute code
- **Next Phase**: User has to use `/spec-execute {feature-name}` to begin implementation
