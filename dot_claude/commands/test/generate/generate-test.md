---
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(fd:*), Bash(rg:*)
description: Generate targeted test suites using Vitest, Playwright, MSW, and Faker
---

# /generate-test

Generate unit or E2E tests for specific functions, components, or flows using modern testing frameworks.

## Context

- Target: $ARGUMENTS
- Project structure: !`fd . -t d -d 2 | head -8`
- Existing tests: !`fd "(test|spec)" . -t f | wc -l | tr -d ' '` files
- Testing frameworks: !`fd "package.json" . | head -1 | xargs rg -o "(vitest|playwright|msw|faker)" 2>/dev/null || echo "none"`

## Usage

```
/generate-test [target_identifier] [type: unit|e2e]
```

- `target_identifier`: Function name, file path, or page/flow name
- `type`: `unit` for Vitest tests or `e2e` for Playwright tests

## Your Task

STEP 1: Parse arguments and detect project setup

- Extract target identifier and test type from $ARGUMENTS
- Detect available testing frameworks (Vitest, Playwright, MSW, Faker)
- Identify project language (TypeScript/JavaScript)
- Find existing test patterns and conventions

STEP 2: Analyze target for testing

IF test type is `unit`:
- Locate the target function/component file
- Analyze inputs, outputs, and dependencies
- Identify edge cases and error conditions
- Find dependencies that need mocking

IF test type is `e2e`:
- Identify user interactions and flows
- Map API calls that need mocking
- Determine test data requirements
- Plan test scenarios (happy path, error cases)

STEP 3: Generate test file

FOR unit tests:
- Create Vitest test file with proper imports
- Generate test cases for main functionality
- Add edge case and error handling tests
- Include appropriate mocks for dependencies

FOR e2e tests:
- Create Playwright test file with proper setup
- Generate test scenarios for user flows
- Add MSW handlers for API mocking
- Include realistic test data using Faker

STEP 4: Follow project conventions

- Match existing test file structure and naming
- Use project's import patterns and styles
- Follow existing assertion and mocking patterns
- Ensure test placement follows project organization

STEP 5: Provide test file and instructions

- Create the test file in appropriate location
- Provide instructions for running the tests
- Suggest any additional setup required
- Include examples of extending the tests

## Test Templates

### Vitest Unit Test
```typescript
import { describe, it, expect, vi } from 'vitest'
import { targetFunction } from './target'

describe('targetFunction', () => {
  it('should handle valid input', () => {
    // Test implementation
  })
  
  it('should handle edge cases', () => {
    // Edge case tests
  })
})
```

### Playwright E2E Test
```typescript
import { test, expect } from '@playwright/test'

test.describe('User Flow', () => {
  test('should complete main flow', async ({ page }) => {
    // Test implementation
  })
})
```
