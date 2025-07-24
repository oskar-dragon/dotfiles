---
allowed-tools:
  [Write, Read, Bash, LS, mcp__sequential-thinking__sequentialthinking]
description: Guide user through project discovery and requirements capture in Obsidian vault
---

## Context

- Project name: $ARGUMENTS
- Current directory: !`pwd`
- Vault directory: Current directory (assumes running from Obsidian vault)
- Existing projects: !`ls .claude/specs 2>/dev/null || echo "No projects yet"`
- Project template: !`ls ~/.claude/templates/project/project-template.md`

## Usage

```
/project:01-create <project-name> [description]
/project:01-create website-redesign "Overhaul company website with modern design"
```

## Your Task

**STEP 1: Setup and Validation**

- EXTRACT project name from $ARGUMENTS (first argument)
- EXTRACT optional description (remaining arguments)
- USE current directory as Obsidian vault (user runs from vault directory)
- CHECK for existing `.claude/specs/` directory in current directory
- CREATE `.claude/specs/` if it doesn't exist

**STEP 2: Guided Project Discovery**

USE Sequential Thinking tool to systematically work through discovery process:

**Project Clarification:**

- What exactly do you want to achieve with this project?
- Help refine vague ideas into specific, measurable outcomes
- Ask clarifying questions to understand the real goal

**Motivation Mapping:**

- Why are you doing this project?
- What's driving this project?
- What will success look like?

**Life Area Classification:**

- Which area of focus does this belong to?
  - Spirituality
  - Personal Development
  - Lifestyle & Life Experiences
  - Health & Fitness
  - Finances
  - Family & Relationships
  - Career

**High-Level Phase Structure:**

- Break project into 3-5 logical phases maximum
- Define phase names and goals only (no detailed tasks)
- Ensure phases build logically toward project completion

**STEP 3: Create Directory Structure**

- ENSURE `.claude/specs/` directory exists in current directory
- CREATE `.claude/specs/{project-name}/` directory for the new project

**STEP 4: Generate Comprehensive Project Document**

- READ project template from `~/.claude/templates/project/project-template.md`
- POPULATE template with discovery insights:
  - Clear, specific project goals
  - Motivation and "why this matters" context
  - Life area classification
  - Well-structured high-level phases
  - Success metrics and completion criteria
- WRITE comprehensive project.md to `.claude/specs/{project-name}/` directory

**STEP 5: Initialize Supporting Files**

- CREATE empty `tasks.md` file in project directory
- SET up project for future task generation

**STEP 6: Confirm Creation and Next Steps**

- DISPLAY project location: `.claude/specs/{project-name}/`
- SHOW project overview with captured insights
- GUIDE user to next steps: "Review the project.md file in Obsidian, then run `/project:02-tasks {project-name}` to generate executable tasks"

## Expected Output

Creates the following structure in current directory:

```
.claude/specs/{project-name}/
├── project.md # Populated project template
└── tasks.md   # Empty file for future task generation
```

Displays:

- Project location path in current directory
- Comprehensive project overview with discovery insights
- Life area classification and motivation summary
- Phase structure and success criteria
- Next steps guidance for task generation

## Examples

### Example 1: Workspace Project

```
/project-create Organize and optimize home workspace

```

Guides through discovery to clarify specific workspace goals, understand motivation (productivity, focus), classify as Lifestyle area, and structure phases for assessment, planning, and implementation.

### Example 2: Content Project

```
/project-create Develop 6-month content calendar and publishing workflow

```

Leads discovery to define content goals, capture business motivation, classify as Career area, and outline phases for research, strategy development, and implementation.

## Important Notes

- **Guided Discovery**: Uses Sequential Thinking for systematic requirements gathering
- **Comprehensive Planning**: Captures goals, motivation, and life area context
- **Obsidian Integration**: Project lives in `.claude/specs/` for knowledge management
- **Clean Separation**: Requirements capture only - detailed tasks generated in `/project:02-tasks`
- **Thorough Foundation**: Proper discovery prevents scope creep and ensures clear direction
- **Next Phase**: Review project.md in Obsidian, then run `/project:02-tasks {project-name}`
