---
allowed-tools: Read, Grep, Glob, Bash(rg:*), Bash(fd:*), Bash(git:*)
description: Comprehensive code review with context-aware analysis
---

## Context

- Project type: !`fd -t f 'package.json|go.mod' -d 1 | head -1 | xargs basename || echo 'unknown'`
- Git status: !`git status --porcelain | head -5 || echo 'Not a git repository'`
- Code files: !`fd -e ts -e js -e go | wc -l || echo 'unknown'`

## Your task

STEP 1: Initialize review session

- Load target files from $ARGUMENTS or analyze entire project if no specific targets
- Identify project structure and key files
- Determine programming language and frameworks

STEP 2: Gather context

- Read project configuration files (package.json, go.mod, etc.)
- Identify existing patterns and conventions
- Find test files and documentation
- Map project dependencies and structure

STEP 3: Multi-dimensional analysis

FOR EACH target file or component:

**Architecture Analysis:**

- Design patterns and architectural decisions
- Separation of concerns and modularity
- Code organization and structure
- Interface design and abstractions

**Security Assessment:**

- Input validation and sanitization
- Authentication and authorization
- Data handling and storage
- Potential vulnerabilities

**Performance Evaluation:**

- Algorithm efficiency and complexity
- Database query optimization
- Caching strategies and memory usage
- Resource utilization patterns

**Maintainability Review:**

- Code clarity and readability
- Documentation completeness
- Testing coverage and quality
- Error handling and logging

**Dependencies Analysis:**

- Security vulnerabilities in dependencies
- License compatibility
- Version currency and update needs
- Dependency complexity

STEP 4: Generate structured review report

## Output Format

```markdown
# Code Review Report

## Overview

[Brief summary of what was reviewed]

## Strengths

- [Architectural decisions that work well]
- [Implementation patterns worth preserving]
- [Effective security measures]
- [Performance optimizations in place]

## Critical Issues

- [Security vulnerabilities requiring immediate attention]
- [Performance bottlenecks with significant impact]
- [Architectural problems affecting scalability]
- [Broken or insufficient error handling]

## Improvement Recommendations

### High Priority

- [Security fixes and vulnerability patches]
- [Critical performance issues]
- [Data integrity problems]

### Medium Priority

- [Performance optimizations]
- [Maintainability improvements]
- [Testing coverage gaps]

### Low Priority

- [Code style and formatting]
- [Documentation improvements]
- [Refactoring opportunities]

## Technical Debt Assessment

- **Immediate**: [Issues blocking releases]
- **Short-term**: [Problems affecting development velocity]
- **Long-term**: [Strategic refactoring needs]

## Summary

- Files reviewed: [count]
- Issues found: [count]
- Recommendations: [count]
```
