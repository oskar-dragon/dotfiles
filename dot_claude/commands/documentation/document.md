---
description: Generate documentation for a specific component or feature.
---

## Pre-Documentation Analysis Phase

**ALWAYS start by analysing the codebase first:**

1. **Codebase Structure Analysis**
   - Use filesystem tools to explore the target component/feature structure
   - Identify all related files, dependencies, and configuration
   - Map relationships between components, services, and utilities
   - Understand the technology stack and external dependencies
   - Identify environment-specific configurations and requirements

2. **Context Discovery**
   - Search for existing related documentation
   - Identify integration points with other systems/components
   - Understand user personas and use cases
   - Map testing strategies and patterns already in place

## Content Generation Standards

### Link-First Approach

**NEVER copy/paste code blocks - always link to files instead:**

```markdown
**Implementation**: See [`launch-darkly-adapter.ts`](../apps/buyers/src/core/flags/launch-darkly-adapter.ts)

**Location**: [`apps/buyers/src/core/flags/`](../apps/buyers/src/core/flags/)

**Configuration**: See [`middleware.ts`](../apps/buyers/src/middleware.ts)
```

**File Reference Patterns:**

- Use relative paths from documentation location
- Link to entire directories for comprehensive implementations
- Reference configuration files explicitly

### Technology Documentation Integration

**Always link external technologies to official documentation:**

```markdown
**SDK**: [LaunchDarkly Node.js SDK](https://docs.launchdarkly.com/sdk/server-side/node-js)
**Framework**: [Next.js App Router](https://nextjs.org/docs/app)
**Validation**: [Zod Schema Validation](https://zod.dev)
```

**Technology Linking Standards:**

- Link to specific sections of official docs when possible
- Include version-specific documentation where relevant
- Reference setup guides and best practices from official sources
- Link troubleshooting sections from official documentation

### Documentation Structure Template

Follow this structure, adapting sections based on the component/feature being documented:

```markdown
# [Component/Feature Name]

## Overview

[1-2 paragraph overview including technology stack and architecture approach]

## Architecture

[Explain the overall architecture - use diagrams where helpful]

## Environment Configuration

[Environment variables, setup requirements with links to config files]

## Implementation Details

[Organised by context/application with file links]

### [Context 1] (e.g., Modern App Router)

**Location**: [Link to implementation directory]
**Approach**: [High-level approach description]
**Key Files**: [List with links]

### [Context 2] (e.g., Legacy Pages Router)

**Location**: [Link to implementation directory]
**Approach**: [High-level approach description]
**Key Files**: [List with links]

## Usage Examples

[Practical examples with file references, not code copies unless it's better to keep them here as they will change too often]

## Best Practices

### [Category] (e.g., Naming Conventions)

[Specific guidance with examples]

### [Category] (e.g., Lifecycle Management)

[Specific guidance with examples]

## Testing

[Testing approaches with links to test files and examples if applicable]

## Security Considerations

[Security implications, CSP, environment variables if applicable]

## Troubleshooting

### Common Issues

[Issue descriptions with solutions]

### Debug Mode

[How to enable debugging ]

## Quick Reference

### [Component] Checklist

- [ ] [Action item]
- [ ] [Action item]

## Related Documentation

[Links to related internal documentation]
```

## Diagram Integration

**Identify when diagrams would be helpful:**

- Architecture overviews
- Data flow diagrams
- Component relationship diagrams
- Integration patterns
- User journey flows

**Diagram Creation Pattern:**

```markdown
## Architecture Overview

![Architecture Diagram](./diagrams/feature-flags-architecture.svg)

_Architecture diagram created with `/diagram` command - see [diagram source](./diagrams/feature-flags-architecture.md)_
```

**When to suggest diagram creation:**

- Complex component relationships
- Multi-step processes or workflows
- Integration patterns between systems
- State management flows
- Error handling paths

## Cross-Reference Network

**Always include related documentation:**

```markdown
## Related Documentation

- [Team Processes Guide](./001-team-processes.md) - For coordination around feature rollouts
- [Testing Guide](./004-testing-guide.md) - For comprehensive testing strategies
- [API Documentation](./api-reference.md) - For related API endpoints
```

**Cross-reference discovery:**

- Search existing documentation for mentions of the current topic
- Identify parent/child relationships in feature hierarchies
- Link to setup guides, troubleshooting docs, and related tools
- Include links to team processes and workflow documentation

## Command Integration

**Include integration with other Claude Code commands:**

```markdown
## Integration with Other Commands

**Development Workflow:**

- Combine with `/diagram` to create visual representations

## Quality Assurance Standards

**Documentation Quality Checks:**

- Validate all file links point to existing files
- Ensure external links are current and accessible
- Check that code examples match current implementation patterns
- Verify environment variables and configuration examples are accurate
- Confirm technology versions match project dependencies

**Maintenance Planning:**

- Include last updated timestamps

## Specific Technical Requirements

**TypeScript Integration:**

- Include type definitions and interfaces where relevant
- Link to type definition files rather than copying types

**Testing Integration:**

- Link to test files rather than copying test code
- Include both unit and integration testing approaches
- Reference E2E testing patterns and setup
- Document mocking and test data strategies

**Performance Considerations:**

- Include performance implications and optimisations
- Reference monitoring and observability setup
- Document caching strategies and considerations
- Include scaling and load testing approaches
```

## Integration with Other Commands

Combine with `/diagram` to create diagrams when needed

## Next steps

I'll help you create comprehensive documentation for $ARGUMENTS, following our project's documentation standards.

First, I'll analyze:

1. The code structure and purpose of $ARGUMENTS
2. Inputs, outputs, and behavior
3. User interaction flows
4. Edge cases and error handling
5. Integration points with other components/systems

Then I'll generate documentation in `docs/` directory in a project with this template:
