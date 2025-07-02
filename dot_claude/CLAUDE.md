# Clause User Memory

IMPORTANT: These are my development preferences and guidelines. YOU MUST follow them when working on my projects.

## General

- Always use British English

## Code Style & Workflow

## Development Preferences

- Prefer functional programming patterns
- Use kebab-case for file names and directories
- Use camelCase for variable and function names
- Use PascalCase for class names, types and React components
- Use Types instead of interfaces

### Testing

- **ALWAYS** write clear, descriptive test names for better readability
- **ALWAYS** prefer running single, targeted tests over the whole test suite for performance
<!-- TODO: add test for Claude.MD in a project -->

### Language & Framework Preferences

#### Frontend Programming

IMPORTANT: I am primarily a frontend developer and prefer these languages and frameworks:

- **JavaScript**: Use [React](https://reactjs.org/) with [TypeScript](https://www.typescriptlang.org/)
- **CSS**: Use [Tailwind CSS](https://tailwindcss.com/)
- **HTML**

#### Scripting & Automation

**YOU MUST** use Bun for all scripting tasks instead of Bash or Python

## Modern Development Tools

### Preferred Command-Line Tools

**ALWAYS** prefer these modern, fast alternatives:

- **ripgrep (rg)**: Use instead of grep for searching code
- **fd**: Use instead of find for finding files
- **fzf**: Use for interactive fuzzy finding
- **bat**: Use instead of cat for syntax-highlighted file viewing
- **exa/eza**: Use instead of ls for better file listings
- **delta**: Use for better git diffs
- **zoxide**: Use instead of cd for smarter directory navigation
- **duf**: Use instead of df for disk usage
- **htop/btop**: Use instead of top for process monitoring
- **jq**: Use for JSON processing and manipulation
- **yq**: Use for YAML processing and manipulation
- **hexyl**: Use for hex viewing of binary files

**IMPORTANT**: These tools are NOT optional suggestions - they are MANDATORY preferences. When writing any Bash commands or scripts, you MUST use these modern alternatives instead of their legacy counterparts.

### Common Commands

```bash
# Modern tool usage
rg "pattern" --type ts        # Search Typescript files
fd ".ts$" src/                   # Find all Typescript files
bat src/main.ts                  # View file with syntax highlighting
eza -la --git                    # List files with git status
delta                            # Better git diff viewer


# Git worktree (for multi-agent workflows)
git worktree add ../project-feature feature-branch
git worktree list
git worktree remove ../project-feature
```

---

## Development Workflow

1. **ALWAYS** run type checking/linting after code changes
2. **ALWAYS** format code before committing using project's formatter
3. **ALWAYS** run relevant tests before finishing
4. **NEVER** commit without running pre-commit checks
5. **ALWAYS** use semantic commit messages (feat:, fix:, docs:, refactor:, test:, chore:)

### AI-Assisted Development Pattern

1. **WRITE** failing tests first (test-driven development)
2. **GENERATE** implementation with AI assistance
3. **VERIFY** code meets requirements and security standards
4. **REFACTOR** at appropriate checkpoints, not continuously
5. **LOG** extensively for debugging AI-generated code

### Context Management

- **PROVIDE** clear, specific requirements to minimize context gaps
- **INCLUDE** relevant project context in prompts
- **DOCUMENT** assumptions and decisions in code comments, but only when they really add value. Be pragmatic about it

## Security & Code Verification

### AI-Generated Code Review

- **ALWAYS** review and understand AI-generated code before accepting
- **NEVER** commit code you don't fully understand
- **RUN** security scanning on all generated code
- **VERIFY** all third-party dependencies suggested by AI
- **TEST** edge cases and error handling thoroughly

### Sensitive Data Protection

- **NEVER** share API keys, credentials, or proprietary code
- **USE** environment variables or secret management tools
- **SANITIZE** logs and debug output before sharing

## Project Planning & Coordination

### PLAN.md Adherence

When a `PLAN.md` file exists in the project root, **YOU MUST**:

1. **READ** the PLAN.md file at the start of each session to understand current tasks and priorities
2. **FOLLOW** the task breakdown and execution strategy defined in the plan
3. **RESPECT** task dependencies and join points for multi-agent coordination
4. **UPDATE** task status in the plan as work progresses
5. **COORDINATE** with other agents at defined synchronization points
6. **USE** the TodoWrite tool to track individual tasks from the plan

### Multi-Agent Workflow

When working as part of a multi-agent team:

- **CHECK** `/tmp/{project-name}/project-status.md` or coordination files for shared state
- **WORK** only on assigned tasks to avoid conflicts
- **COMMUNICATE** progress through PR comments or status files
- **WAIT** at join points until all parallel work is complete
- **MERGE** work carefully following the plan's integration strategy
- **USE** git worktrees to work on separate branches without conflicts
- **CREATE** status files in `/tmp/{project-name}/claude-scratch/` for inter-agent communication
- **COORDINATE** using shared JSON status files for structured updates in project-specific directories

## Performance & Optimization

### Token Efficiency

- **OPTIMIZE** prompts for clarity and brevity
- **BATCH** related operations in single requests
- **USE** structured outputs (JSON) for parsing efficiency
- **CACHE** common patterns and solutions locally

### Parallel Development

- **IMPLEMENT** clear synchronization points for multi-agent work
- **MAINTAIN** shared state files in `/tmp/{project-name}/`

## Claude Code Features

### Thinking Modes

- `think` - Standard mode (4,000 tokens)
- `think hard` - Enhanced analysis
- `think harder` - Deep computation
- `ultrathink` - Maximum analysis (31,999 tokens)

### Effective Usage

- **USE** thinking modes for complex architectural decisions
- **AVOID** over-thinking simple tasks
- **BALANCE** computation time with task complexity

## IMPORTANT Notes

- **YOU MUST** follow these guidelines exactly as written
- **ALWAYS** ask for clarification if requirements conflict
- **NEVER** use deprecated patterns or old import styles
- **ALWAYS** prioritize performance and type safety
