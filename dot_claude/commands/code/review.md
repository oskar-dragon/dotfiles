---
allowed-tools: Read, Grep, Glob, Bash
description: Comprehensive code review with security, performance, and maintainability analysis
argument-hint: "[file-patterns or leave empty for full project]"
---

# /code/review

Performs comprehensive code review analyzing security, performance, architecture, and maintainability.

## Context

- Current directory: !`pwd`
- Project type: !`fd -t f 'package.json|go.mod|Cargo.toml' -d 1 | head -1 | xargs basename || echo 'unknown'`
- Git status: !`git status --porcelain | head -5 || echo 'Not a git repository'`
- Target files: $ARGUMENTS (or full project if empty)

## Usage

```
/code/review                    # Review entire project
/code/review "src/**/*.ts"      # Review TypeScript files
/code/review "lib/auth.go"      # Review specific file
```

## Your Task

**STEP 1: Scope Analysis**

IF $ARGUMENTS provided:
- USE Glob to find files matching the patterns
- FOCUS review on specified files/patterns

ELSE:
- IDENTIFY project structure using fd commands
- DETERMINE primary language and framework
- SELECT key files for comprehensive review

**STEP 2: Context Gathering**

- READ project configuration files (package.json, go.mod, Cargo.toml)
- IDENTIFY coding patterns and conventions
- LOCATE test files and documentation
- ANALYZE project dependencies

**STEP 3: Multi-Dimensional Analysis**

FOR EACH target file or component:

- **Architecture**: Design patterns, modularity, separation of concerns
- **Security**: Input validation, auth mechanisms, vulnerability assessment
- **Performance**: Algorithm efficiency, database queries, memory usage
- **Maintainability**: Code clarity, documentation, test coverage, error handling
- **Dependencies**: Security audit, license compatibility, version currency

**STEP 4: Generate Structured Report**

ORGANIZE findings into prioritized categories with actionable recommendations.

## Expected Output

The command generates a structured markdown report with:

```markdown
# Code Review Report

## Overview
Brief summary of scope and key findings

## Strengths
- Well-implemented architectural patterns
- Effective security measures
- Performance optimizations

## Critical Issues  
- Security vulnerabilities (immediate attention)
- Performance bottlenecks
- Architectural problems

## Recommendations

### High Priority
- Security fixes and patches
- Critical performance issues
- Data integrity problems

### Medium Priority
- Performance optimizations
- Maintainability improvements
- Test coverage gaps

### Low Priority
- Code style improvements
- Documentation enhancements
- Refactoring opportunities

## Technical Debt
- **Immediate**: Release blockers
- **Short-term**: Development velocity issues  
- **Long-term**: Strategic refactoring needs

## Summary
Files reviewed, issues found, actionable recommendations
```

## Examples

### Example 1: Full Project Review
`/code/review`
Reviews entire codebase with comprehensive analysis across all dimensions.

### Example 2: Specific Component
`/code/review "src/auth/**/*.ts"`
Focused review of authentication-related TypeScript files.

### Example 3: Single File
`/code/review "server.go"`
Detailed analysis of a specific Go server file.

**IMPORTANT**: Focus on actionable, prioritized recommendations. Highlight security issues and performance bottlenecks first.
