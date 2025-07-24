---
allowed-tools: Bash(git:*), Bash(gh:*)
description: Create commit, push, and open pull request
---

## Context

- Current git status: !`git status --porcelain`
- Current branch: !`git branch --show-current`
- Remote tracking: !`git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "No upstream branch"`

## Your task

STEP 1: Analyze current state

- Check git status to see staged/unstaged changes
- IF no staged changes:
  - Review unstaged changes with `git diff --stat`
  - Stage appropriate files with `git add`
- ELSE:
  - Review staged changes with `git diff --cached --stat`

STEP 2: Create commit

- IF $ARGUMENTS provided:
  - Use as commit message
- ELSE:
  - Analyze changes with `git diff --cached`
  - Generate conventional commit message (feat:, fix:, docs:, etc.)
- Create commit with proper message format

STEP 3: Push to remote

- Get current branch name
- IF no upstream branch:
  - Push with upstream: `git push -u origin [branch-name]`
- ELSE:
  - Push normally: `git push`

STEP 4: Create pull request

- Generate PR title from commit message
- Create PR with `gh pr create`
- Include basic PR template:
  - Summary of changes
  - Key modifications
  - Test plan checklist

STEP 5: Return result

- Display created PR URL
- Confirm successful completion

## Example Output

```
✅ Commit created: feat: add user authentication
✅ Pushed to origin/feature-branch
✅ Pull request created: https://github.com/user/repo/pull/123

Next steps:
- Review the PR
- Request reviewers if needed
- Merge when approved
```
