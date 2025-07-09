---
allowed-tools: [Write, Read, Bash]
description: Engage in deep, structured reasoning using systematic thinking approaches
---

# /think

Engage in deep, structured reasoning using systematic thinking approaches for complex problems.

## Context

- Session ID: !`gdate +%s%N || date +%s%N`
- Working directory: !`pwd`
- Current time: !`gdate '+%Y-%m-%d %H:%M:%S' || date '+%Y-%m-%d %H:%M:%S'`
- Topic: $ARGUMENTS

## Usage

```
/think [topic or question]
```

## Your Task

**STEP 1: Problem Assessment**

Evaluate the complexity and scope of the topic:

- IDENTIFY the core question or challenge
- DETERMINE if it's straightforward or complex
- ASSESS what type of thinking approach would be most effective
- CONSIDER multiple perspectives and stakeholder viewpoints

**STEP 2: Structured Analysis**

Apply systematic thinking approaches:

IF topic is straightforward:
- USE focused analytical approach
- APPLY first principles reasoning
- CONSIDER 3-5 key dimensions
- GENERATE clear conclusions

ELSE IF topic involves complex systems or decisions:
- USE comprehensive analytical framework
- EXAMINE interconnections and dependencies
- CONSIDER temporal aspects (past trends, future implications)
- ANALYZE trade-offs and constraints
- EXPLORE alternative scenarios

**STEP 3: Multi-Perspective Analysis**

FOR EACH major dimension of the problem:
- ANALYZE from different stakeholder viewpoints
- CONSIDER potential risks and failure modes
- EXAMINE historical patterns and analogies
- IDENTIFY leverage points and critical factors

**STEP 4: Synthesis and Insights**

- INTEGRATE findings from different analytical approaches
- IDENTIFY novel connections and breakthrough insights
- HIGHLIGHT key trade-offs and tensions
- DISTILL actionable recommendations

**STEP 5: Validation and Next Steps**

- QUESTION assumptions and verify logic
- IDENTIFY areas requiring further exploration
- SUGGEST experiments or information to gather
- PROVIDE clear next steps

## Expected Output

```markdown
# Deep Analysis: [Topic]

## Core Insights

1. **[Primary Breakthrough]**
   - What: [Key realization]
   - Why: [Significance and implications]
   - How: [Practical applications]

2. **[Secondary Insight]**
   - [Brief description and importance]

## Critical Factors

- [Highest leverage points for action]
- [Key variables that determine outcomes]
- [Important trade-offs and tensions]

## Recommendations

### Immediate Actions
1. [Next steps to take]
2. [Experiments to run]
3. [Information to gather]

### Strategic Implications
- [How this changes approach]
- [New opportunities to pursue]
- [Risks to monitor]

## Open Questions

- [Areas requiring further exploration]
- [Assumptions to validate]
- [Scenarios to consider]
```

## Thinking Frameworks

Apply these systematic approaches based on the problem type:

**First Principles Analysis:**
- Break down to fundamental components
- Question basic assumptions
- Build up solutions from foundations

**Systems Thinking:**
- Examine interconnections and feedback loops
- Consider emergent properties
- Map system boundaries and influences

**Temporal Analysis:**
- Analyze historical patterns and trends
- Consider current state and dynamics
- Project future implications and scenarios

**Stakeholder Analysis:**
- Identify all affected parties
- Understand different viewpoints and incentives
- Consider constraints and requirements

## Examples

### Example 1: Strategic Decision
`/think "Should we adopt microservices architecture for our monolithic application?"`

Analysis would examine technical, organizational, and business factors, consider migration complexity, and provide structured recommendations.

### Example 2: Complex Problem
`/think "How can we improve team productivity while maintaining code quality?"`

Analysis would explore trade-offs, examine different approaches, and synthesize actionable strategies.

**IMPORTANT**: Focus on rigorous, systematic analysis that leads to actionable insights and better decision-making.