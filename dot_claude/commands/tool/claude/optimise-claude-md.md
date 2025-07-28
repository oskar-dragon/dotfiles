---
allowed-tools: Read, Write, MultiEdit, Bash(wc:*), Bash(fd:*), Grep
description: Optimizes CLAUDE.md files for token efficiency and Claude 4 effectiveness while preserving all project-specific context
argument-hint: "[path-to-claude-md]"
---

## Context

- Current directory: !`pwd`
- Target file: $ARGUMENTS
- Current tokens: !`wc -w "$ARGUMENTS" | cut -d' ' -f1`

## Your Task

**STEP 1: Analyze Current File**

- READ the target CLAUDE.md file
- COUNT tokens using `wc -w` (estimate: words × 1.3)
- IDENTIFY improvement areas:
  - Verbose language patterns
  - Redundant instructions
  - Token-heavy sections
  - Missing structure

**STEP 2: Apply Token Optimizations**

**Transform Verbose Language:**

- "Please ensure" → "MUST:"
- "It's important to" → (remove)
- "appropriately/properly" → specific actions
- Explanatory text → direct commands

**Consolidate Without Losing Context:**

- Merge duplicate instructions only
- Convert prose to bullets (preserve details)
- Use tables for lists (keep all items)
- PRESERVE all project-specific:
  - File paths and commands
  - Tool names and descriptions
  - API integration details
  - Architecture information

**STEP 3: Restructure for Clarity**

**Priority-Based Layout:**

1. Core directives (security, breaking changes)
2. Workflow requirements
3. Validation commands
4. Context/references

**Add Visual Hierarchy:**

- Section headers with emoji
- Consistent indentation
- Code blocks for commands
- Strategic emphasis levels

**STEP 4: Modularize if Needed**

IF file exceeds 5,000 tokens:

- Split excessive detail into `docs/` directory
- Use `@path/to/file` references
- Keep actionable instructions inline
- NEVER modularize critical workflows

**STEP 5: Validate Optimization**

- VERIFY token count under 5K (target: 2.5-3.5K)
- CHECK all project context preserved
- ENSURE critical instructions in first 20%
- TEST all referenced commands work

## Output Format

**Optimization Report:**

```
# CLAUDE.md Optimization Results

**Metrics:**
- Before: X tokens | After: Y tokens (Z% reduction)
- Critical instructions placement: ✅/❌
- Context preservation: ✅/❌

**Key Changes:**
1. Removed verbose language → Saved X tokens
2. Consolidated duplicates → Saved Y tokens
3. Improved structure → Enhanced clarity

**Validation:**
- [ ] Under 5K tokens
- [ ] All paths/commands verified
- [ ] Project context intact
```

**Optimized File:**

- Complete optimized CLAUDE.md
- All project details preserved
- Token-efficient language
- Clear visual hierarchy

## Critical Constraints

🔴 **MANDATORY**: Keep under 5,000 tokens
🔴 **PRESERVE**: All project-specific context
🟡 **OPTIMIZE**: Language precision, not content removal
🟢 **ENHANCE**: Structure and visual hierarchy

## Examples

`/optimise-claude-md "CLAUDE.md"`
`/optimise-claude-md "docs/project-instructions.md"`

## Validation Checklist

- [ ] Token count reduced while preserving context
- [ ] No vague language ("appropriately", "properly")
- [ ] Critical instructions prioritized
- [ ] All tool names/paths intact
- [ ] Build commands unchanged
- [ ] Architecture details retained
