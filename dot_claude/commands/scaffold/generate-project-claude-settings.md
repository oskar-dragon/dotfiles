---
allowed-tools: Bash(fd:*), Bash(jq:*), Read, Write, WebFetch
description: Generate project-specific .claude/settings.json based on project context with appropriate hooks and configurations
---

## Context

- Current directory: !`pwd`
- Project type detection: !`fd -e go -e ts -e js . -d 2 --type f | head -5 | xargs -I {} basename {} | cut -d. -f2 | sort | uniq | tr '\n' ' ' || echo "unknown"`
- Package managers: !`fd "package.json|go.mod" . -d 2 --type f | head -5 | xargs -I {} basename {} | tr '\n' ' ' || echo "none"`
- Existing Claude settings: !`[ -f .claude/settings.json ] && echo "exists" || echo "none"`
- Git repository: !`[ -d .git ] && echo "yes" || echo "no"`
- CI/CD files: !`fd ".github/workflows" . -d 3 --type f | head -3 | xargs -I {} basename {} 2>/dev/null | tr '\n' ' ' || echo "none"`

## Your task

Generate a project-specific .claude/settings.json file based on the project context, including appropriate permissions, hooks, and configurations.

STEP 1: Analyze project context and determine configuration needs

- IDENTIFY primary programming languages from file extensions
- DETECT build tools and package managers (package.json, go.mod, Cargo.toml)
- FIND test frameworks and linters in project files
- CHECK for existing CI/CD configurations (.github/workflows)
- LOCATE database configurations or API specs

STEP 2: Determine appropriate settings based on project type

- SELECT relevant permissions based on detected languages and tools
- CHOOSE appropriate hooks for auto-formatting and git integration
- CONFIGURE environment variables for project workflow

STEP 3: Create base configuration structure

CREATE initial settings.json with:

- Schema reference for validation
- Permission defaults (ask mode for security)
- Empty hooks object for customization
- Basic environment variables

STEP 4: Add language-specific permissions and hooks

FOR EACH detected language, add appropriate settings:

**IF TypeScript/JavaScript detected:**

- ADD npm/npx/pnpm/bun permissions
- ADD file read/write for .js/.ts files
- ADD prettier formatting hook
- ADD eslint formatting hook

**IF Go detected:**

- ADD go test/run/build/fmt permissions
- ADD go fmt formatting hook

STEP 5: Configure optional hooks based on project needs

**IF git repository detected:**

- OFFER git auto-stage hook for file changes
- SUGGEST git integration for commit workflows

**IF CI/CD detected:**

- ADD test execution hooks
- CONFIGURE linting and validation hooks

**IF development environment:**

- ADD notification hooks for task completion
- CONFIGURE command logging for debugging

STEP 6: Create and write settings.json file

CREATE .claude directory:

```bash
mkdir -p .claude
```

IF existing settings.json found:

- BACKUP existing file with timestamp
- MERGE or replace based on user preference

STEP 7: Generate final configuration

WRITE complete settings.json with:

- Schema validation
- Language-specific permissions
- Optional formatting hooks
- Project-appropriate environment variables

STEP 8: Provide usage guidance

OUTPUT success message with:

- Configuration file location
- Next steps for customization
- Validation commands
- MCP server suggestions if applicable

## Expected Output

The command generates a `.claude/settings.json` file with:

- Project-appropriate permissions
- Language-specific formatting hooks
- Environment variables for workflow optimization
- Backup of existing settings if present

## Examples

### TypeScript Project

```bash
/generate-project-claude-settings
```

Generates settings with npm/npx permissions, TypeScript file access, and prettier formatting hooks.

### Go Project

```bash
/generate-project-claude-settings
```

Generates settings with go tool permissions, Go file access, and go fmt formatting hooks.

### Multi-language Project

```bash
/generate-project-claude-settings
```

Detects all languages and creates appropriate permissions and hooks for each.

**IMPORTANT**: Review generated settings before use. Customize permissions and hooks based on your specific workflow needs.
