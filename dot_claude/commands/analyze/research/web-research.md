---
allowed-tools: Task, WebSearch, WebFetch, Write, Bash(fd:*), Bash(rg:*), Bash(git:*)
description: Conduct comprehensive web research on topics with configurable depth
---

# /web-research

Conduct systematic web research using multiple sources and perspectives to gather comprehensive information on a topic.

## Context

Research query: $ARGUMENTS
Current directory: !`pwd`
Project type: !`fd -e json -e toml . | rg "(package\.json|go\.mod)" | head -3 || echo "No project files detected"`

## Usage

```
/web-research [topic or question]
/web-research [topic] --quick     # Basic research (5-10 sources)
/web-research [topic] --deep      # Comprehensive research (10-20 sources)
```

## Your Task

**Step 1: Research Strategy**

Parse the research query and determine scope:
- Identify key terms and concepts
- Determine research depth (auto-detect from query complexity or use flags)
- Plan search angles: best practices, implementation examples, comparisons, pitfalls

**Step 2: Multi-Perspective Search**

Conduct searches from different angles:
- **Authoritative sources**: Official documentation, standards, vendor docs
- **Community insights**: Stack Overflow, forums, GitHub discussions
- **Current practices**: Recent blog posts, tutorials, case studies
- **Comparative analysis**: Technology comparisons, alternatives, trade-offs
- **Implementation guides**: Code examples, step-by-step tutorials

**Step 3: Source Analysis**

For each relevant source found:
- Use WebFetch to analyze content quality and relevance
- Extract key insights and actionable information
- Note publication date and authority level
- Identify practical examples and code snippets

**Step 4: Information Synthesis**

Combine findings from all sources:
- Identify consensus vs. conflicting viewpoints
- Prioritize recent and authoritative information
- Cross-reference claims for validation
- Note gaps or areas needing further research

## Expected Output

Generate a comprehensive research report:

````markdown
# Web Research Report: [Topic]

## Executive Summary

- [Key finding 1]
- [Key finding 2]
- [Key finding 3]
- [Primary recommendation]

## Current Best Practices

### Industry Standards
- [Standard/approach 1]: [Description and adoption]
- [Standard/approach 2]: [Description and adoption]

### Common Patterns
- [Pattern 1]: [Usage and benefits]
- [Pattern 2]: [Usage and benefits]

## Implementation Approaches

### Approach 1: [Name]
**When to use**: [Scenarios]
**Pros**: [Benefits]
**Cons**: [Limitations]
**Example**: [Code snippet or implementation detail]

### Approach 2: [Name]
**When to use**: [Scenarios]
**Pros**: [Benefits]
**Cons**: [Limitations]
**Example**: [Code snippet or implementation detail]

## Comparative Analysis

| Factor | Option A | Option B | Option C |
|--------|----------|----------|----------|
| Performance | [Rating] | [Rating] | [Rating] |
| Complexity | [Rating] | [Rating] | [Rating] |
| Maintenance | [Rating] | [Rating] | [Rating] |
| Community | [Rating] | [Rating] | [Rating] |

## Common Pitfalls & Solutions

- **Pitfall**: [Description] → **Solution**: [Recommendation]
- **Pitfall**: [Description] → **Solution**: [Recommendation]

## Recommendations

### For Your Project Context
- [Specific recommendation based on detected stack]
- [Implementation priority]
- [Risk mitigation strategy]

### Next Steps
1. [Immediate action]
2. [Short-term planning]
3. [Long-term considerations]

## Resources

### Official Documentation
- [Link]: [Description]
- [Link]: [Description]

### Tutorials & Guides
- [Link]: [Description]
- [Link]: [Description]

### Community Resources
- [Link]: [Description]
- [Link]: [Description]

## Research Methodology

**Sources analyzed**: [Number] sources across [categories]
**Research depth**: [Quick/Deep]
**Quality criteria**: Recent (≤2 years), authoritative, practical relevance
**Validation**: Cross-referenced across multiple sources
````

## Examples

### Example 1: Technology Evaluation
`/web-research "React state management solutions 2025"`

Would research Redux, MobX, Zustand, Context API, comparing performance, complexity, and adoption.

### Example 2: Architecture Decision
`/web-research "microservices vs monolith for TypeScript backend --deep"`

Would provide comprehensive analysis of trade-offs, case studies, and implementation guidance.

### Example 3: Implementation Guidance
`/web-research "JWT authentication best practices Go"`

Would focus on security considerations, implementation patterns, and common vulnerabilities.

**IMPORTANT**: Focus on recent, authoritative sources and provide actionable insights with specific implementation guidance when possible.