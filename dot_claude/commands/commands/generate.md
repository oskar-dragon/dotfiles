---
description: Generate slash commands that can be used to automate common tasks or workflows with Claude code.
---

**Goal**
Add a reusable slash command that can be invoked within the Claude Code CLI. Commands can be project-scoped (`/project:<name>`) or user-scoped (`/<name>`).

---

## 1 Decide command scope and what it should do

### **Scope Decision**

- **Project command** → shared with your team, version-controlled, specific to this repository
- **User command** → personal to you, works across all projects, stored in your home directory

> **Key question**: Should this command be available to anyone who clones your repo, or is it just for your personal workflow?

### **Command Details**

- **Name** → becomes the slash-command (`<file>.md` → `/project:<file-name>` or `/<file-name>`).
- **Prompt text** → the body of the `.md` file; that text is sent to Claude when the command runs.
- **Parameters** (optional) → use the special token `$ARGUMENTS` to splice user-supplied arguments into the prompt.

> **Clarify**: What action do you want this command to automate? (e.g., "spin up a dev container", "generate a PR template", "audit code for security issues").

---

## 2 Scaffold the appropriate directory

### For **project commands** (shared with team):

```bash
mkdir -p .claude/commands
```

### For **user commands** (personal only):

```bash
mkdir -p ~/.claude/commands
```

---

## 3 Decide where to place the command file

### **Project commands** go in `./.claude/commands/`

- Simple: `./.claude/commands/audit-security.md` → `/project:audit-security`
- Grouped: `./.claude/commands/frontend/build.md` → `/project:frontend:build`

### **User commands** go in `~/.claude/commands/`

- Simple: `~/.claude/commands/daily-standup.md` → `/daily-standup`
- Grouped: `~/.claude/commands/personal/notes.md` → `/personal:notes`

> If there's already documentation for a similar command (e.g. `frontend-build.md`), consider creating a new directory called `frontend` and renaming the existing command to `build.md`.

---

## 4 Create the command file

### Simple project command (no parameters)

`./.claude/commands/audit-security.md`

```md
---
description: Audit this repository for security vulnerabilities
---

Audit this repository for security vulnerabilities:

1. Identify common CWE patterns in the code.
2. Flag third-party dependencies with known CVEs.
3. Output findings as a Markdown checklist.
```

Run it:

```bash
claude > /project:audit-security
```

### Parameterised user command

`~/.claude/commands/fix-issue.md`

```md
---
description: Fix a GitHub issue with minimal implementation
allowed-tools: filesystem, web_search
---

Fix issue #$ARGUMENTS.

Steps:

1. Read the ticket description.
2. Locate the relevant code.
3. Implement a minimal fix with tests.
4. Output a concise PR body with changelog notes.
```

Invoke with an argument:

```bash
claude > /fix-issue 417
```

`$ARGUMENTS` is replaced by `417` at runtime. ([docs.anthropic.com][1])

---

## 5 Add lightweight metadata

Claude code uses YAML frontmatter to add context to commands:

```md
---
description: Description visible in claude code CLI
allowed-tools: specific tools this command can use
scope: project # or 'user' for documentation
---

...prompt text...
```

---

## 6 Version control (project commands only)

### For **project commands**:

```bash
git add .claude/commands
git commit -m "docs: add /project:audit-security command"
```

Everyone who pulls the repo now has access.

### For **user commands**:

These live in your home directory and aren't version-controlled with your project.

---

## Command Scope Comparison

| **Project Commands**                              | **User Commands**                                            |
| ------------------------------------------------- | ------------------------------------------------------------ |
| **Location**: `./.claude/commands/`               | **Location**: `~/.claude/commands/`                          |
| **Invoke**: `/project:<name>`                     | **Invoke**: `/<name>`                                        |
| **Shared**: Yes, via Git                          | **Shared**: No, personal only                                |
| **Use case**: Team workflows, repo-specific tasks | **Use case**: Personal productivity, cross-project tools     |
| **Examples**: code review, deploy, test patterns  | **Examples**: daily notes, time tracking, personal templates |

---

### Alternative patterns & trade-offs

| Pattern                                                 | Pros                                     | Cons                                            |
| ------------------------------------------------------- | ---------------------------------------- | ----------------------------------------------- |
| **One-file-per-command (above)**                        | Simple, explicit, Git-friendly           | Many small files if you create lots of commands |
| **Directory sub-grouping**                              | Logical namespaces (`frontend/`, `ops/`) | Slightly longer slash-path                      |
| **Templated prompts with multiple `$ARGUMENTS` tokens** | Flexible (e.g., `$1`, `$2` style)        | Harder for newcomers to infer correct usage     |
| **Mixed project + user commands**                       | Best of both worlds                      | Need to remember which scope each command uses  |

---

## Next step

Let me know:

1. **Is this a project or user command?** (shared with team vs. personal)
2. **What specific task** should it perform?
3. **Any parameters** you'd like to include?

I'll draft the exact `.md` file contents and directory structure for you.

[1]: https://docs.anthropic.com/en/docs/claude-code/slash-commands "Slash Commands - Anthropic"
