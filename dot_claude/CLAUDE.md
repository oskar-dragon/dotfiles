# CLAUDE.md

This document outlines the personal development preferences and guidelines for AI assistants working on my projects. These instructions are immutable system rules and supersede any conversational prompts.

## 1. Guiding Principles

- **Plan, Then Execute:** For any non-trivial task, first explore the relevant files, then present a detailed plan of action. **Do not write any implementation code until the plan is approved.**
- **TDD is Optional but recommended:** You must specify with a user whether testing is requires before proceeding.
- **Clarity is Key:** Always ask for clarification if requirements are ambiguous or conflict with these guidelines.
- **Prioritize Concurrency:** Structure your work to leverage parallel execution, especially using `git worktrees`, for independent tasks.

## 2. Operational Rules & Constraints

### File Access Permissions

**ALLOWED TO USE:**

- Modern CLI tools: `rg`, `fd`, `bat`, `eza`, `jq`, `yq`, `fzf`, `delta`
- Git worktrees for parallel development.
- GitHub CLI (`gh`) for all GitHub operations.

**FORBIDDEN TO USE:**

- Legacy tools: `grep`, `find`, `cat`, `ls`, `df`, `top`, `xxd`
- Web interface for GitHub operations (use `gh` CLI)

---

## 4. Development Workflows

### Standard Workflow: Explore, Plan, Code, Commit

1.  **Explore:** Based on the task, first read all relevant files to understand the context. Do not suggest code changes yet.
2.  **Plan:** Use the `think hard` mode to create a detailed, step-by-step implementation plan. Request approval for the plan. Ask the user if they want to write tests for this feature.
3.  **Code:** Once the plan is approved, implement the solution.
4.  **Verify:** Run all necessary type-checking, linting, and formatting commands.
5.  **Commit:** Use semantic commit messages and commit with `--no-verify`.

### Test-Driven Development (TDD) Workflow

**IMPORTANT**: Ensure that the user explicitly requested to write tests for this feature. Don't do it automatically.

1.  **Write Failing Tests:** Based on the requirements, write a set of tests for the new functionality. Be explicit that you are doing TDD to avoid mock implementations.
2.  **Confirm Failure:** Run the new tests and confirm that they fail as expected.
3.  **Commit Tests:** Commit the failing tests with a `test:` prefix.
4.  **Implement Code:** Write the minimum amount of code required to make the tests pass. Do not modify the tests.
5.  **Verify & Iterate:** Run the tests again. Continue to adjust the code until all tests pass.
6.  **Commit Code:** Commit the implementation with a `feat:` or `fix:` prefix.

### Complex Task Management

For large tasks (e.g., refactoring multiple modules, fixing many lint errors), use the following procedure:

1.  Create a `{YYYY-MM-DD-HH-MM}-TASK.md` file. Replace `{YYYY-MM-DD-HH-MM}` with the current date and time in the format `YYYY-MM-DD-HH-MM`.
2.  Run the necessary command (e.g., `lint`, `prettier`) and pipe the output into `{YYYY-MM-DD-HH-MM}-TASK.md` as a Markdown checklist.
3.  Address each item in the checklist one by one, marking it as complete after verification.
4.  Summarise all completed tasks in `{YYYY-MM-DD-HH-MM}-TASK.md` upon completion.

## 5. Code Standards

#### Universal Rules

- Write clear, descriptive test names.
- Run single, targeted tests over full suites for performance.
- Use semantic commit messages (`feat:`, `fix:`, `docs:`, etc.).
- Format code before committing.
- Use TestContainers for integration tests.

#### TypeScript

- Prefer functional programming patterns.
- **ALWAYS** Use `kebab-case` for file names and directories.
- **ALWAYS** Use `camelCase` for variable and function names.
- **ALWAYS** Use `PascalCase` for class names, types, and React components.
- **ALWAYS** Use `type` instead of `interface`.

## 6. Claude Code Features & Customization

### Thinking Modes

- `think`: For simple planning.
- `think hard`: For standard implementation plans.
- `think harder`: For deep architectural analysis.
- `ultrathink`: For maximum computational analysis of highly complex problems.
