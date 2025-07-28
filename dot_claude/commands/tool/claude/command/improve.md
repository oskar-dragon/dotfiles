---
allowed-tools: Read, Write, Edit, Task, Glob, Grep, Bash(pwd), Bash(git:*), Bash(fd:*), Bash(head:*), Bash(wc:*), Bash(eza:*), Bash(gdate:*)
description: Improve slash commands by adding structure, tools, and best practices following principle of least privilege
argument-hint: "[command-file-path]"
---

## Context

- Current directory: !`pwd`
- Target file: $ARGUMENTS
- Style Guide: @~/.claude/docs/slash-command-style-guide.md

## Your Task

FOLLOW the comprehensive slash command style guide for all standards.

### STEP 1: Analyze Current Command

IF no command file specified:

- LIST available commands in current directory
- PROMPT user to specify a command file
- EXIT with usage guidance

ELSE:

- READ the style guide completely. You **must** apply all standards, there are not exceptions.
- READ the command file completely
- IDENTIFY current structure and format
- DETERMINE improvement needs based on style guide standards. Think critically.
- PROVIDE Information what this command does well and what requires improvement/aligning to comply with style guide standards

### STEP 2: Apply Improvements

- UPDATE slash command based on the proposed plan

### STEP 3: Validate and Test

- **VALIDATE against Comprehensive Command Validation Checklist from Style Guide**.

### STEP 4: Report Results

- SHOW summary of improvements

## Examples

`/improve "commands/search.md"`
`/improve "commands/git/commit.md"`
`/improve "commands/package/install.md"`
