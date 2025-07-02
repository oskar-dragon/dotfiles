---
description: Creates a professional, concise README.md file for a repository
---

Analyse the current repository and create a professional README.md file following these principles:

## README Guidelines

**Structure and Content:**

- Keep it short
- Start with clear project title and one-line description
- Include Quick Start section with single command when possible
- Add essential commands/scripts only
- List core features concisely (3-5 bullet points maximum)
- Include installation requirements if non-standard
- Add contributing guidelines only if project accepts contributions

**Writing Style:**

- Use active voice and present tense
- Write for developers who need to get started quickly
- Avoid marketing language and excessive adjectives
- Keep explanations brief and action-oriented
- Use code blocks for all commands and code examples

**Technical Details:**

- Automatically detect project type (Node.js, Python, Go, etc.)
- Add appropriate package manager commands
- Reference existing documentation files if present
- Maintain consistency with existing project conventions

**What to Exclude:**

- Excessive emojis or decorative elements
- Verbose explanations that duplicate documentation
- Complete API documentation (link to docs instead)
- Detailed project history or roadmaps
- Personal acknowledgements or thank you sections

**Example concise README:**

````markdown
# Project Name

Brief one-line description of what it does.

## Quick Start

```bash
deno task init && deno task dev
```

## Key Commands

- `deno task test` - Run tests
- `deno task build` - Build project

## Features

- Core feature 1
- Core feature 2
- Core feature 3
````

Create the README.md file based on the current repository structure, package files, and existing code.
