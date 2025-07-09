---
allowed-tools: Task, Bash(gh:*), Bash(git:*), Bash(jq:*), Bash(gdate:*), Bash(osascript:*), Read, Write, Grep
description: Comprehensive Pull Request management with intelligent analysis and automation.
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

- `create [title] [body] [options]`: Create a new Pull Request.
- `review [PR_NUMBER] [approve|comment|request-changes]`: Review a Pull Request.
- `check [PR_NUMBER]`: Check the status and health of a Pull Request.
- `update [PR_NUMBER] [options]`: Update an existing Pull Request.

## Your Task

STEP 1: Execute Requested PR Action

CASE `action`:

WHEN `create`:

- ANALYZE commit history and file changes to intelligently generate PR title and body.
- ENSURE branch is pushed to remote.
- EXECUTE `gh pr create` with generated or provided content.

WHEN `review`:

- **CRITICAL: DEPLOY PARALLEL SUB-AGENTS** for comprehensive PR analysis (Code Quality, Security, Performance, Testing, Documentation, Dependencies, Code Style, Business Logic, CI/CD, Cross-Cutting Concerns).
- SYNTHESIZE findings from all agents.
- EXECUTE `gh pr review` with generated or provided review comments/decision.

WHEN `check`:

- **CRITICAL: DEPLOY PARALLEL SUB-AGENTS** for ultra-fast PR validation (CI/CD Health, Review Status, Merge Conflict, Security, Performance, Test Coverage, Integration Status, Documentation).
- SYNTHESIZE parallel agent results into a comprehensive PR health score and report.
- PROVIDE actionable insights and automated fix suggestions.

WHEN `update`:

- PARSE update options (title, body, labels, reviewers, milestone, state).
- EXECUTE `gh pr edit` or other `gh pr` commands to apply updates.

STEP 3: Finalization and Cleanup

- UPDATE session state with action results.
- CLEAN UP temporary session files.
- DISPLAY relevant output (e.g., PR URL, review summary, check report).
