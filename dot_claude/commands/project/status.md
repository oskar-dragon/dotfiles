---
allowed-tools: [LS, Read, Bash, Grep]
description: Show detailed status of all projects or a specific project with ADHD-friendly progress tracking
---

## Context

- Project name: $ARGUMENTS (optional)
- Current directory: !`pwd`
- Vault directory: Current directory (assumes running from Obsidian vault)
- Available projects: !`ls .claude/specs 2>/dev/null || echo "No projects yet"`

## Usage

```
/project-status [project-name]
/project-status                    # Show all projects
/project-status Website Redesign   # Show specific project
```

## Your Task

**STEP 1: Determine Scope**

IF no project-name provided:

- SHOW status summary for all projects (portfolio view)
- LIST each project with phase, progress, and next actions
- PROVIDE overall project portfolio health

ELSE:

- USE current directory as vault
- VALIDATE specified project exists in `.claude/specs/{project-name}/`
- IF project not found, list available projects and ask user to choose
- SHOW detailed status for that specific project

**STEP 2: Analyze Project Files**

FOR target project(s):

- CHECK file existence: project.md, tasks.md
- READ project.md to extract goals, phases, and motivation
- READ tasks.md to determine task completion status
- COUNT total vs completed tasks if tasks.md exists
- IDENTIFY next pending task with energy requirements

**STEP 3: Determine Phase and Progress**

FOR each project:

- **Planning Phase**: Check if project.md exists and is complete
- **Task Generation Phase**: Check if tasks.md exists and is populated
- **Execution Phase**: Count [x] vs [ ] tasks in tasks.md
- **Complete Phase**: All tasks marked [x] and project goals achieved

**STEP 4: Status Display**

SHOW status with ADHD considerations:

- **Progress Visualization**: Clear completion ratios and momentum indicators
- **Energy Awareness**: Next task energy requirements and time estimates
- **Motivation Reminders**: Project goals and "Why This Matters" content
- **Small Wins**: Celebrate completed tasks and phases
- **Next Actions**: Specific, actionable next steps with energy matching

## Expected Output

### All Projects Status (Portfolio View)

```
📊 Project Portfolio Status

website-redesign (85% complete)
├─ Planning ✅ Complete
├─ Tasks ✅ Generated (12 tasks)
└─ Execution 🔄 10/12 tasks (83%)
   Next: Final testing /project:03-execute website-redesign

home-office-setup (40% complete)
├─ Planning ✅ Complete
├─ Tasks ✅ Generated (8 tasks)
└─ Execution 🔄 3/8 tasks (38%)
   Next: Research standing desk /project:03-execute home-office-setup

blog-content-strategy (10% complete)
├─ Planning ✅ Complete
├─ Tasks ⏸️ Pending generation
└─ Execution ⏸️ Not started
   ⏰ Next: /project-tasks blog-content-strategy
```

### Specific Project Status

```
🔍 Project: website-redesign
Phase: Execution (85% complete)
Goal: Complete website overhaul with modern design and improved UX
Progress: Planning ✅ | Tasks ✅ | Execution 🔄

Why This Matters:
Improve user experience, increase conversions, and establish modern brand presence

Phase 1: Research & Planning ✅ Complete (4/4 tasks)
├─ ✅ 1.1 Competitor analysis (Medium, 2 pomodoros)
├─ ✅ 1.2 User interviews (High, 3 pomodoros)
├─ ✅ 1.3 Content audit (Low, 1 pomodoro)
└─ ✅ 1.4 Technical requirements (Medium, 2 pomodoros)

Phase 2: Design & Development 🔄 6/8 tasks (75%)
├─ ✅ 2.1 Wireframe creation (High, 4 pomodoros)
├─ ✅ 2.2 Visual design (High, 6 pomodoros)
├─ ✅ 2.3 Frontend development (Medium, 8 pomodoros)
├─ ✅ 2.4 Content integration (Medium, 3 pomodoros)
├─ ✅ 2.5 Mobile optimization (Medium, 4 pomodoros)
├─ ✅ 2.6 Performance testing (Low, 2 pomodoros)
├─ 🔄 2.7 Cross-browser testing (Low, 1 pomodoro) - NEXT
└─ ⏸️ 2.8 Final QA review (Low, 1 pomodoro)

Next Action: /project:03-execute website-redesign 2
```

## Examples

### Example 1: Portfolio Overview

```
/project:status
```

Shows status overview for all projects.

### Example 2: Specific Project

```
/project:status website-redesign
```

Shows detailed task-level progress.

## Important Notes

- **Progress Visualization**: Clear completion indicators and momentum tracking
- **Obsidian Integration**: Works with files stored in `.claude/specs/` directory
- **Portfolio View**: See all projects and their relative progress
- **Next Actions**: Always provides clear, actionable next steps
