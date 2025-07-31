---
allowed-tools: Bash, Read, Grep, Task
description: Pull Request management with analysis, creation, review, and updates
argument-hint: "[create|review|check|update] [PR_NUMBER|title] [--focus quality|security|performance|architecture] [--depth quick|deep] [--action approve|comment|request-changes]"
---

# /pr

Manage Pull Requests with intelligent analysis, creation, review, and update capabilities.

## Context

- Current directory: !`pwd`
- Current branch: !`git branch --show-current 2>/dev/null || echo "no-git-repo"`
- Git status: !`git status --porcelain 2>/dev/null | wc -l | tr -d ' ' || echo "0"` files changed
- GitHub CLI status: !`gh auth status 2>/dev/null | head -1 || echo "Not authenticated"`

## Usage

```
/pr [action] [target] [options]
```

### Actions:

- `create [title]`: Create a new Pull Request with optional title
- `review [PR_NUMBER]`: Review a Pull Request with analysis
- `check [PR_NUMBER]`: Check the status and health of a Pull Request
- `update [PR_NUMBER]`: Update an existing Pull Request

### Options:

- `--focus quality|security|performance|architecture`: Focus analysis on specific aspect
- `--depth quick|deep`: Level of analysis detail
- `--action approve|comment|request-changes`: Review action (for review command)

## Your Task

**STEP 1: Validate Prerequisites**

- CHECK that current directory is a git repository
- VERIFY GitHub CLI is authenticated: `gh auth status`
- CONFIRM current branch exists and has commits

**STEP 2: Parse Options and Execute Action**

**Parse Global Options:**

- `--focus`: Determine analysis focus (quality, security, performance, architecture)
- `--depth`: Set analysis level (quick for summary, deep for detailed analysis)
- `--action`: Set review action (approve, comment, request-changes)

**IF action is `create`:**

- ANALYZE recent commits for context: `git log --oneline -10`
- EXAMINE changed files: `git diff --name-status origin/main...HEAD`
- READ modified files to understand code changes
- APPLY focus filter if specified (e.g., --focus security checks for vulnerabilities)
- GENERATE intelligent PR title (use provided title or auto-generate)
- CREATE PR body using this template structure:

  ```
  ## Summary
  [2 sentences describing what this PR adds to the code]

  ## Visual Changes
  [List any UI/visual changes, or "None" if no visual changes]

  ## How to test
  [Bullet points with specific testing steps for reviewers]
  ```

- TAILOR content based on depth level (quick=basic steps, deep=comprehensive testing scenarios)
- DISPLAY PR preview with title and body for user review
- ASK user for confirmation: "Create this PR as draft? (y/n)"
- IF user confirms, ENSURE branch is pushed: `git push -u origin $(git branch --show-current)`
- CREATE DRAFT PR: `gh pr create --draft --title "title" --body "body"`

**IF action is `review`:**

- FETCH PR details: `gh pr view [PR_NUMBER] --json files,commits,title,body`
- ANALYZE changed files using Read tool to understand modifications
- APPLY focus filter (quality=code patterns, security=vulnerabilities, performance=bottlenecks, architecture=design)
- GENERATE review based on depth (quick=high-level, deep=line-by-line)
- SUBMIT review with specified action: `gh pr review [PR_NUMBER] --[action] --body "review"`

**IF action is `check`:**

- GET PR status: `gh pr view [PR_NUMBER] --json statusCheckRollup,reviewDecision,mergeable`
- APPLY focus to status checks (e.g., --focus security highlights failed security scans)
- GENERATE report based on depth (quick=summary, deep=detailed breakdown)
- PROVIDE actionable recommendations filtered by focus area

**IF action is `update`:**

- PARSE update requirements from context
- APPLY updates: `gh pr edit [PR_NUMBER] --title "new title" --body "new body"`
- ADD/REMOVE labels based on focus area
- MODIFY reviewers based on focus expertise

**STEP 3: Report Results**

- DISPLAY relevant output (PR URL, review summary, status report)
- PROVIDE actionable next steps
- SUGGEST improvements or follow-up actions

## Expected Output

### For `create`:

- Preview of PR title and body before creation
- User confirmation prompt for draft PR creation
- New draft PR URL (if confirmed)
- PR body following template structure:
  - **Summary**: 2-sentence description of changes
  - **Visual Changes**: UI/visual modifications or "None"
  - **How to test**: Bullet points with testing steps for reviewers
- Suggested reviewers based on file changes

### For `review`:

- Comprehensive review summary
- Specific code feedback with line references
- Overall recommendation (approve/request changes)

### For `check`:

- PR health score (0-100)
- CI/CD status breakdown
- Merge readiness assessment
- Action items to resolve issues

### For `update`:

- Confirmation of applied changes
- Updated PR summary
- Any validation warnings

## Examples

### Example 1: Create PR with Security Focus

```
/pr create "Add user authentication feature" --focus security --depth deep
```

Shows preview with structured template including:

- Summary focused on security implications
- Visual changes (login forms, security indicators)
- Comprehensive testing steps for authentication flow
  Then prompts for confirmation before creating as draft PR

### Example 2: Quick Review with Approval

```
/pr review 123 --depth quick --action approve
```

Performs high-level review of PR #123 and approves if no issues found

### Example 3: Deep Architecture Check

```
/pr check 456 --focus architecture --depth deep
```

Analyzes PR #456 with detailed architectural impact assessment

### Example 4: Performance-Focused Review

```
/pr review 789 --focus performance --action comment
```

Reviews PR #789 specifically for performance implications and provides feedback

### Example 5: Quick Status Check

```
/pr check 101 --depth quick
```

Gets summary status of PR #101 including CI and approval state

**IMPORTANT**: Requires GitHub CLI authentication and valid git repository. All PR operations use actual `gh` commands without fictional parallel processing.
