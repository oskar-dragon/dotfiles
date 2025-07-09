---
allowed-tools: [Bash, Read, Write, Edit, MultiEdit]
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

## Usage

```bash
/code/fix/bug-fix "Login form validation not working on mobile"
/code/fix/bug-fix "API returns 500 error for user profile endpoint"
/code/fix/bug-fix "Memory leak in data processing pipeline"
```

## Your Task

**STEP 1: Validate Repository State**

Verify prerequisites and repository status:

- CHECK if we're in a git repository
- WARN if there are uncommitted changes
- VERIFY gh CLI is available and authenticated
- ENSURE working directory is clean or manageable

**STEP 2: Create Feature Branch**

- GENERATE branch name: `bugfix/[sanitized-bug-description]`
- CREATE and checkout new branch
- ENSURE branch is based on latest main/master
- VERIFY branch creation was successful

**STEP 3: Investigate Bug**

**Root Cause Analysis:**

- EXAMINE recent commits that might have introduced the bug
- CHECK configuration files and environment variables
- REVIEW error logs and stack traces
- IDENTIFY affected files and components

**Investigation Techniques:**

- USE git blame to find when problematic code was introduced
- CHECK for similar issues in issue tracker
- REVIEW related test cases for clues
- EXAMINE data flow and dependencies

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
