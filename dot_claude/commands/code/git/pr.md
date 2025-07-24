---
allowed-tools: Bash, Read, Grep, Task
description: Pull Request management with analysis, creation, review, and updates
argument-hint: "[action] [arguments]"
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
/pr [action] [arguments]
```

### Actions:

- `create [title] [body]`: Create a new Pull Request
- `review [PR_NUMBER] [approve|comment|request-changes]`: Review a Pull Request  
- `check [PR_NUMBER]`: Check the status and health of a Pull Request
- `update [PR_NUMBER] [options]`: Update an existing Pull Request

## Your Task

**STEP 1: Validate Prerequisites**

- CHECK that current directory is a git repository
- VERIFY GitHub CLI is authenticated: `gh auth status`
- CONFIRM current branch exists and has commits

**STEP 2: Execute Requested PR Action**

**IF action is `create`:**
- ANALYZE recent commits for context: `git log --oneline -10`
- EXAMINE changed files: `git diff --name-status origin/main...HEAD`
- GENERATE intelligent PR title and body based on changes
- ENSURE branch is pushed: `git push -u origin $(git branch --show-current)`
- CREATE PR: `gh pr create --title "title" --body "body"`

**IF action is `review`:**
- FETCH PR details: `gh pr view [PR_NUMBER] --json files,commits,title,body`
- ANALYZE changed files using Read tool to understand modifications
- EXAMINE commit history for context
- IDENTIFY potential issues: security, performance, style, logic
- GENERATE comprehensive review comments
- SUBMIT review: `gh pr review [PR_NUMBER] --[approve|comment|request-changes] --body "review"`

**IF action is `check`:**
- GET PR status: `gh pr view [PR_NUMBER] --json statusCheckRollup,reviewDecision,mergeable`
- CHECK CI/CD status and failures
- ANALYZE merge conflicts if present
- REVIEW approval status and required reviewers
- EXAMINE linked issues and project status
- GENERATE health score and actionable recommendations

**IF action is `update`:**
- PARSE update options (title, body, labels, reviewers, milestone)
- APPLY updates: `gh pr edit [PR_NUMBER] --title "new title" --body "new body"`
- ADD/REMOVE labels: `gh pr edit [PR_NUMBER] --add-label "label"`
- MODIFY reviewers: `gh pr edit [PR_NUMBER] --add-reviewer "user"`

**STEP 3: Report Results**

- DISPLAY relevant output (PR URL, review summary, status report)
- PROVIDE actionable next steps
- SUGGEST improvements or follow-up actions

## Expected Output

### For `create`:
- New PR URL
- Summary of changes included
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

### Example 1: Create PR
```
/pr create "Add user authentication feature" "Implements OAuth 2.0 login flow with session management"
```

### Example 2: Review PR
```
/pr review 123 comment
```
Reviews PR #123 and provides detailed feedback

### Example 3: Check PR Health  
```
/pr check 456
```
Analyzes PR #456 status, CI, reviews, and merge readiness

### Example 4: Update PR
```
/pr update 789 --title "Updated: Fix authentication bug" --add-label "bug"
```

**IMPORTANT**: Requires GitHub CLI authentication and valid git repository. All PR operations use actual `gh` commands without fictional parallel processing.