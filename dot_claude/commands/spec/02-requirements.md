---
allowed-tools: [Read, Write, Edit, LS, Bash]
description: Generate or update requirements document for existing spec
---

# /spec-requirements

Generate or update requirements document for an existing spec.

## Context

- Feature name: $ARGUMENTS
- Current directory: !`pwd`
- Existing specs: !`ls .claude/specs/ 2>/dev/null || echo "No specs found"`
- Requirements template: !`ls ~/.claude/templates/requirements-template.md 2>/dev/null || echo "No template"`

## Usage

```
/spec-requirements [feature-name]
/spec-requirements user-authentication
```

## Your Task

**STEP 1: Identify Target Spec**

IF no feature-name provided:

- LIST available specs in `.claude/specs/` directory
- ASK user to specify which spec to work on
- EXIT with usage guidance

ELSE:

- VALIDATE spec directory exists at `.claude/specs/{feature-name}/`
- CHECK if requirements.md already exists
- LOAD existing requirements.md if present

**STEP 2: Load Requirements Template**

- READ requirements template from `~/.claude/templates/requirements-template.md`
- IF template not found, use built-in EARS format structure
- PREPARE template structure for population

**STEP 3: Generate Requirements Document**

- CREATE user stories using format: "As a [role], I want [feature], so that [benefit]"
- WRITE acceptance criteria in EARS format:
  - WHEN [event] THEN [system] SHALL [response]
  - IF [condition] THEN [system] SHALL [response]
- INCLUDE non-functional requirements (performance, security, usability)
- CONSIDER edge cases and error scenarios
- ENSURE requirements are testable and verifiable

**STEP 4: Present and Request Approval**

- DISPLAY complete requirements document
- ASK: "Do the requirements look good? If so, we can move on to the design."
- IF feedback provided, REVISE requirements accordingly
- CONTINUE revision cycle until explicit approval received

**STEP 5: Save and Complete**

- WRITE final requirements.md to `.claude/specs/{feature-name}/`
- CONFIRM requirements phase is complete
- **NEXT STEP**: User must run `/spec-design` to continue workflow

## Expected Output

Creates or updates requirements.md with:

```markdown
# Requirements Document

## Introduction

[Brief feature summary and context]

## Requirements

### Requirement 1: [Feature Name]

**User Story:** As a [role], I want [feature], so that [benefit]

#### Acceptance Criteria

1. WHEN [event] THEN [system] SHALL [response]
2. IF [condition] THEN [system] SHALL [response]

### Requirement 2: [Error Handling]

**User Story:** As a [role], I need [error handling], so that [system reliability]

#### Acceptance Criteria

1. WHEN [error occurs] THEN [system] SHALL [respond appropriately]
```

## Examples

### Example 1: New Requirements

```
/spec-requirements user-authentication
```

Generates comprehensive login/signup requirements with security considerations.

### Example 2: Update Existing

```
/spec-requirements data-export
```

Updates existing data export requirements based on new feedback.

## Important Notes

- **Template Source**: Uses global `~/.claude/templates/requirements-template.md`
- **EARS Format**: Follows Easy Approach to Requirements Syntax
- **Approval Required**: Must receive explicit user approval before proceeding
- **Next Phase**: User will use `/spec-design` to continue workflow
