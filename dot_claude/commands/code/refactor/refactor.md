---
description: Analyze code for refactoring opportunities and provide improvement recommendations
allowed-tools: ["Read", "Edit", "MultiEdit", "Bash", "Glob", "Grep", "LS"]
---

## Context

Use this command when you need to identify code smells, architectural issues, or improvement opportunities in your codebase. Best suited for analyzing existing code quality and planning refactoring work.

## Dynamic Context

```bash
echo "Current working directory: $(pwd)"
echo "Git status: $(git status --porcelain | wc -l) modified files"
echo "Total files: $(find . -type f -name '*.ts' -o -name '*.js' -o -name '*.go' | wc -l)"
echo "Test files: $(find . -type f -name '*.test.*' -o -name '*_test.go' | wc -l)"
echo "Recent commits: $(git log --oneline -5)"
```

## Task

### STEP 1: Code Discovery and Analysis

- Scan target files/directories using Glob and Grep tools
- Identify file patterns, sizes, and complexity indicators
- Generate codebase structure overview
- Detect technology stack and conventions

### STEP 2: Code Quality Assessment

- Analyze for common code smells:
  - **Complexity**: Long methods, nested conditionals, cognitive load
  - **Duplication**: Copy-paste patterns, similar logic blocks
  - **Naming**: Unclear variables, misleading function names
  - **Architecture**: Tight coupling, circular dependencies
  - **Error Handling**: Missing try-catch, unhandled edge cases
  - **Type Safety**: Any usage, implicit types, missing validations
- Use language-specific patterns (TypeScript vs Go vs React)

### STEP 3: Impact and Effort Analysis

- Prioritize findings by:
  - **High Impact**: Performance bottlenecks, security issues, maintainability blockers
  - **Medium Impact**: Code readability, testing gaps, documentation
  - **Low Impact**: Style consistency, minor optimizations
- Estimate effort levels (Low/Medium/High) for each improvement

### STEP 4: Refactoring Recommendations

- Provide specific, actionable recommendations with:
  - Before/after code examples
  - Rationale for each change
  - Potential risks and mitigation strategies
  - Testing requirements for validation

### STEP 5: Implementation Strategy

- Create step-by-step implementation plan
- Identify dependencies between refactoring tasks
- Suggest rollback strategies
- Recommend testing approaches (unit tests, integration tests)

## Expected Output

### Analysis Report

- **Codebase Overview**: Structure, patterns, and conventions
- **Issues Summary**: Categorized findings with severity levels
- **Metrics**: Complexity scores, duplication percentages, test coverage gaps

### Refactoring Plan

- **Priority Matrix**: High/Medium/Low impact vs effort grid
- **Implementation Order**: Suggested sequence with dependencies
- **Risk Assessment**: Potential breaking changes and mitigations

### Code Examples

- **Before/After Snippets**: Concrete examples of proposed changes
- **Pattern Improvements**: Common patterns and better alternatives
- **Best Practices**: Language-specific recommendations

### Implementation Guide

- **Step-by-Step Instructions**: Detailed implementation approach
- **Testing Strategy**: How to validate each refactoring step
- **Rollback Plan**: How to revert changes if needed

## Usage Examples

### Single File Deep Analysis

```bash
/refactor src/utils/api-client.ts
```

Performs comprehensive analysis of a specific file, identifying complexity issues, type safety problems, and suggesting architectural improvements.

### Directory-Wide Assessment

```bash
/refactor src/components
```

Examines all files in a directory for patterns like component complexity, prop drilling, duplicate logic, and React-specific anti-patterns.

### Codebase Health Check

```bash
/refactor . --scope=overview
```

Provides high-level assessment of entire codebase health, identifying major architectural issues and technical debt patterns.

### Language-Specific Focus

```bash
/refactor src --focus=typescript
```

Concentrates on TypeScript-specific improvements like type annotations, interface usage, and generic constraints.

### Performance-Oriented Analysis

```bash
/refactor src --focus=performance
```

Identifies performance bottlenecks, unnecessary re-renders, inefficient algorithms, and optimization opportunities.

### Testing and Quality Focus

```bash
/refactor tests --focus=quality
```

Analyzes test files for coverage gaps, test quality issues, and suggests improvements to testing strategies.

## Common Refactoring Patterns

### TypeScript/React Projects

- Extract custom hooks from complex components
- Implement proper error boundaries
- Optimize re-rendering with React.memo and useMemo
- Replace prop drilling with context or state management
- Improve type safety with proper generic constraints

### Go Projects

- Extract interfaces for better testability
- Implement proper error handling patterns
- Optimize for concurrent operations
- Replace duplicated logic with generic functions
- Improve package organization and dependencies

### General Patterns

- Extract utility functions from repeated code blocks
- Implement proper logging and monitoring
- Add comprehensive error handling
- Optimize data structures and algorithms
- Improve code documentation and comments

## Notes

- Always run tests after implementing refactoring changes
- Consider backwards compatibility when making API changes
- Use incremental refactoring approach for large codebases
- Document architectural decisions and trade-offs
- Validate performance improvements with benchmarks
