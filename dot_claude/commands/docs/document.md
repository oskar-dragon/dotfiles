---
allowed-tools: Read, Write, Bash(fd:*), Bash(rg:*), Bash(git:*), Glob, Grep
description: Generate project documentation by analyzing code structure and existing files
---

# /document

Generate project documentation by analyzing the codebase and creating structured documentation files.

## Context

- Current directory: !`pwd`
- Target scope: $ARGUMENTS
- Project files: !`fd "(package\.json|go\.mod|Cargo\.toml)" . | head -5 || echo "No project files detected"`
- Existing docs: !`fd "README|CHANGELOG|API" . -t f | head -3 || echo "No existing docs"`
- Git status: !`git status --porcelain 2>/dev/null | head -3 || echo "Not a git repository"`

## Your Task

STEP 1: Analyze Project Structure

- READ project configuration files (package.json, go.mod, etc.)
- IDENTIFY project type and main technologies
- SCAN existing documentation to understand coverage gaps
- DETERMINE documentation scope based on $ARGUMENTS or default to README

STEP 2: Generate Documentation

IF $ARGUMENTS contains "readme" OR no specific type requested:
- ANALYZE project structure and dependencies
- EXTRACT project description from config files
- CREATE README.md with:
  - Project overview
  - Installation instructions
  - Usage examples
  - Development setup

IF $ARGUMENTS contains "changelog":
- ANALYZE git history for conventional commits
- EXTRACT version tags and release information
- CREATE CHANGELOG.md with release notes

IF $ARGUMENTS contains "api":
- SEARCH for API definitions (OpenAPI, GraphQL schemas)
- ANALYZE route handlers and service interfaces
- CREATE API documentation with endpoints and examples

STEP 3: Validate and Format

- VALIDATE markdown syntax
- CHECK for broken internal links
- ENSURE code examples are accurate
- FORMAT files consistently

STEP 4: Report Results

- LIST generated documentation files
- PROVIDE file locations and brief descriptions
- SUGGEST next steps for documentation maintenance
