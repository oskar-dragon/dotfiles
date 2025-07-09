---
allowed-tools: Bash(git status:*), Bash(git show:*), Bash(git log:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Read, Edit
description: Resolve git merge conflicts by analyzing and resolving conflicted files
---

# /resolve-merge-conflicts

Resolve git merge conflicts by analyzing conflicted files and providing resolution guidance.

## Context

- Current git status: !`git status --porcelain`
- Current branch: !`git branch --show-current`
- Merge head info: !`git show --oneline --no-patch MERGE_HEAD 2>/dev/null || echo "No active merge"`
- Conflicted files: !`git diff --name-only --diff-filter=U 2>/dev/null || echo "No conflicts"`
- Recent commits: !`git log --oneline -3`

## Your Task

STEP 1: Validate Merge State

IF no merge conflicts detected:

- PRINT "No active merge conflicts found"
- SUGGEST checking if user needs to start a merge operation
- EXIT with guidance

STEP 2: Analyze Conflicted Files

FOR EACH conflicted file:

- READ the file to understand conflict markers
- ANALYZE the nature of conflicts:
  - Simple text conflicts (different lines)
  - Structural conflicts (function signatures, imports)
  - Logic conflicts (business rules, algorithms)

STEP 3: Categorize Conflicts

**Auto-resolvable conflicts:**

- Formatting-only conflicts (whitespace, indentation)
- Import/dependency ordering conflicts
- Non-overlapping additions
- Comment-only changes

**Manual resolution required:**

- Logic conflicts in same function
- Conflicting variable names or types
- Architectural changes
- Security-sensitive modifications

STEP 4: Resolve Conflicts

FOR EACH auto-resolvable conflict:

- APPLY automatic resolution
- VALIDATE syntax if code file
- STAGE resolved file with `git add`

FOR EACH complex conflict:

- SHOW conflict context from both branches
- PROVIDE specific resolution recommendations
- GUIDE user through manual resolution

STEP 5: Complete Merge

IF all conflicts resolved:

- VERIFY no conflicts remain: `git diff --check`
- CREATE merge commit with descriptive message
- SUMMARIZE resolution decisions

STEP 6: Error Handling

IF resolution fails:

- PROVIDE rollback instructions
- SAVE current state for recovery
- RECOMMEND manual resolution steps
