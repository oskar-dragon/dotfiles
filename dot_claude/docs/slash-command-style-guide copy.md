# Slash Command Style Guide

This document defines the canonical standards for creating and improving slash commands. Reference this guide instead of duplicating style rules across individual commands.

## Table of Contents

1. [Tool Security Guidelines](#tool-security-guidelines)
2. [YAML Front Matter Standards](#yaml-front-matter-standards)
3. [Command Structure Best Practices](#command-structure-best-practices)
4. [Dynamic Context Management](#dynamic-context-management)
5. [Command Templates and Patterns](#command-templates-and-patterns)
6. [Comprehensive Control Flow Example](#comprehensive-control-flow-example)
7. [Validation Guidelines](#validation-guidelines)
8. [Tool Usage Optimization](#tool-usage-optimization)

## Tool Security Guidelines

Follow the **principle of least privilege** - only include tools actually used in the command.

### FORBIDDEN Legacy Commands

**Never allow these legacy bash commands:**

- `grep` → use `rg` (ripgrep)
- `find` → use `fd`
- `cat` → use `bat` or Read tool
- `ls` → use `eza` or LS tool
- `df`, `top`, `xxd` → use modern alternatives

### ALLOWED Modern Bash Tools

- **Search/Files**: `rg`, `fd`, `bat`, `eza`
- **Data**: `jq`, `yq`, `fzf`, `delta`
- **Development**: `gh`

### ALLOWED Claude Tools

- **Core**: `Read`, `Write`, `Edit`, `MultiEdit`, `Task`, `Glob`, `Grep`
- **Constrained Bash**: `Bash(specific:*)` patterns only

### Granular Bash Permissions

Use specific command patterns instead of broad permissions:

```yaml
# Good - Specific patterns
allowed-tools: Bash(git:*), Bash(fd:*), Bash(rg:*)

# Bad - Too permissive
allowed-tools: Bash
```

**Common Permission Patterns:**

| **Category**        | **Patterns**                                                  |
| ------------------- | ------------------------------------------------------------- |
| **Git**             | `Bash(git:*)`                                                 |
| **File operations** | `Bash(fd:*)`, `Bash(head:*)`, `Bash(wc:*)`                    |
| **Development**     | `Bash(npm:*)`, `Bash(bun:*)`, `Bash(pnpm:*)`, `Bash(turbo:*)` |
| **Network**         | `Bash(curl:*)`, `Bash(wget:*)`                                |
| **System info**     | `Bash(uname)`, `Bash(whoami)`, `Bash(which:*)`                |

## YAML Front Matter Standards

Every command must include:

```yaml
---
allowed-tools: [minimal set following principle of least privilege]
description: [concise, action-oriented description]
argument-hint: "[guidance for user input]"
---
```

### Description Guidelines

- Action-oriented (starts with verb)
- Concise (under 80 characters)
- Specific about what the command does
- No vague terms like "improve" or "optimize"

### Argument Hints

- Use square brackets: `"[command-file-path]"`
- Be specific about expected input format
- Include examples when helpful: `"[package-name] or [package@version]"`

## Command Structure Best Practices

### Length Requirements

- **Target**: 50-300 lines (excluding YAML front matter)
- Commands shorter than 50 lines may lack necessary structure
- Commands longer than 300 lines should be split or simplified

### Programmatic Structure

Use clear, step-based execution flow:

```markdown
## Your Task

**STEP 1: Analysis**

- READ target files
- IDENTIFY requirements
- DETERMINE approach

**STEP 2: Implementation**

- EXECUTE planned changes
- VERIFY results
- HANDLE errors

**STEP 3: Validation**

- TEST all changes
- CONFIRM functionality
- REPORT results
```

## Dynamic Context Management

### Preservation Rules

**NEVER modify existing dynamic context:**

- PRESERVE all existing `!command` syntax exactly
- NEVER replace `!pwd`, `!git status`, `!fd` with static values
- NEVER convert dynamic commands to hardcoded outputs

### Common Dynamic Commands Reference

**Standard Context Patterns:**

| Purpose                | Command Pattern                                                                                                                      |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **File System**        |                                                                                                                                      |
| Current directory      | `!\`pwd\``                                                                                                                           |
| File count             | `!\`fd --type f \| wc -l 2>/dev/null \|\| echo "0"\``                                                                                |
| JS files               | `!\`fd '\*.js' . \| head -5 2>/dev/null \|\| echo "No JS files"\``                                                                   |
| Line count             | `!\`wc -l file 2>/dev/null \|\| echo "0"\``                                                                                          |
| **Git Operations**     |                                                                                                                                      |
| Repository status      | `!\`git status --porcelain 2>/dev/null \|\| echo "not a git repo"\``                                                                 |
| Current branch         | `!\`git branch --show-current 2>/dev/null \|\| echo "unknown"\``                                                                     |
| Remote URL             | `!\`git remote -v \| head -1 \| awk '{print $2}' 2>/dev/null \|\| echo "none"\``                                                     |
| Recent commits         | `!\`git log --oneline -3 2>/dev/null \|\| echo "no commits"\``                                                                       |
| **Package Management** |                                                                                                                                      |
| Package manager        | `!\`[ -f package.json ] && echo "npm-based" \|\| echo "unknown"\``                                                                   |
| Dependencies count     | `!\`jq -r '.dependencies \| keys \| length' package.json 2>/dev/null \|\| echo "0"\``                                                |
| Available scripts      | `!\`jq -r '.scripts \| keys[]' package.json 2>/dev/null \| head -3 \|\| echo "none"\``                                               |
| Test framework         | `!\`jq -r '.devDependencies \| keys[]' package.json 2>/dev/null \| grep -E "(jest\|vitest\|mocha)" \| head -1 \|\| echo "unknown"\`` |

**Error Handling Pattern:**
All commands use: `command 2>/dev/null || echo "fallback-value"`

## Validation Guidelines

### Comprehensive Command Validation Checklist

Use this complete checklist when improving or creating commands:

**Structure & Security:**

- [ ] Command has argument hints
- [ ] Command is 50-300 lines (excluding YAML front matter)
- [ ] Has precise tools specified using principle of least privilege
- [ ] Follows Tool Security Guidelines
- [ ] Clear, actionable steps with explicit expectations

**Content Quality:**

- [ ] No fictional performance claims
- [ ] Practical examples included
- [ ] Focused on actual capabilities
- [ ] Includes robust, general-purpose solution guidance
- [ ] Avoids hard-coding and test-specific solutions
- [ ] Emphasizes maintainable, extendable implementations

**Technical Implementation:**

- [ ] Includes thinking prompts for complex operations
- [ ] Optimizes for parallel tool execution where applicable
- [ ] All bash commands tested individually for output
- [ ] Command executes without errors
- [ ] Output is meaningful and expected
- [ ] Shell quoting issues resolved (no unescaped !, proper quotes)
- [ ] Patterns use proper quotes: `'pattern'` or `"path with spaces"`
- [ ] Error handling works (`2>/dev/null || echo "fallback"`)
- [ ] Fallback values provided for all dynamic commands

**Control Flow & Error Handling:**

- [ ] TRY/CATCH/FINALLY blocks added for error-prone operations
- [ ] FINALLY blocks include proper cleanup and state management
- [ ] CATCH blocks handle specific error types with targeted recovery
- [ ] WHEN/CASE patterns used for complex conditional logic
- [ ] CASE statements cover all expected input variations
- [ ] FOR EACH patterns include per-item error handling
- [ ] Nested control flow patterns are properly structured
- [ ] Resource acquisition and cleanup are properly managed
- [ ] Error recovery strategies provide graceful degradation
- [ ] State preservation and restoration mechanisms included
- [ ] Complex workflows broken into manageable, validated steps

## Command Templates and Patterns

### Basic Command Template

```markdown
---
allowed-tools: Read, Task, Bash(specific:*)
description: Brief, clear action description
argument-hint: "[required-argument]"
---

## Context

- Current directory: !`pwd`
- Target: $ARGUMENTS

## Your Task

**STEP 1: Analyze**

- READ and analyze the target
- IDENTIFY key requirements

**STEP 2: Execute**

- IMPLEMENT solution using approved tools only
- FOLLOW all security guidelines

**STEP 3: Report**

- SUMMARIZE changes made
- PROVIDE actionable next steps

## Examples

`/command-name "example-input"`
```

### Specialized Command Templates

Use context patterns from the [Common Dynamic Commands Reference](#common-dynamic-commands-reference) above.

## Comprehensive Control Flow Example

This example demonstrates all control flow patterns working together in a realistic slash command scenario:

```markdown
---
allowed-tools: Read, Write, Edit, Glob, Grep, Task, Bash(git:*), Bash(fd:*), Bash(npm:*)
description: Analyze and refactor codebase with comprehensive error handling and validation
argument-hint: "[target-directory] [refactor-type]"
---

## Context

- Current directory: !`pwd`
- Target directory: $ARGUMENTS
- Git status: !`git status --porcelain 2>/dev/null || echo "not a git repo"`
- File count: !`fd --type f . | wc -l 2>/dev/null || echo "0"`

## Your Task

Think carefully about the optimal refactoring approach before proceeding.

**STEP 1: Analysis and Validation**

CASE refactor_type:

WHEN "component-restructure":
TRY:

- ANALYZE component dependencies and relationships
- IDENTIFY circular dependencies and coupling issues
- VALIDATE component interface contracts
  CATCH (dependency_analysis_error):
- LOG dependency analysis failure details
- IMPLEMENT fallback manual analysis approach
- PROVIDE simplified dependency mapping
  FINALLY:
- CLEANUP temporary analysis files
- UPDATE analysis status tracking

  WHEN "api-consolidation":
  TRY:

- SCAN for API endpoint definitions across codebase
- IDENTIFY duplicate and redundant endpoints
- VALIDATE API contract compatibility
  CATCH (api_scanning_error):
- HANDLE incomplete API discovery gracefully
- DOCUMENT API analysis limitations
- SUGGEST manual API audit steps
  FINALLY:
- CLEANUP API analysis cache
- RESET scanning environment

  WHEN "performance-optimization":
  FOR EACH performance_metric in ["bundle-size", "render-time", "memory-usage"]:
  TRY:

- MEASURE baseline performance for metric
- IDENTIFY optimization opportunities
- VALIDATE measurement accuracy
  CATCH (measurement_error):
- LOG measurement failure for specific metric
- CONTINUE with remaining metrics
- PROVIDE alternative measurement approaches
  FINALLY:
- ARCHIVE measurement data
- UPDATE performance tracking logs

**STEP 2: Implementation Planning**

IF codebase_complexity == "high":
TRY:

- BREAK refactoring into atomic, reversible steps
- CREATE checkpoint system for incremental progress
- VALIDATE each step before proceeding to next
  CATCH (planning_complexity_error):
- SIMPLIFY refactoring scope to manageable chunks
- IMPLEMENT progressive enhancement approach
- DOCUMENT deferred optimization opportunities
  FINALLY:
- SAVE refactoring plan to project documentation
- NOTIFY user of plan complexity and timeline

ELSE IF codebase_complexity == "medium":

- IMPLEMENT standard refactoring workflow
- APPLY established patterns and conventions
- VALIDATE changes using existing test suite

ELSE:

- EXECUTE direct refactoring approach
- MINIMIZE validation overhead for simple changes
- PROVIDE immediate feedback on modifications

**STEP 3: Execution with Error Recovery**

FOR EACH file in target_files:

CASE file.type:

    WHEN "critical_system_file":
      TRY:

- CREATE backup of original file
- APPLY refactoring changes incrementally
- VALIDATE system stability after each change
  CATCH (critical_file_error):
- RESTORE from backup immediately
- ABORT remaining changes to critical files
- ESCALATE to user for manual intervention
  FINALLY:
- VERIFY system remains functional
- LOG critical file modification results

  WHEN "standard_application_file":
  TRY:

- APPLY standard refactoring transformations
- VALIDATE syntax and semantic correctness
- UPDATE related import/export statements
  CATCH (transformation_error):
- REVERT file to previous state
- LOG transformation failure details
- CONTINUE with remaining files
  CATCH (validation_error):
- IMPLEMENT partial transformation
- DOCUMENT validation limitations
- QUEUE file for manual review
  FINALLY:
- UPDATE file modification tracking
- CLEANUP temporary transformation artifacts

  WHEN "test_file":
  TRY:

- UPDATE test assertions to match refactored code
- VALIDATE test coverage is maintained
- EXECUTE affected tests to verify functionality
  CATCH (test_update_error):
- PRESERVE original test structure
- DOCUMENT test modification requirements
- SUGGEST manual test updates
  FINALLY:
- UPDATE test execution results
- CLEANUP test environment

**STEP 4: Validation and Cleanup**

TRY:

- EXECUTE comprehensive test suite
- VALIDATE all refactoring objectives are met
- MEASURE performance impact of changes
- GENERATE refactoring summary report
  CATCH (validation_failure):
- IDENTIFY specific validation issues
- PROVIDE rollback instructions
- DOCUMENT partial completion status
  CATCH (performance_regression):
- ANALYZE performance impact details
- SUGGEST performance optimization strategies
- PROVIDE performance comparison data
  FINALLY:
- CLEANUP all temporary files and caches
- RESET development environment to clean state
- UPDATE project documentation with changes
- ARCHIVE refactoring logs and artifacts

## Examples

`/comprehensive-refactor "src/components" "component-restructure"`
`/comprehensive-refactor "api" "api-consolidation"`
`/comprehensive-refactor "." "performance-optimization"`
```

## Thinking Integration Guidelines

### When to Use Extended Thinking

Add thinking prompts for commands involving:

- Multi-phase workflows with dependencies
- Architecture decisions and strategy planning
- Security analysis and vulnerability assessment
- Performance optimization and token usage
- Complex code analysis and improvement decisions

### Thinking Prompt Patterns

```markdown
Think carefully about the optimal approach before proceeding.

After receiving tool results, carefully reflect on their quality and determine optimal next steps.

Consider multiple approaches and select the most effective one based on the specific requirements and constraints.

Analyze the results and plan your next actions based on what you've learned.
```

### Integration Example

```markdown
## Your Task

Think deeply about the codebase structure and patterns before proceeding.

**STEP 1: Analysis**

- USE extended thinking to understand architecture
- ANALYZE dependencies and relationships
- REFLECT on optimal implementation strategy

**STEP 2: Implementation**

- APPLY the chosen approach systematically
- MONITOR results and adjust as needed
```

### Error Handling and Control Flow

**Structured Error Handling:**

```markdown
TRY:

- EXECUTE potentially failing operation
- VERIFY expected output
  CATCH (specific_error_type):
- APPLY targeted recovery strategy
- LOG detailed error context
  CATCH (general_error):
- PROVIDE fallback approach
- ENSURE graceful degradation
  FINALLY:
- CLEANUP temporary resources
- UPDATE operation status
- RESET environment state
```

**Control Flow Patterns:**

```markdown
# Conditional Logic

IF condition:

- ACTION when true
- VERIFY outcome
  ELSE:
- ALTERNATIVE action
- FALLBACK approach

# Multiple Conditions

CASE input_type:
WHEN "simple":

- USE direct approach
  WHEN "complex":
- BREAK into steps
- VALIDATE each step

# Iteration

FOR EACH item in list:
TRY:

- PROCESS item
- VALIDATE result
  CATCH:
- HANDLE error gracefully
- CONTINUE with remaining items
  FINALLY:
- CLEANUP item resources
```

**Bash Fallback Strategies:**

```bash
# Single fallback
primary-command 2>/dev/null || echo "default-value"

# Multiple fallbacks
cmd1 2>/dev/null || cmd2 2>/dev/null || echo "none"

# Conditional execution
[ condition ] && success-action || fallback-action
```

## Tool Usage Optimization

### Parallel Execution Guidance

Include explicit instructions for efficient tool usage:

```markdown
For maximum efficiency, whenever you need to perform multiple independent operations, invoke all relevant tools simultaneously rather than sequentially.

When multiple file reads or searches are needed, perform them in parallel using multiple tool calls in a single message.

Execute git status, git diff, and git log commands simultaneously to gather comprehensive repository information.
```

**Example Parallel Operations:**

- READ multiple files simultaneously
- SEARCH for multiple patterns in parallel
- EXECUTE git status, git diff, and git log concurrently
