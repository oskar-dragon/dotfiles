---
allowed-tools: Read, Write, Bash(git:*), Bash(eza:*), Bash(fd:*)
description: Generate architectural decision records using template and git history
argument-hint: "[optional: decision-title]"
---

# /create-decision

Generate a new architectural decision record (ADR) based on the template and current git changes.

## Context

- Current directory: !`pwd`
- Current branch: !`git branch --show-current`
- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Recent commits: !`git log --oneline -10`
- Decision records count: !`fd . docs/decisions/ --type f | wc -l`
- Latest decision number: !`eza docs/decisions/ | tail -1 | cut -d'-' -f1`
- Template: @docs/decisions/000-decision-template.md

## Usage

```
/create-decision
/create-decision "implement new authentication flow"
```

## Your Task

STEP 1: Analyze Current Git Context

- GET current branch name and compare with main branch
- IDENTIFY changes made in current branch using git diff and git log
- EXTRACT meaningful changes that warrant documentation
- AVOID referencing main branch directly (use origin/main or develop)

STEP 2: Determine Next Decision Number

- SCAN existing decision records using fd command
- FIND the highest numbered decision record using eza
- CALCULATE next sequential number (e.g., if highest is 012, next is 013)

STEP 3: Generate Decision Content

IF no title provided in $ARGUMENTS:

- PROMPT user for decision title based on git changes analysis

- ANALYZE git changes to populate context section
- CREATE decision record using template structure:
  - Context: Based on git history and branch changes
  - Decision: What was implemented/changed
  - Consequences: Positive/negative outcomes from the changes

STEP 4: Create Decision Record File

- GENERATE filename using format: [number]-[kebab-case-title].md
- WRITE decision record to docs/decisions/ directory using Write tool
- INCLUDE proper date, status, and structured content
- VALIDATE file creation and provide usage guidance

## Expected Output

The command generates:

- New decision record file in docs/decisions/
- Proper sequential numbering (e.g., 013-new-feature.md)
- Structured content based on template
- Context derived from git history
- Ready-to-review markdown file

## Examples

### Example 1: Auto-detect from git changes

```
/create-decision
```

**Process:**

- Analyzes current branch changes
- Finds 3 commits related to password reset functionality
- Prompts: "Title for decision record about password reset improvements?"
- Generates: `013-password-reset-flow-improvements.md`

### Example 2: Explicit title

```
/create-decision "migrate to new component architecture"
```

**Process:**

- Uses provided title: "migrate to new component architecture"
- Analyzes git changes for architectural modifications
- Generates: `013-migrate-to-new-component-architecture.md`

### Example 3: Generated content preview

```markdown
# 013: Password Reset Flow Improvements

**Date**: 2025-07-10
**Status**: Accepted

## Context

Based on changes in branch `fix-reset-password`:

- Modified reset password layout structure
- Fixed breaking issues with nested route handling
- Updated authentication flow to handle edge cases

The previous password reset implementation had issues with...

## Decision

We decided to restructure the password reset flow by:

- Implementing proper nested route handling
- Updating the layout component structure
- Adding error boundary handling

## Consequences

**Positive:**

- Improved user experience during password reset
- Better error handling and edge case coverage
- Cleaner component architecture

**Negative:**

- Requires testing of all password reset scenarios
- May need documentation updates for new flow

**Mitigation strategies:**

- Comprehensive testing of reset flow
- Update user documentation
- Monitor error rates post-deployment
```

## Important Notes

- **Sequential numbering**: Always use the next available number
- **Git context**: Leverage actual changes made in current branch
- **Template adherence**: Follow the established decision record format
- **Review process**: Generated records should be reviewed before committing
- **Cross-referencing**: Consider linking to related decisions when relevant

The command creates properly formatted decision records that capture the reasoning behind significant changes, making them valuable for future team members and architectural evolution tracking.
