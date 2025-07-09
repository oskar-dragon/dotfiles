---
allowed-tools: Read, Write, Bash(fd:*), Bash(rg:*), Glob, Grep
description: Extract domain knowledge and architectural patterns from codebase
---

# /knowledge-extract

Extract domain knowledge and architectural patterns from codebase by analyzing structure and implementation.

## Context

- Target project: $ARGUMENTS
- Project structure: !`fd . -t d -d 3 | head -10 || echo "No directories found"`
- Build files: !`fd "(package\.json|go\.mod|Cargo\.toml)" . -d 3 | head -5 || echo "No build files detected"`
- Documentation: !`fd "(README|ARCHITECTURE|DESIGN|DOCS)" . -t f -d 2 | head -3 || echo "No docs found"`
- Code languages: !`fd "\.(go|ts|js|py|rs)$" . | head -5 | sed 's/.*\.//' | sort -u | tr '\n' ' ' || echo "No code files"`

## Your Task

STEP 1: Analyze Project Structure

- IDENTIFY project type and technology stack
- SCAN existing documentation for coverage gaps
- DETERMINE architectural complexity and patterns
- ASSESS code organization and modularity

STEP 2: Extract Domain Knowledge

**Core Business Entities:**

- SEARCH for struct/class/interface definitions
- IDENTIFY data models and domain types
- EXTRACT business terminology and relationships
- DOCUMENT entity constraints and validation rules

**Service Architecture:**

- ANALYZE service layers and handlers
- MAP service boundaries and dependencies
- IDENTIFY integration patterns and communication
- DOCUMENT business workflows and processes

**API Patterns:**

- DISCOVER REST endpoints and RPC services
- ANALYZE request/response patterns
- EXTRACT authentication and authorization flows
- DOCUMENT API contracts and integration points

STEP 3: Generate Documentation

CREATE knowledge artifacts in `docs/extracted-knowledge/`:

**Architecture Overview (architecture/system-overview.md):**

- System design and component relationships
- Technology stack and infrastructure choices
- Service boundaries and integration strategies
- Quality attributes and architectural decisions

**Domain Model (domain/business-model.md):**

- Core business entities and relationships
- Domain services and workflows
- Business rules and constraints
- Ubiquitous language and terminology

**API Reference (api/api-reference.md):**

- Endpoint inventory and specifications
- Service interfaces and contracts
- Integration patterns and examples
- Authentication and authorization patterns

STEP 4: Validate and Summarize

- VALIDATE documentation completeness
- CROSS-REFERENCE with actual implementation
- IDENTIFY knowledge gaps requiring expert input
- PROVIDE actionable next steps for team adoption

STEP 5: Report Results

GENERATE summary report with:

- Key architectural insights discovered
- Documentation artifacts created
- Knowledge gaps identified
- Recommendations for maintenance and evolution
