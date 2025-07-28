---
allowed-tools: Read, Write, Bash(mkdir:*), Bash(git:*), Bash(gdate:*), Bash(eza:*)
description: Interactive generator for Claude slash commands with best practices validation and namespace organization
argument-hint: "[namespace] | [command-name]"
---

## Context

- Current directory: !`pwd`
- Git status: !`git status --porcelain 2>/dev/null || echo "clean"`
- Existing .claude directory: !`eza -la .claude 2>/dev/null || echo "no .claude directory"`
- Style Guide: @~/.claude/docs/slash-command-style-guide.md

## Your Task

FOLLOW the comprehensive slash command style guide for all standards.

**BEFORE YOU START** READ the style guide completely. You **must** apply all standards where applicable, there are no exceptions.

### STEP 1: Analyze Environment and Gather Requirements

IF no command specification provided:

- ANALYZE existing command structure and project patterns
- IDENTIFY command namespace requirements
- PROMPT user for:
  - **Command Purpose**: What specific task should this command automate?
  - **Command Name**: Kebab-case, descriptive, follows namespace conventions
  - **Parameters Needed**: None, single (`$ARGUMENTS`), or multiple structured inputs
  - **Command Type**: Simple utility, Code analysis, Web research, File operations, Git workflow
  - **Namespace Selection**: Existing or new namespace (e.g., `analyze/`, `code/`, `git/`)
  - **Dynamic Context Requirements**: Real-time information needed (e.g., file system, Git state)

ELSE IF:

- you think there are gaps and you need to ask more information about the command and what it should do, ask the user for more details

ELSE:

- Go to STEP 2

### STEP 2: Plan Command Structure

- THINK critically what the command will need to do to satisfy the requirements that user provided

ELSE:

- PROVIDE a detailed plan for the command structure to the user, including parameter definitions, error handling, and output formatting. Justify the reasoning to the user and explain how each component contributes to the overall functionality. Also, show how it aligns with the standards.

### STEP 3: Generate Command Structure

- GENERATE command structure using appropriate template from style guide

### STEP 4: Validate Against Style Guide

- **VALIDATE against Comprehensive Command Validation Checklist from Style Guide**
- TEST all bash commands individually for proper output
- VERIFY shell quoting and error handling patterns

### STEP 5: Report Results

- SHOW summary of what you did

## Examples

`/generate-command`
`/generate-command --namespace analysis`
`/generate-command --namespace git`
