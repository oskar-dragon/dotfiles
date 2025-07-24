---
allowed-tools: Read, Glob, Grep, TodoWrite, Bash
description: "Analyze slash command ecosystem for improvements and generate prioritized recommendations"
argument-hint: "[focus-area] | [priority-level]"
---

# /analyze

Comprehensive analysis tool for the slash command ecosystem that identifies improvement opportunities, detects overengineering patterns, and generates prioritized recommendations for enhancing command quality and consistency.

## Context

- Current directory: !`pwd`
- Commands directory: !`ls -la ~/.claude/commands | head -3`
- Total commands: !`find ~/.claude/commands -name "*.md" -type f | wc -l | tr -d ' '`
- Analysis timestamp: !`date "+%Y-%m-%d %H:%M:%S"`

## Usage

```
/analyze                    # Full ecosystem analysis
/analyze metadata          # Focus on metadata issues
/analyze overengineering   # Focus on pattern issues
/analyze permissions       # Focus on tool permissions
```

## Your Task

**Step 1: Initialize Analysis**

- CREATE analysis report header with timestamp and scope
- INITIALIZE progress tracking with TodoWrite
- SET analysis parameters based on arguments provided
- DETERMINE focus area: full analysis or specific category

**Step 2: Command Discovery**

- USE Glob to discover all command files: `**/*.md` pattern
- FILTER for files with proper YAML front matter (starting with `---`)
- EXTRACT namespace from file path structure
- BUILD command inventory with file paths, namespaces, and basic metadata
- REPORT total commands found and any access issues

**Step 3: YAML Front Matter Analysis**

- READ each command file to extract YAML front matter
- VALIDATE required fields: `allowed-tools`, `description`
- CHECK optional fields: `argument-hint`
- IDENTIFY malformed YAML syntax issues
- CLASSIFY field format problems and missing values

**Step 4: Content Pattern Detection**

- USE Grep to search for overengineering patterns:
  - "parallel sub-agents" or "specialized agents"
  - Performance claims like "10x faster" or "8x speedup"
  - Session files or "/tmp/" patterns
  - Complex coordination systems
- IDENTIFY commands with fictional capabilities
- FLAG commands exceeding length guidelines (>300 lines)

**Step 5: Tool Permission Analysis**

- EXTRACT `allowed-tools` declarations from YAML
- SEARCH command content for actual tool usage patterns
- COMPARE declared permissions with actual usage
- FLAG overly broad permissions or missing declarations
- IDENTIFY security concerns with tool access

**Step 6: Generate Recommendations**

- CATEGORIZE issues by type: metadata, overengineering, permissions
- ASSIGN priority levels: Critical, High, Medium, Low
- CREATE specific improvement suggestions with line references
- ESTIMATE time required for each fix

**Step 7: Format Report**

- OUTPUT comprehensive analysis in markdown format
- INCLUDE executive summary with key statistics
- LIST prioritized recommendations by command
- PROVIDE actionable next steps with time estimates
- REPORT any failed file reads or processing errors

## Expected Output

```markdown
# Slash Command Analysis Report

Generated: 2024-01-15 14:30:22

## Executive Summary

- Commands discovered: 41
- Valid commands analyzed: 38
- Issues found: 23
- Command namespaces: 7

## Priority 1: Critical Issues

### Missing Required Fields

- /ideate - Add: `argument-hint: "[focus-area] | [technology]"`
- /generate-command - Add: `argument-hint: "[namespace] | [command-type]"`

### YAML Syntax Errors

- /legacy-command:3 - Fix malformed YAML (missing quotes)
- /basic-tool:1 - Add required `allowed-tools` field

### Overengineering Patterns

- /ideate:15 - Remove "parallel sub-agents" reference
- /complex-analysis:42 - Replace fictional coordination with Task tool

## Priority 2: Quality Improvements

[Additional recommendations organized by priority]

## Implementation Roadmap

Phase 1 (Quick Wins): 8 commands, 1-2 hours
Phase 2 (Content Quality): 12 commands, 2-3 hours
Phase 3 (Advanced): 3 commands, 1 hour
```

## Examples

### Example 1: Full Analysis

`/analyze`

Performs comprehensive analysis of all commands, identifying metadata issues, overengineering patterns, and permission problems.

### Example 2: Focused Analysis

`/analyze metadata`

Quick scan focusing only on YAML front matter completeness and format issues.

### Example 3: Security Review

`/analyze permissions`

Reviews tool permission declarations and identifies security concerns or overly broad access.

**IMPORTANT**: This analysis identifies issues but does not automatically fix them. Review recommendations before applying changes to ensure command functionality is preserved.
