---
allowed-tools: Bash, Read, Edit
description: Resolve git merge conflicts by analyzing and resolving conflicted files
argument-hint: "[optional-file-pattern|--review-only]"
---

# /resolve-merge-conflicts

Resolve git merge conflicts by analyzing conflicted files and providing resolution guidance.

## Context

- Current directory: !`pwd`
- Current git status: !`git status --porcelain`
- Current branch: !`git branch --show-current`
- Merge head info: !`git show --oneline --no-patch MERGE_HEAD 2>/dev/null || echo "No active merge"`
- Conflicted files: !`git diff --name-only --diff-filter=U 2>/dev/null || echo "No conflicts"`
- Recent commits: !`git log --oneline -3`

## Usage

```
/resolve-merge-conflicts
/resolve-merge-conflicts src/*.js
/resolve-merge-conflicts --review-only
```

## Your Task

**STEP 1: Validate Merge State**

- CHECK for active merge: `git status --porcelain | grep "^UU\|^AA\|^DD"`
- VERIFY repository is in merge state: check for `.git/MERGE_HEAD`

IF no merge conflicts detected:

- DISPLAY "No active merge conflicts found"
- SUGGEST checking if user needs to start a merge operation
- PROVIDE guidance: `git merge <branch>` or `git pull`
- EXIT gracefully

**STEP 2: Analyze Conflicted Files**

- GET list of conflicted files: `git diff --name-only --diff-filter=U`
- FILTER by file pattern if provided in arguments

FOR EACH conflicted file:

- READ the file content to identify conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
- ANALYZE the nature of conflicts:
  - Simple text conflicts (different lines)
  - Structural conflicts (function signatures, imports)
  - Logic conflicts (business rules, algorithms)
  - Binary file conflicts

**STEP 3: Categorize Conflicts**

**Auto-resolvable conflicts:**

- Formatting-only conflicts (whitespace, indentation)
- Import/dependency ordering conflicts
- Non-overlapping additions
- Comment-only changes
- Documentation updates

**Manual resolution required:**

- Logic conflicts in same function
- Conflicting variable names or types
- Architectural changes
- Security-sensitive modifications
- Binary file conflicts

**STEP 4: Resolve Conflicts**

FOR EACH auto-resolvable conflict:

- SHOW conflict context and proposed resolution
- APPLY automatic resolution using Edit tool
- VALIDATE syntax if code file
- STAGE resolved file: `git add <filename>`

FOR EACH complex conflict:

- DISPLAY conflict context from both branches
- SHOW original base version if available: `git show :1:<filename>`
- SHOW current branch version: `git show :2:<filename>`
- SHOW incoming branch version: `git show :3:<filename>`
- PROVIDE specific resolution recommendations
- GUIDE user through manual resolution steps

**STEP 5: Complete Merge**

IF all conflicts resolved:

- VERIFY no conflicts remain: `git diff --check`
- CONFIRM all files staged: `git status --porcelain`
- CREATE merge commit: `git commit -m "Merge: resolve conflicts in [file-list]"`
- SUMMARIZE resolution decisions made

**STEP 6: Provide Recovery Options**

IF resolution fails or user wants to abort:

- SHOW rollback command: `git merge --abort`
- PROVIDE reset option: `git reset --hard HEAD`
- RECOMMEND creating backup branch before retry
- SUGGEST alternative merge strategies if applicable

## Expected Output

### For successful resolution:

- List of files with conflicts found
- Categorization of conflict types (auto vs manual)
- Resolution summary for each file
- Final merge commit hash and message

### For manual intervention needed:

- Detailed conflict analysis per file
- Step-by-step resolution guidance
- Code snippets showing both versions
- Recommendations for merge strategy

### For error cases:

- Clear error messages
- Recovery commands
- Alternative approaches
- Next steps guidance

## Examples

### Example 1: Auto-resolve simple conflicts

```
/resolve-merge-conflicts
```

Analyzes all conflicted files and auto-resolves formatting/import conflicts

### Example 2: Focus on specific files

```
/resolve-merge-conflicts src/components/*.tsx
```

Only processes conflicts in TypeScript React components

### Example 3: Review conflicts without auto-resolution

```
/resolve-merge-conflicts --review-only
```

Analyzes conflicts and provides guidance without making changes

## Conflict Resolution Strategies

**For code conflicts:**

1. Preserve both changes if they don't conflict logically
2. Merge complementary functionality
3. Choose the more recent or comprehensive implementation
4. Maintain consistent code style and patterns

**For configuration conflicts:**

1. Merge non-conflicting settings
2. Prefer production-safe defaults
3. Validate final configuration syntax
4. Document resolution choices

**For documentation conflicts:**

1. Combine information from both versions
2. Maintain consistent formatting
3. Preserve important details from both branches
4. Update timestamps and version references

**IMPORTANT**: Always test resolved conflicts before completing the merge. Use `git diff --cached` to review staged changes and ensure resolution maintains code functionality and style consistency.
