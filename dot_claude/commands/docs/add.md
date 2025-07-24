---
allowed-tools: Read, Glob, Grep, Task, Write, Bash(fd:*), Bash(rg:*)
description: Generate focused documentation for a specific component with file links and external references
argument-hint: "[component-name|guide title|troubleshooting topic]"
---

## Context

- Current directory: !`pwd`
- Target: $ARGUMENTS
- Project structure: !`fd --type d --max-depth 2 . | head -10`
- Technology stack: !`fd "(package\.json|Cargo\.toml|go\.mod|requirements\.txt)" . -d 2 | head -3`
- Existing docs: !`fd "docs" . -t d -d 2 | head -3 || echo "No docs directory"`

## Your Task

**STEP 1: Determine Documentation Type**

- ANALYZE $ARGUMENTS to detect documentation type:
  - IF $ARGUMENTS contains "guide": SET type = "guide"
  - ELSE IF $ARGUMENTS contains "troubleshooting": SET type = "troubleshooting"
  - ELSE: SET type = "component" (default)

**STEP 2: Analyze Target Structure**

FOR ALL types:

- DETERMINE appropriate docs/ subdirectory placement
- IDENTIFY technology-specific examples from detected stack

**STEP 3: Generate Documentation**

CREATE documentation following the appropriate structure:

**FOR TYPE = "guide":**

```markdown
# [Guide Title]

## Overview

[1-2 paragraph overview of what this guide covers]

## Prerequisites

**Required Knowledge**:

- [Knowledge areas needed]
  **Dependencies**:
- [Required tools/software with links to installation]
  **Files Referenced**: [Links to relevant project files]

## Step-by-Step Instructions

### Step 1: [Action Name]

[Detailed instructions with file references]
**Files**: See [`file.ext`](../path/to/file.ext)

### Step 2: [Next Action]

[Continue with numbered steps...]

## Troubleshooting

**Issue**: [Common problem]
**Solution**: [How to resolve with file references]

## Next Steps

- [Related guides with links]
- [Advanced topics with file references]
```

**FOR TYPE = "troubleshooting":**

```markdown
# [Topic] Troubleshooting

## Common Issues

### Issue: [Problem Description]

**Symptoms**: [What users experience]
**Cause**: [Root cause explanation]
**Solution**: [Step-by-step fix with file references]
**Prevention**: [How to avoid recurrence]
**Related Files**: See [`config.js`](../path/to/config.js)

### Issue: [Another Problem]

[Follow same format...]

## Diagnostic Tools

**Commands**: [Investigation commands to run]
**Log Files**: See [`logs/error.log`](../logs/error.log)
**Configuration**: See [`config/settings.json`](../config/settings.json)

## Getting Help

- [Internal escalation procedures]
- [Related documentation links]
```

**FOR DEFAULT**

```markdown
# [Component Name]

## Overview

[1-2 paragraph overview with technology stack]

## Architecture

[High-level architecture explanation]

## Implementation

**Location**: [Link to implementation files]
**Key Files**: [List with relative links]

## Usage Examples

[Practical examples referencing actual files]

## Configuration

**Environment**: [Link to config files]
**Setup**: [Required setup with file references]

## Testing

**Test Files**: [Links to test implementations]
**Approach**: [Testing strategy description]

## Related Documentation

[Links to related internal docs]
[Links to relevant technologies or their documentation]
```

**STEP 4: Apply Documentation Standards**

- LINK to files instead of copying code blocks
- USE relative paths from documentation location
- REFERENCE external technology documentation with official links
- FOLLOW file reference pattern: `See [filename](../path/to/file)`

**STEP 5: Create and Validate Documentation**

- CREATE documentation file in appropriate docs/ subdirectory
- VERIFY all file links point to existing files
- ENSURE examples match current implementation
- WRITE documentation file to project

## Expected Output

A focused documentation file in `docs/` directory containing:

- Component overview with architecture
- File-linked implementation details
- Configuration with file references
- Usage examples with actual file links
- Testing approach with test file links
- Related documentation cross-references

## Examples

**Component Documentation:**
`/add "user-authentication"`
`/add "payment-processing"`
`/add "src/components/dashboard"`

**Guide Documentation:**
`/add "guide Getting Started"`
`/add "guide Deployment Setup"`
`/add "guide API Integration"`

**Troubleshooting Documentation:**
`/add "troubleshooting Authentication Issues"`
`/add "troubleshooting Database Connection"`
`/add "troubleshooting Performance Problems"`

## Important Notes

- **No Code Copying**: Always link to files instead of copying code blocks
- **Official Links**: Use official documentation for external technologies
- **Relative Paths**: Use relative paths from documentation location
- **File Validation**: Ensure all referenced files exist
- **Focused Scope**: Keep documentation concise and actionable
