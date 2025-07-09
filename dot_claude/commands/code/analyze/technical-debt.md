---
allowed-tools: [Read, Glob, Grep, Bash, LS]
description: Analyze technical debt in codebase and provide prioritized remediation plan
---

# /code/analyze/technical-debt

Analyze technical debt in codebase and provide prioritized remediation plan.

## Context

Use this command to identify technical debt issues across your codebase and get actionable recommendations for improvement:

- Current directory: !`pwd`
- Git status: !`git status --porcelain 2>/dev/null || echo "Not a git repository"`
- Code files: !`fd -e go -e ts -e js -e py . | wc -l | tr -d ' '` found
- Target: $ARGUMENTS (optional scope filter)

## Usage

```bash
/code/analyze/technical-debt
/code/analyze/technical-debt "src/components"
/code/analyze/technical-debt --type=security
```

## Your Task

**STEP 1: Discovery and Assessment**

Analyze the current directory and subdirectories for technical debt patterns:

- USE Glob to find all relevant source files
- READ package.json, go.mod, or similar to understand dependencies
- GREP for common technical debt indicators
- ASSESS project structure and file organization

**STEP 2: Code Quality Analysis**

FOR EACH source file type in the project:
- IDENTIFY large files and complex functions
- SEARCH for code smells and anti-patterns
- FIND TODO/FIXME/HACK comments
- ANALYZE cyclomatic complexity indicators

**STEP 3: Dependency and Security Analysis**

IF Go project detected:
- CHECK for outdated dependencies: `go list -u -m all`
- SCAN for security vulnerabilities
- IDENTIFY unused packages

ELSE IF Node.js project detected:
- RUN `npm audit` for security issues
- CHECK for outdated packages: `npm outdated`
- IDENTIFY unused dependencies

ELSE:
- ANALYZE based on detected project type
- FOCUS on language-specific patterns

**STEP 4: Performance and Testing Assessment**

- IDENTIFY inefficient patterns and potential bottlenecks
- CHECK test coverage and missing critical tests
- FIND performance anti-patterns (N+1 queries, memory leaks)
- ASSESS documentation quality and completeness

**STEP 5: Generate Prioritized Remediation Plan**

CREATE structured report with:
- CATEGORIZE issues by priority (High/Medium/Low)
- PROVIDE specific file paths and line numbers
- ESTIMATE effort required for each fix
- SUGGEST prevention strategies

## Expected Output

```markdown
# Technical Debt Analysis Report

## Executive Summary
- Overall debt score: [Score/10]
- Critical issues found: [Number]
- Recommended immediate actions: [Top 3]

## Priority Matrix

### High Priority (Security & Critical Performance)
1. **[Issue Type]** - [File:Line]
   - Impact: [Description]
   - Effort: [Small/Medium/Large]
   - Action: [Specific steps]

### Medium Priority (Code Quality & Testing)
2. **[Issue Type]** - [File:Line]
   - Impact: [Description]
   - Effort: [Small/Medium/Large]
   - Action: [Specific steps]

### Low Priority (Documentation & Refactoring)
3. **[Issue Type]** - [File:Line]
   - Impact: [Description]
   - Effort: [Small/Medium/Large]
   - Action: [Specific steps]

## Detailed Findings

### Code Quality Issues
- Large files (>500 lines): [List with line counts]
- Complex functions: [List with complexity indicators]
- Code smells: [Specific patterns found]

### Security Vulnerabilities
- Dependency vulnerabilities: [List with severity]
- Code security issues: [Hardcoded secrets, etc.]

### Performance Issues
- Inefficient patterns: [Database queries, loops, etc.]
- Memory allocation problems: [Specific cases]

### Testing Gaps
- Missing test coverage: [Critical areas]
- Flaky test patterns: [Identified issues]

## Remediation Plan

### Week 1-2 (High Priority)
1. [ ] Fix security vulnerabilities
2. [ ] Address critical performance issues
3. [ ] Implement missing critical tests

### Week 3-4 (Medium Priority)
1. [ ] Refactor large files
2. [ ] Improve code quality
3. [ ] Increase test coverage

### Ongoing (Low Priority)
1. [ ] Update documentation
2. [ ] Code style improvements
3. [ ] Dependency updates

## Prevention Strategies
- Pre-commit hooks for code quality
- Automated security scanning
- Regular dependency updates
- Code review guidelines
```

## Analysis Commands

### Go Projects
```bash
# Large files
fd "\.go$" . --exec wc -l {} \; | sort -rn | head -10

# Technical debt indicators
rg "interface\{\}" --type go -n
rg "TODO|FIXME|HACK" --type go -n

# Security patterns
rg "password.*=|secret.*=" --type go -n
```

### TypeScript/JavaScript Projects
```bash
# Complex files
fd "\.ts$|\.js$" . --exec wc -l {} \; | sort -rn | head -10

# Security issues
rg "password.*=|secret.*=" -n
rg "eval\(|exec\(" -n

# Code smells
rg "any\s+=" --type typescript -n
```

## Examples

### Example 1: Full Analysis
`/code/analyze/technical-debt`

Performs comprehensive technical debt analysis of entire codebase.

### Example 2: Focused Analysis
`/code/analyze/technical-debt "src/components"`

Analyzes technical debt only in the components directory.

**IMPORTANT**: Focus on actionable, prioritized recommendations with specific file paths and clear remediation steps.