---
allowed-tools: [Read, Write, Edit, LS, Bash]
description: Generate executable task breakdown from project phases
---

## Context

- Project name: $ARGUMENTS
- Current directory: !`pwd`
- Vault directory: Current directory (assumes running from Obsidian vault)
- Existing projects: !`ls .claude/specs 2>/dev/null || echo "No projects yet"`
- Available templates: !`ls ~/.claude/templates/project/`

## Usage

```
/project:02-tasks [project-name]
/project:02-tasks Clean Flat
```

## Your Task

**STEP 1: Validate Prerequisites**

IF no project-name provided:

- LIST available projects in `.claude/specs/` directory  
- ASK user to specify which project to work on
- EXIT with usage guidance

ELSE:

- USE current directory as vault
- VALIDATE project directory exists at `.claude/specs/{project-name}/`
- CHECK project.md exists and has content
- LOAD project.md for phase and task analysis

**STEP 2: Load Tasks Template**

- LOAD tasks template from `~/.claude/templates/project/tasks-template.md`
- IF template not found, use built-in task structure
- PREPARE template structure for task breakdown

**STEP 3: Analyze Project Phases**

- PARSE project.md to extract phases
- IDENTIFY phase structure
- EXTRACT project goals and success metrics for context

**STEP 4: Generate Executable Tasks**

CREATE atomic, actionable tasks from project phases:

- FOLLOW the exact structure and format from tasks-template.md
- USE "# Implementation Plan" as main title
- INCLUDE "## Overview" section with brief project description
- ORGANIZE tasks under "## Task Breakdown" with numbered phases
- USE checkbox format: `- [ ] #. [Task name]` with numbered hierarchy
- REFERENCE requirements using _Requirements: X.Y_ format
- BUILD incrementally (each task builds on previous)

**STEP 5: Apply Task Guidelines**

ENSURE each task:

- Has clear, actionable objective
- Specifies concrete deliverables as sub-bullets
- References specific requirements
- Builds incrementally toward project goals and on previous tasks
- **CRITICAL**: Must follow the exact template structure from tasks-template.md
- Uses proper phase grouping (### Phase 1: Name, ### Phase 2: Name, etc.)
- Follows checkbox format exactly as shown in template

**STEP 5: Present and Request Approval**

- DISPLAY complete task breakdown
- ASK: "Do the tasks look good?"
- IF feedback provided, REVISE tasks accordingly
- CONTINUE revision cycle until explicit approval received

**STEP 6: Complete Phase**

- WRITE final tasks.md to `.claude/specs/{project-name}/`
- CONFIRM tasks phase is complete
- **CRITICAL**: Do not run any execution commands yet
- **NEXT STEP**: Tasks ready for execution using `/project:03-execute {project-name}`

## Expected Output

Creates tasks.md with execution breakdown following tasks-template.md structure:

```markdown
# Implementation Plan

## Overview

Brief description of the project and implementation approach.

## Task Breakdown

### Phase 1: [Phase Name]

- [ ] 1. [Specific actionable task]
  - [Concrete deliverable description]
  - [Specific completion criteria]
  - [Quality standards or dependencies]
  - _Requirements: 1.1_

- [ ] 2. [Next sequential task]
  - [Deliverable details]
  - [Prerequisites or dependencies]
  - [Success criteria]
  - _Requirements: 1.2_

### Phase 2: [Phase Name]

- [ ] 3. [Follow-up task]
  - [Clear completion criteria]
  - [Expected outcomes]
  - [Validation methods]
  - _Requirements: 2.1_

- [ ] 4. [Final phase task]
  - [Specific deliverable]
  - [Quality checkpoints]
  - [Project goal alignment]
  - _Requirements: 2.2_
```

## Task Categories

**Included Task Types:**

- Research and information gathering
- Content creation and writing
- Organization and planning
- Communication and outreach
- Creative work
- Administrative tasks
- Learning and skill development

## Examples

### Example 1: Content Project

```
/project-tasks blog-content-strategy
```

Creates task breakdown for content planning with research, writing, and publishing phases.

### Example 2: Home Organization

```
/project-tasks home-office-setup
```

Creates task breakdown for workspace organization with planning, sourcing, and setup phases.

## Important Notes

- **Prerequisites**: Requires existing project.md in `.claude/specs/{project-name}/` directory
- **Format Alignment**: Uses identical task format to spec workflow for consistency
- **Requirements Mapping**: Project phases become numbered requirements for traceability
- **ADHD Support**: Maintains energy awareness in planning and execution phases
- **File Location**: Creates tasks.md in `.claude/specs/{project-name}/` directory
- **Template Source**: Uses global `~/.claude/templates/project/tasks-template.md` with exact structure
- **Task Format**: Checkbox format with requirement references
- **Approval Required**: Must receive explicit user approval before proceeding
- **No Implementation**: Only creates task breakdown, does not execute them
- **Next Phase**: User has to use `/project:03-execute {project-name}` to begin implementation
