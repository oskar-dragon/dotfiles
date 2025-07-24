---
allowed-tools: [LS, Read, Bash]
description: List all projects with current phase and completion status
---

## Context

- Current directory: !`pwd`
- Vault directory: Current directory (assumes running from Obsidian vault)
- Available projects: !`ls .claude/specs 2>/dev/null || echo "No projects yet"`

## Usage

```
/project-list
```

## Your Task

**STEP 1: Locate Project Directory**

- USE current directory as vault
- CHECK for `.claude/specs/` directory in current location
- IF specs directory not found, provide guidance for setup

**STEP 2: Check Projects Directory**

IF `.claude/specs/` directory doesn't exist:

- INFORM user no projects found
- SUGGEST using `/project:01-create` to create first project
- EXIT with usage guidance

ELSE:

- LIST all subdirectories in `.claude/specs/`
- IF empty directory, inform user no projects exist

**STEP 3: Analyze Each Project**

FOR EACH project directory:

- READ project name from directory name
- CHECK which files exist (project.md, tasks.md)
- PARSE project.md to extract goal and motivation
- DETERMINE current phase based on file presence and task completion
- COUNT completed vs total tasks if tasks.md exists
- GET last modified date from newest file

**STEP 4: Determine Phase Status**

FOR EACH project:

- IF only project.md exists: Phase = "Planning"
- IF project.md + empty tasks.md exist: Phase = "Task Generation"
- IF tasks.md has tasks: Phase = "In Progress"
- IF all tasks marked [x]: Phase = "Done"

**STEP 5: Display Overview**

SHOW comprehensive portfolio view:

- Total project count and portfolio health
- Each project with name, goal, progress and last updated
- Visual indicators for completion status and momentum
- Suggested next actions for incomplete tasks

## Expected Output

Displays formatted list of all projects:

```
Project Specs Overview

Active Projects (3)

1. Website Redesign 🔄 Almost Done! (10/12 tasks - 83%)
   Goal: Complete website overhaul with modern design
   Why: Improve user experience and increase conversions
   Next: Cross-browser testing
   Last updated: 2025-01-15

2. Home Office Setup 🔄 Making Progress (3/8 tasks - 38%)
   Goal: Create productive, focused workspace
   Why: Boost productivity and work-life balance
   Next: Research standing desk options
   Last updated: c

3. Blog Content Strategy 📝 Getting Started (0/6 tasks - 0%)
   Goal: Develop 6-month content calendar
   Why: Build authority and attract ideal clients
   Next: Market research
   Last updated: 2025-01-15

Completed Projects (1)

4. Morning Routine Optimization ✅ Complete
   🎯 Goal: Establish consistent morning routine
   🎉 Completed: 2025-01-02
   💡 Insight: Consistency improved overall daily energy

Portfolio Momentum:
├─ Total tasks: 26 across active projects
├─ Completed: 13 tasks (50%)
└─ This week: 2 tasks completed

Focus Recommendations:
1. Priority: Finish Website Redesign (only 2 tasks left!)
2. Maintain: Continue Home Office Setup progress
3. Start: Blog Content Strategy when done with the other tasks
```

## Other Features

### Portfolio Health

- **Visual Progress**: Clear completion ratios and momentum indicators
- **Momentum Tracking**: Highlights recent progress and completion trends
- **Focus Guidance**: Suggests which projects to prioritize

### Motivation Support

- **Goal Reminders**: Shows each project's main goal and motivation
- **Why This Matters**: Displays motivation statements for re-engagement
- **Completion Celebration**: Highlights finished projects and achievements
- **Progress Visualization**: Makes progress tangible and rewarding

### Decision Support

- **Priority Guidance**: Identifies which projects need attention
- **Context Switching**: Minimizes decision fatigue with clear recommendations

## Examples

### Example 1: Multiple Active Projects

```
/project-list
```

Shows portfolio overview with energy recommendations and momentum tracking.

### Example 2: No Projects

```
/project-list
```

Displays guidance for creating first project with motivational messaging.

### Example 3: Mixed Portfolio

Shows combination of active, stalled, and completed projects with actionable insights.

## Important Notes

- **Portfolio View**: See all projects and their relative health at once
- **Energy Matching**: Helps choose appropriate tasks for current energy state
- **Obsidian Integration**: Works with projects stored in `.claude/specs/` directory
- **Momentum Tracking**: Celebrates progress and identifies stalled projects
- **No Arguments**: Always shows complete portfolio overview
