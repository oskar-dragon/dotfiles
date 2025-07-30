# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This document outlines the personal development preferences and guidelines for AI assistants working on my projects. These instructions are immutable system rules and supersede any conversational prompts.

## Development Environment & Tools

### Required Modern CLI Tools

- **Search**: Use `rg` (ripgrep) instead of `grep`
- **File discovery**: Use `fd` instead of `find`
- **File viewing**: Use `bat` instead of `cat` for syntax highlighting
- **Directory listing**: Use `eza` instead of `ls`
- **Git operations**: Prefer `gh` CLI for GitHub operations

## Core Workflows

### 1. Standard Workflow: Explore, Plan, Code, Commit

**Implement**: This is not negotiable. You must follow this workflow.

1. **Explore**: Read all relevant files to understand the context. Do not suggest code changes yet.
2. **Plan**: Use detailed planning to create step-by-step implementation plan. Request approval for the plan. Ask the user if they want to write tests for this feature.
3. **Code**: Once the plan is approved, implement the solution.
4. **Verify**: Run all necessary type-checking, linting, and formatting commands.
5. **Commit**: Use semantic commit messages and commit with `--no-verify`.

### 2. Test-Driven Development (TDD) Workflow

**IMPORTANT**: Only use when user explicitly requests testing.

1. **Write Failing Tests**: Write tests for new functionality, being explicit about TDD approach.
2. **Confirm Failure**: Run tests and confirm they fail as expected.
3. **Commit Tests**: Commit failing tests with `test:` prefix.
4. **Implement Code**: Write minimum code to make tests pass.
5. **Verify & Iterate**: Continue until all tests pass.
6. **Commit Code**: Commit implementation with `feat:` or `fix:` prefix.

### 3. Complex Task Management

For large tasks (refactoring, fixing lint errors):

1. Create `.tasks/` directory if it doesn't exist: `mkdir -p .tasks`
2. Create timestamped task file: `touch .tasks/$(gdate "+%Y-%m-%d-%H-%M-%S")-TASK.md`
3. Pipe command output into task file as Markdown checklist
4. Address each item, marking complete after verification
5. Summarize completion with achievements, issues, and lessons learned

### 4. Git Worktree Workflow

For parallel development tasks:

- Use `git worktree add` to create separate working directories
- Leverage parallel execution for independent features
- Maintain separate contexts for complex refactoring

## Code Standards

### Universal Rules

- Write clear, descriptive test names
- Run single, targeted tests over full suites for performance
- Use semantic commit messages (`feat:`, `fix:`, `docs:`, etc.)
- Format code before committing
- Prioritize concurrency and parallel execution

### TypeScript Conventions

- Prefer functional programming patterns
- **ALWAYS** Use `kebab-case` for file names and directories
- **ALWAYS** Use `camelCase` for variable and function names
- **ALWAYS** Use `PascalCase` for class names, types, and React components
- **ALWAYS** Use `type` instead of `interface`
