---
allowed-tools: [Task, WebFetch, Read, Grep, Bash]
description: Conduct comprehensive investigation using codebase analysis and web research
---

# /investigate

Conduct systematic investigation of a topic, technology, or approach using codebase analysis and web research to determine optimal solutions.

## Context

Investigation target: $ARGUMENTS
Current directory: !`pwd`
Project structure: !`fd . -t d -d 2 | head -10 || echo "No subdirectories"`
Technology stack: !`fd -e json -e toml . | rg "(go\.mod|package\.json)" | head -5 || echo "No technology files detected"`

## Usage

```
/investigate [topic or question]
```

## Your Task

**STEP 1: Codebase Analysis**

Analyze the current project for relevant implementations:

- MAP directory structure: `fd . -t d -d 3 | head -20`
- SEARCH existing implementations: `rg "$ARGUMENTS" --type-add 'code:*.{go,ts,js}' -t code`
- FIND related configuration: `rg "$ARGUMENTS" --type yaml --type json --type toml`
- LOOK for documentation: `fd "README|ARCHITECTURE|DESIGN" --type f | xargs rg -l "$ARGUMENTS"`
- CHECK test coverage: `fd "test|spec" --type f | xargs rg -l "$ARGUMENTS"`

**STEP 2: Historical Context**

Review project evolution:

- ANALYZE recent changes: `git log --oneline --since="1 month ago" | head -20`
- IDENTIFY frequently modified files: `git log --name-only --since="3 months ago" | sort | uniq -c | sort -nr | head -10`
- FIND technical debt: `rg "(TODO|FIXME|HACK|XXX)" -A 2 -B 1`

**STEP 3: Web Research**

Research current best practices and trends:

- SEARCH for "$ARGUMENTS best practices 2025"
- FIND benchmark comparisons and case studies
- REVIEW GitHub trends and community adoption
- CHECK for recent solutions and common issues

**STEP 4: Solution Evaluation**

Evaluate options using these criteria:

- TECHNICAL fit: performance, scalability, security, maintenance
- PROJECT alignment: stack compatibility, team expertise, migration complexity
- FUTURE-PROOFING: maturity, community support, corporate backing

## Expected Output

Generate a structured investigation report:

````markdown
# Investigation: [Topic]

## Executive Summary

[2-3 sentence overview of findings and recommendation]

## Current State Analysis

### Existing Implementation
- [What's currently in the codebase]
- [Patterns and approaches used]
- [Identified pain points and technical debt]

### Industry Standards (2025)
- [Current best practices]
- [Emerging trends]
- [Common pitfalls to avoid]

## Options Evaluation

### Option 1: [Approach Name]
**Pros:**
- [Advantage 1]
- [Advantage 2]

**Cons:**
- [Disadvantage 1]
- [Disadvantage 2]

**Real-world Usage:**
- [Company/Project using this]
- [Performance metrics if available]

### Option 2: [Alternative Approach]
[Similar structure]

## Recommendation

### Optimal Solution: [Chosen Approach]

**Rationale:**
1. [Key reason 1]
2. [Key reason 2]
3. [Key reason 3]

**Implementation Strategy:**
```[language]
// Code example showing recommended approach
```

**Migration Path:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Next Steps

1. [ ] [Immediate action item]
2. [ ] [Short-term task]
3. [ ] [Long-term consideration]

## Resources

- [Official Documentation](link)
- [Tutorial/Guide](link)
- [Community Forum](link)
- [Example Repository](link)
````

## Examples

### Example 1: Go HTTP Framework
`/investigate What's the best HTTP framework for our Go microservices?`

Investigation would:
- Analyze current HTTP handling in Go codebase
- Research Go HTTP frameworks (Gin, Echo, Fiber, Chi)
- Compare performance, middleware support, and ecosystem
- Recommend based on project needs and existing architecture

### Example 2: TypeScript Build System
`/investigate Should we migrate from Webpack to Vite for our TypeScript project?`

Investigation would:
- Review current Webpack configuration and build performance
- Research Vite adoption and TypeScript support
- Analyze migration complexity and breaking changes
- Provide performance comparison and actionable recommendation

**IMPORTANT**: Return investigation results directly to the user - DO NOT write results to a file unless explicitly requested