---
description: Test and validate Raycast scripts for proper functionality
allowed-tools: filesystem, bash
scope: project
---

Test and validate the Raycast script: $ARGUMENTS

Perform the following checks:

1. **Syntax Validation**: Check bash syntax using `bash -n`
2. **Raycast Metadata**: Verify all required Raycast headers are present and properly formatted
3. **Configuration Check**: Identify any configuration variables that need to be set
4. **Dependency Analysis**: Check for external dependencies (osascript, applications, etc.)
5. **Security Review**: Look for potential security issues or unsafe practices
6. **Error Handling**: Evaluate error handling and edge cases
7. **Output Summary**: Provide a checklist of findings and recommendations

If no script name is provided, test all scripts in the scripts/ directory.