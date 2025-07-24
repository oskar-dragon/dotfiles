---
allowed-tools: [Write, Read, Bash, LS]
description: Create a new feature specification with requirements gathering
---

## Context

- Feature name: $ARGUMENTS
- Current directory: !`pwd`
- Specs directory: !`ls -la .claude/specs/ 2>/dev/null || echo "No specs directory"`
- Available templates: !`ls ~/.claude/templates/ | grep -E "requirements|design|tasks"`

## Usage

```
/spec-create <feature-name> [description]
/spec-create user-authentication "Allow users to sign up and log in"
```

## Your Task

**STEP 1: Create Directory Structure**

IF specs directory doesn't exist:

- CREATE `.claude/specs/` directory using !`mkdir -p .claude/specs`

THEN:

- CREATE `.claude/specs/{feature-name}/` directory
- INITIALIZE empty requirements.md, design.md, and tasks.md files

**STEP 2: Parse Feature Input**

- EXTRACT feature name from $ARGUMENTS (first argument)
- EXTRACT optional description (remaining arguments)
- VALIDATE feature name uses kebab-case. If not, make sure it's converted to kebab-case
- BEGIN requirements gathering immediately

**STEP 3: Generate Requirements Document**

- READ requirements template from `.claude/templates/requirements-template.md`
- CREATE user stories using format: "As a [role], I want [feature], so that [benefit]"
- WRITE acceptance criteria in EARS format:
  - WHEN [event] THEN [system] SHALL [response]
  - IF [condition] THEN [system] SHALL [response]
- CONSIDER edge cases, error scenarios, and technical constraints
- WRITE requirements.md to specs directory

**STEP 4: Request User Approval**

- PRESENT complete requirements document
- ASK: "Do the requirements look good? If so, we can move on to the design."
- WAIT for explicit approval before proceeding
- **CRITICAL**: Do not proceed without user approval

**STEP 5: Complete Phase**

- CONFIRM requirements document is saved
- **DO NOT** run any scripts or proceed to next phase
- **NEXT STEP**: User must run `/spec-design` to continue workflow

## Expected Output

Creates the following structure:

```
.claude/specs/{feature-name}/
├── requirements.md     # User stories and acceptance criteria
├── design.md          # Empty (for next phase)
└── tasks.md           # Empty (for later phase)
```

Displays requirements document with:

- Feature overview
- User stories in proper format
- Acceptance criteria using EARS format
- Edge cases and constraints
- Request for user approval

## Examples

### Example 1: Basic Feature

```
/spec-create user-authentication "Allow users to sign up and log in"
```

Creates user authentication spec with login/signup requirements.

### Example 2: Complex Feature

```
/spec-create data-export "Export user data in multiple formats"
```

Creates data export spec with format options and privacy considerations.

## Important Notes

- **Phase Boundary**: This command only handles requirements gathering
- **No Scripts**: Does not execute implementation commands
- **Approval Required**: Must wait for user approval before continuing
- **Next Phase**: User must run `/spec-design` to continue workflow
