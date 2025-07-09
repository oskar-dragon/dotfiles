---
allowed-tools: Read, Write, Edit, MultiEdit, Bash(rg:*), Bash(fd:*), Bash(git:*)
description: Simplify code by extracting methods, reducing complexity, and improving readability
---

# /simplify

## Context

- Target: $ARGUMENTS
- Current directory: !`pwd`
- Git status: !`git status --porcelain | wc -l | tr -d ' '` changes pending

## Your Task

Simplify the specified code by reducing complexity and improving readability.

### Step 1: Analyze Target Code

IF $ARGUMENTS specifies a file or directory:

- Read and analyze the specified target
- Identify complexity hotspots using basic metrics

ELSE:

- Analyze current directory for complex code patterns
- Find files with nested conditionals and long functions

### Step 2: Extract Complex Functions

For each complex function found:

- Break down large functions into smaller, focused methods
- Extract helper functions with descriptive names
- Reduce parameter counts where possible
- Use early returns to reduce nesting

### Step 3: Simplify Conditional Logic

- Replace complex boolean expressions with descriptive functions
- Convert nested if-else chains to guard clauses
- Extract magic numbers into named constants
- Use intermediate variables for complex expressions

### Step 4: Improve Naming

- Replace abbreviations with descriptive names
- Use domain-specific terminology consistently
- Make boolean variables interrogative (is, has, can)
- Eliminate generic names (data, info, temp, utils)

### Step 5: Modernize Loops

- Replace imperative loops with functional constructs where appropriate
- Use language-specific higher-order functions (map, filter, reduce)
- Eliminate manual index management
- Convert accumulator patterns to functional equivalents

### Step 6: Validate Changes

- Run existing test suite to verify functionality
- Check that performance hasn't degraded
- Ensure code coverage is maintained
- Perform manual review of all changes

### Step 7: Generate Summary

Create a summary report showing:

- Files modified
- Functions extracted
- Conditionals simplified
- Variables renamed
- Estimated maintainability improvement

## Example Transformation

**Before:** Complex function with mixed concerns

```javascript
function processOrder(order) {
  // 50 lines of validation logic
  // 30 lines of calculation
  // 40 lines of formatting
}
```

**After:** Decomposed with clear responsibilities

```javascript
function processOrder(order) {
  const validatedOrder = validateOrder(order);
  const calculations = calculateTotals(validatedOrder);
  return formatOrderResponse(calculations);
}
```

## Quality Guidelines

- Preserve all existing functionality
- Maintain performance characteristics
- Follow team coding conventions
- Focus on long-term maintainability
- Validate changes thoroughly
