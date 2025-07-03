---
description: Generate a new Raycast bash script with proper metadata headers
allowed-tools: filesystem
scope: project
---

Generate a new Raycast bash script based on the following requirements: $ARGUMENTS

Create a bash script that includes:

1. **Proper Script Structure**:
   - Start with shebang `#!/bin/bash`
   - Include all required Raycast metadata headers
   - Add proper error handling

2. **Required Metadata Headers**:
   - `@raycast.schemaVersion 1` (always required)
   - `@raycast.title` (descriptive name)
   - `@raycast.mode` (silent/inline/fullOutput)
   - `@raycast.packageName` (category/grouping)

3. **Optional Headers** (as appropriate):
   - `@raycast.icon` (relevant emoji or icon)
   - `@raycast.description` (brief explanation)
   - `@raycast.refreshTime` (for auto-updating scripts)
   - `@raycast.argument1` through `@raycast.argument10` (for parameterised scripts)

4. **Script Implementation**:
   - Write clean, focused bash code
   - Include proper error handling and validation
   - Add comments for complex logic

5. **File Placement**:
   - Save the script in the `scripts/` directory
   - Use kebab-case naming convention
   - Make the script executable

If no specific requirements are provided, ask for clarification on:

- Script purpose and functionality
- Required parameters or arguments
- Preferred execution mode
- Integration requirements (APIs, applications, etc.)
