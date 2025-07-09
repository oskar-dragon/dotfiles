---
allowed-tools: Read, Write, Edit, MultiEdit, Bash(rg:*), Bash(fd:*), Bash(git:*)
description: Apply consistent coding standards, naming conventions, and architectural patterns
---

# /standardize

## Context

- Target scope: $ARGUMENTS
- Current directory: !`pwd`
- Git status: !`git status --porcelain | wc -l | tr -d ' '` changes pending

## Your Task

Apply consistent coding standards, naming conventions, and architectural patterns across the codebase.

### Step 1: Analyze Current Standards

- Detect primary technology stack from project files
- Identify existing naming patterns and conventions
- Check for configuration files (.eslintrc, .prettierrc, etc.)
- Analyze dominant code style patterns

### Step 2: File and Directory Organization

- Apply standard directory structure based on technology stack
- Move files to appropriate locations following framework conventions
- Update import paths after file relocations
- Ensure all moved files maintain functionality

### Step 3: Naming Convention Standardization

Apply consistent naming based on detected technology:

**TypeScript/JavaScript:**

- Use kebab-case for files and directories
- Use camelCase for variables and functions
- Use PascalCase for classes, types, and React components

**Go:**

- Use snake_case for files
- Use camelCase for variables and functions
- Use PascalCase for exported types and functions

### Step 4: Code Style Standardization

- Organize imports according to framework standards
- Apply consistent formatting using available tools
- Standardize error handling patterns
- Update API response formats consistently

### Step 5: Import Organization

For each code file:

- Categorize imports (built-ins, external, internal, relative)
- Reorder imports according to standard hierarchy
- Remove unused imports
- Group related imports together

### Step 6: Error Handling Standardization

- Apply consistent error handling patterns
- Use standard error types and messages
- Ensure proper error propagation
- Add appropriate logging where needed

### Step 7: Validation and Testing

- Run all available formatters and linters
- Execute tests to ensure functionality is preserved
- Validate import references are correct
- Check that renamed files are properly referenced

### Step 8: Generate Standards Report

Create a report including:

- Files analyzed and modified
- Naming convention changes applied
- Code structure improvements made
- Import organization statistics
- Validation results and any remaining issues

## Technology-Specific Standards

### TypeScript/JavaScript

- Use `const` over `let` where possible
- Prefer arrow functions for callbacks
- Use template literals over string concatenation
- Apply consistent async/await patterns

### Go

- Follow Go naming conventions
- Use proper package organization
- Apply consistent error handling
- Follow Go idioms and best practices

## Quality Assurance

- Preserve all existing functionality
- Maintain performance characteristics
- Follow team coding conventions
- Ensure tests pass after standardization
- Document any breaking changes
