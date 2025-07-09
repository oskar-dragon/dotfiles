---
allowed-tools: Read, Glob, Grep, Bash(fd:*), Bash(rg:*)
description: Discover and propose new Claude command opportunities through systematic analysis
---

## Context

- Target focus area: $ARGUMENTS
- Existing commands: !`fd "\.md$" claude/commands | wc -l | tr -d ' ' || echo "unknown"`
- Command categories: !`fd -t d . claude/commands -d 1 | head -5 || echo "none"`

## Your Task

STEP 1: Analyze existing command structure

- Scan existing commands in `claude/commands/` directory
- Identify patterns and naming conventions
- Find gaps in workflow coverage
- Note popular command types and features

STEP 2: Research developer pain points

- Common manual tasks that could be automated
- Complex workflows needing simplification
- Missing integrations with popular tools
- Frequently requested features

STEP 3: Identify opportunities by focus area

IF focus area provided in $ARGUMENTS:

- Research specific domain (ai-ml, frontend, backend, testing, etc.)
- Identify domain-specific tooling gaps
- Consider workflow automation opportunities

ELSE:

- Analyze cross-cutting concerns
- Focus on general productivity improvements
- Consider universal developer workflows

STEP 4: Generate command proposals

FOR EACH opportunity:

```markdown
### /proposed-command-name

**Purpose**: Brief description of what it does
**Usage**: `/command [args]` - Simple invocation pattern
**Value**: How it improves developer workflow
**Implementation**: [Simple|Moderate|Complex] effort level
```

STEP 5: Prioritize recommendations

**High Priority**:

- Addresses common pain points
- Simple to implement
- Fits existing patterns

**Medium Priority**:

- Useful for specific workflows
- Moderate implementation effort
- Good long-term value

**Low Priority**:

- Niche use cases
- Complex implementation
- Experimental features

## Output Format

```markdown
# Command Ideation Results

## Analysis Summary

- [Brief findings from existing command analysis]
- [Key gaps identified]
- [Focus area insights]

## Proposed Commands

### High Priority

[List of 3-5 high-priority command proposals]

### Medium Priority

[List of 3-5 medium-priority command proposals]

### Low Priority

[List of remaining proposals]

## Implementation Notes

- [Patterns to follow]
- [Technical considerations]
- [Integration opportunities]
```
