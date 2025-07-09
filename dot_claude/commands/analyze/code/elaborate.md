---
allowed-tools: [Read, Glob, Grep, Task, Bash]
description: Generate comprehensive technical analysis and implementation guidance for code features or architecture
---

# /elaborate

Generate comprehensive technical analysis and implementation guidance for code features, architecture decisions, or implementation approaches.

## Context

Use this command when you need detailed technical analysis beyond basic code review:

- Current directory: `!pwd`
- Git status: !`git status --porcelain 2>/dev/null || echo "Clean working directory"`
- Arguments: `$ARGUMENTS` (code pattern, feature, or architectural element to analyze)

## Usage

```bash
/elaborate "authentication system implementation"
/elaborate "microservices communication patterns"
/elaborate "React component testing strategy"
```

## Your Task

**STEP 1: Code Discovery and Analysis**

IF specific files or patterns mentioned in arguments:

- USE Glob to find relevant files: `**/*.{js,ts,go,py}`
- READ key implementation files
- GREP for related patterns and dependencies

ELSE:

- USE Task tool to search for architectural patterns
- ANALYZE project structure and conventions
- IDENTIFY key components and integrations

**STEP 2: Technical Assessment**

FOR EACH discovered component:

- ANALYZE code structure and design patterns
- EVALUATE architecture decisions and trade-offs
- ASSESS dependencies and integrations
- IDENTIFY performance characteristics

**STEP 3: Quality Evaluation**

- EXAMINE security considerations and vulnerabilities
- ASSESS scalability implications and bottlenecks
- EVALUATE maintainability factors and code complexity
- IDENTIFY technical debt and improvement opportunities

**STEP 4: Generate Comprehensive Analysis**

CREATE structured analysis document including:

- Technical overview with architecture diagrams
- Implementation patterns with code examples
- Best practices and recommendations
- Risk assessment and mitigation strategies
- Testing approaches and quality assurance

**STEP 5: Provide Actionable Guidance**

- SUGGEST specific improvement strategies
- RECOMMEND alternative approaches where applicable
- OUTLINE migration path if changes needed
- PROVIDE resource links and documentation references

## Expected Output

```markdown
# Technical Analysis: [Feature/Pattern Name]

## Architecture Overview

- System design and component relationships
- Data flow and communication patterns
- Key architectural decisions and rationale

## Implementation Analysis

- Code structure and organization
- Design patterns and practices used
- Performance characteristics and bottlenecks

## Quality Assessment

- Security considerations and vulnerabilities
- Scalability and maintainability factors
- Technical debt and improvement areas

## Recommendations

- Specific improvement strategies
- Alternative implementation approaches
- Migration roadmap with phases
- Testing and validation approaches

## Resources

- Relevant documentation and best practices
- Tools and libraries for implementation
- Community resources and examples
```

## Examples

### Example 1: Authentication Analysis

`/elaborate "JWT authentication flow in our Go API"`

Analyzes JWT implementation, security patterns, token management, and provides recommendations for secure authentication practices.

### Example 2: Architecture Review

`/elaborate "service communication patterns in our TypeScript backend"`

Reviews microservices architecture, communication protocols, error handling, and suggests improvements for reliability and performance.

### Example 3: Testing Strategy

`/elaborate "integration testing approach for React components"`

Examines testing patterns, test coverage, mock strategies, and recommends comprehensive testing approaches for React applications.

**IMPORTANT**: Focus on practical, actionable analysis that developers can immediately apply to improve their codebase. Avoid theoretical discussions without concrete implementation guidance.
