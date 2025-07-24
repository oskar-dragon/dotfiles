---
allowed-tools: Read, Write, Glob, Grep, Bash(pwd), Bash(fd:*), Bash(head:*), Bash(wc:*), Bash(rg:*)
description: Generate targeted test suites using Vitest, Playwright, MSW, and Faker
argument-hint: "[target] [type:unit|e2e]"
---

# /generate

Generate unit or E2E tests for specific functions, components, or flows using modern testing frameworks.

## Context

- Target: $ARGUMENTS
- Current directory: !`pwd`
- Project structure: !`fd . -t d -d 2 | head -8`
- Existing tests: !`fd "(test|spec)" . -t f | wc -l | tr -d ' '` files
- Testing frameworks: !`fd "package.json" . | head -1 | xargs rg -o "(vitest|playwright|msw|faker)" 2>/dev/null || echo "none"`

## Usage

```
/generate [target] [type]
/generate utils/formatDate unit        # Generate unit tests for formatDate function
/generate components/LoginForm unit    # Generate component tests
/generate auth/login-flow e2e          # Generate E2E tests for login flow
```

**Arguments:**

- `target`: Function name, file path, or page/flow identifier
- `type`: `unit` for component/function tests, `e2e` for end-to-end tests

## Your Task

**STEP 1: Parse Arguments and Analyze Project**

IF no arguments provided:
- PROMPT user for target and test type
- EXIT with usage guidance

- EXTRACT target identifier and test type from arguments
- USE Glob to find package.json: `**/package.json`
- READ package.json to detect testing frameworks (vitest, playwright, msw, faker)
- USE Grep to find existing test files: `(test|spec)` pattern
- IDENTIFY project language from file extensions

**STEP 2: Locate and Analyze Target Code**

FOR unit tests:
- USE Glob to find target file: `**/*${target}*`
- READ target file to understand structure
- IDENTIFY imports, exports, and dependencies
- DETERMINE mocking requirements

FOR e2e tests:
- IDENTIFY user flows from target description
- LOCATE related components and API endpoints
- FIND existing page files if applicable

**STEP 3: Generate Test File**

- MATCH existing test naming conventions (`.test.ts` or `.spec.ts`)
- PLACE test file following project structure
- GENERATE appropriate test framework boilerplate
- CREATE test scenarios for main functionality and edge cases
- ADD mocks for external dependencies when needed

**STEP 4: Write and Validate Test**

- WRITE complete test file to appropriate location
- VERIFY imports and test structure are correct
- ADD descriptive test names and assertions
- INCLUDE setup/teardown as needed

**STEP 5: Provide Usage Instructions**

- OUTPUT commands to run the generated tests
- LIST any missing dependencies that need installation
- SUGGEST additional test scenarios for better coverage

## Expected Output

- Complete test file written to appropriate location
- Commands to run the generated tests
- Notes about missing dependencies that need installation

## Examples

```
/generate utils/formatDate unit        # Generate unit tests for formatDate function
/generate components/LoginForm unit    # Generate component tests
/generate auth/login-flow e2e          # Generate E2E tests for login flow
```

**IMPORTANT**: Review generated tests for completeness and adjust assertions based on actual requirements.
