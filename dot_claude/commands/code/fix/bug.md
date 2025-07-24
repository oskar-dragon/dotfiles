---
allowed-tools: [Bash, Read, Write, Edit, MultiEdit, Grep, Glob]
description: Systematic bug investigation and fix workflow with GitHub integration
---

# /code/fix/bug-fix

Systematic bug investigation and fix workflow with GitHub integration.

## Context

Use this command to systematically investigate and fix bugs with proper workflow management:

- Bug description: $ARGUMENTS
- Current directory: !`pwd`
- Git status: !`git status --porcelain | wc -l | tr -d ' '` changes pending
- Current branch: !`git branch --show-current 2>/dev/null || echo "No git repository"`
- GitHub CLI: !`gh auth status --hostname github.com 2>/dev/null | head -1 || echo "GitHub CLI not authenticated"`

## Usage

```bash
/code:fix:bug "Login form validation not working on mobile"
/code/fix/bug-fix "API returns 500 error for user profile endpoint"
/code/fix/bug-fix "Memory leak in data processing pipeline"
```

## Your Task

**STEP 1: Validate Repository State**

IF not in git repository:
- ABORT with error message
- SUGGEST initializing git repository

IF uncommitted changes exist:
- WARN user about uncommitted changes
- RECOMMEND stashing or committing changes first

IF gh CLI not authenticated:
- WARN about GitHub integration limitations
- SUGGEST running `gh auth login`

VERIFY working directory is clean or manageable

**STEP 2: Create Feature Branch**

- GENERATE branch name: `bugfix/[sanitized-bug-description]`
- CREATE and checkout new branch
- ENSURE branch is based on latest main/master
- VERIFY branch creation was successful

**STEP 3: Investigate Bug**

FOR EACH investigation technique:

**Root Cause Analysis:**
- EXAMINE recent commits: `git log --oneline -n 10`
- CHECK configuration files and environment variables
- REVIEW error logs and stack traces
- IDENTIFY affected files using Grep and Glob tools

**Investigation Techniques:**
- USE `git blame` on suspect files
- SEARCH for similar issues in repository
- REVIEW related test cases for patterns
- TRACE data flow and dependencies

**STEP 4: Implement Fix**

- APPLY minimal fix that addresses root cause
- AVOID over-engineering or scope creep
- ENSURE fix doesn't break existing functionality
- ADD comments explaining the fix if non-obvious

**STEP 5: Add or Update Tests**

- WRITE test cases that reproduce the bug
- VERIFY tests fail before fix and pass after
- UPDATE existing tests if behavior changed
- ENSURE good test coverage for the fix

**STEP 6: Validate Fix**

- RUN existing test suite to verify no regressions
- PERFORM manual testing of the fix
- TEST edge cases and error conditions
- VERIFY performance impact is acceptable

**STEP 7: Commit and Push**

CREATE semantic commit message:

```
fix: brief description of bug fix

- Specific change made
- Another specific change

Resolves: [brief description of what was fixed]
```

**STEP 8: Create Pull Request**

CREATE PR with:

- CLEAR title describing the fix
- REFERENCE any related issues if applicable
- SUMMARY of changes made
- TESTING performed
- ANY additional context needed

**STEP 9: Final Validation**

- ENSURE all tests pass in CI
- REVIEW the changes one more time
- CONFIRM the fix addresses the original issue
- DOCUMENT the fix for future reference

## Bug Investigation Patterns

### Performance Issues

- PROFILE the code to identify bottlenecks
- CHECK for memory leaks or inefficient algorithms
- ANALYZE database queries and API calls
- REVIEW caching strategies

### Integration Issues

- VERIFY API contracts and data formats
- CHECK service dependencies and timeouts
- VALIDATE configuration across environments
- TEST error handling and fallback mechanisms

### Logic Errors

- TRACE through the code execution path
- CHECK boundary conditions and edge cases
- VERIFY input validation and sanitization
- REVIEW mathematical calculations and comparisons

## Quality Checklist

- [ ] Root cause identified and documented
- [ ] Minimal fix applied (no scope creep)
- [ ] Tests added or updated
- [ ] No regressions introduced
- [ ] Performance impact acceptable
- [ ] Code follows team conventions
- [ ] Documentation updated if needed

## Examples

### Example 1: Frontend Bug

`/code/fix/bug-fix "Login form validation not working on mobile"`

Investigates mobile-specific validation issues, creates branch, fixes CSS/JavaScript, adds tests, and creates PR.

### Example 2: Backend Bug

`/code/fix/bug-fix "API returns 500 error for user profile endpoint"`

Analyzes server logs, identifies root cause, fixes endpoint logic, adds error handling tests, and validates fix.

### Example 3: Performance Bug

`/code/fix/bug-fix "Memory leak in data processing pipeline"`

Profiles memory usage, identifies leak source, implements proper cleanup, adds memory tests, and verifies fix.

**IMPORTANT**: Follow the systematic workflow to ensure proper bug resolution with full traceability and testing.
