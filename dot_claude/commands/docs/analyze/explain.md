---
allowed-tools: Read, Write, Bash(rg:*), Bash(fd:*)
description: Provide comprehensive technical explanations of code, architecture, or concepts
---

# /explain

## Context

- Target: $ARGUMENTS
- Current directory: !`pwd`
- Code files: !`fd "\.(go|js|ts)$" . | wc -l | tr -d ' '` found

## Your Task

Provide comprehensive technical explanations of code, architecture, or technical concepts.

### Step 1: Analyze Target

Determine what needs explanation:

- Code snippet or function
- File or directory structure
- Technical concept or pattern
- System architecture
- Algorithm or data structure

### Step 2: Gather Context

- Read relevant source code files
- Identify related components and dependencies
- Check for existing documentation
- Understand the broader system context

### Step 3: Structure Explanation

Create a comprehensive explanation with:

**Overview:**

- Brief summary of what the code/concept does
- Primary purpose and use cases
- Key benefits and trade-offs

**Detailed Analysis:**

- Step-by-step breakdown of functionality
- Important implementation details
- Design decisions and rationale
- Performance characteristics

**Code Examples:**

- Practical usage examples
- Common patterns and idioms
- Best practices and anti-patterns
- Edge cases and error handling

**Context and Relationships:**

- How it fits into the larger system
- Dependencies and interactions
- Related concepts and alternatives
- Evolution and historical context

### Step 4: Add Interactive Elements

- Suggest follow-up questions
- Recommend related concepts to explore
- Provide practical exercises
- Link to additional resources

### Step 5: Create Documentation

Generate explanation document with:

- Clear headings and structure
- Code examples with syntax highlighting
- Diagrams where helpful
- References to source files

## Explanation Templates

### Function/Method Explanation

````markdown
# Function Name

## Purpose

Brief description of what the function does.

## Parameters

- `param1`: Description and type
- `param2`: Description and type

## Return Value

Description of what is returned.

## Implementation Details

Step-by-step explanation of the logic.

## Usage Examples

```language
// Example usage
```
````

## Edge Cases

- Case 1: Description
- Case 2: Description

````

### Architecture Explanation
```markdown
# System Architecture

## Overview
High-level description of the system.

## Components
- Component 1: Purpose and responsibilities
- Component 2: Purpose and responsibilities

## Data Flow
Description of how data moves through the system.

## Key Design Decisions
- Decision 1: Rationale
- Decision 2: Rationale

## Trade-offs
- Benefit 1 vs Cost 1
- Benefit 2 vs Cost 2
````

### Concept Explanation

```markdown
# Technical Concept

## Definition

Clear definition of the concept.

## Why It Matters

Importance and practical applications.

## How It Works

Detailed explanation of the mechanism.

## Examples

Real-world examples and use cases.

## Related Concepts

- Related concept 1
- Related concept 2
```

## Quality Guidelines

- Use clear, accessible language
- Provide concrete examples
- Include relevant code snippets
- Add visual aids where helpful
- Structure information logically
- Link to source code references
- Suggest further reading
- Keep explanations up-to-date

## Interactive Features

- **Follow-up Questions**: What would you like to understand better?
- **Related Topics**: Other concepts you might find interesting
- **Practical Exercises**: Hands-on activities to reinforce learning
- **Resource Links**: Documentation, tutorials, and references
