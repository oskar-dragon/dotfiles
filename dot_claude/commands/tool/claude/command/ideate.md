---
allowed-tools: Task, Read, Bash(fd:*), Bash(rg:*), Bash(wc:*), Bash(jq:*), Bash(gdate:*), Bash(eza:*)
description: Discover and propose new Claude command opportunities through systematic analysis and parallel research.
argument-hint: "[focus-area] | [technology-stack]"
---

Discover and propose new Claude command opportunities through systematic analysis and parallel research, tailored to project context and technology trends.

## Context

- Current directory: !`pwd`
- Target project context: $ARGUMENTS
- Project structure: !`fd . -t d -d 2 | head -10 || echo "No subdirectories found"`
- Technology indicators: !`fd "(package\.json|go\.mod)" . -d 3 | head -5 || echo "No build files detected"`
- Existing Claude commands: !`fd "\.md$" .claude/commands 2>/dev/null | wc -l | tr -d ' ' || echo "0"` custom commands

## Your Task

STEP 1: Initialize Command Ideation Session

- ANALYZE project context and DETERMINE project complexity and technology stack.
- IDENTIFY automation opportunities and workflow pain points.

STEP 2: Comprehensive Ecosystem Analysis

- ANALYZE existing command structure and identify gaps
- RESEARCH common developer workflow pain points and manual tasks
- TRACK emerging technology adoption and integration opportunities
- EXAMINE successful command patterns in the ecosystem
- INVESTIGATE industry standards and developer tooling best practices
- PERFORM focused analysis based on `$ARGUMENTS` (e.g., AI/ML, frontend, cloud, security)

STEP 3: Synthesize Findings and Identify High-Impact Opportunities

- AGGREGATE findings from analysis activities
- IDENTIFY overlapping pain points (high-impact opportunities)
- CLASSIFY opportunities by impact level and implementation complexity (Tier 1: Immediate, Tier 2: Strategic, Tier 3: Future)
- CROSS-REFERENCE with existing command ecosystem to avoid duplication

STEP 4: Generate Command Proposals with Contextual Intelligence

- FOR EACH identified opportunity, DESIGN a command following established patterns:
  - **Name**: Action-based, hyphenated, namespace-aware.
  - **Usage**: `/command [optional-context]` format.
  - **Auto-detection**: Project structure awareness.
  - **Smart defaults**: Work without arguments, progressive enhancement.
  - **Graceful fallback**: Interactive guidance when context unclear.
- CREATE comprehensive proposal including `Gap Description`, `Value Proposition`, `Context Awareness`, `Implementation Complexity`, and `Tier Classification`.

STEP 5: Prioritization and Impact Analysis

- CALCULATE time savings potential, evaluate error reduction, assess team standardization benefits, and estimate implementation effort.
- PRIORITIZE commands into High, Medium, and Low priority categories.

STEP 6: Format Comprehensive Recommendations with Implementation Guidance

- CREATE structured output with an `Executive Summary`, `Tiered Command Proposals`, and an `Implementation Roadmap`.
- INCLUDE `Research Areas Summary` based on analysis (e.g., AI/ML Integration, Cloud-Native Operations).

STEP 7: Finalization and Cleanup

- PROVIDE actionable command proposals ready for implementation.
- CLEAN UP temporary analysis files.
