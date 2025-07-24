---
allowed-tools: Read, Glob, Grep, Edit, MultiEdit, Bash(fd:*), Bash(rg:*)
description: Update existing documentation files by refreshing content with current codebase information
argument-hint: "[file-pattern|all|validate]"
---

## Context

- Current directory: !`pwd`
- Target: $ARGUMENTS
- Project structure: !`fd --type d --max-depth 2 . | head -10`
- Technology stack: !`fd "(package\\.json|Cargo\\.toml|go\\.mod|requirements\\.txt)" . -d 2 | head -3`
- Existing docs: !`fd "docs" . -t d -d 2 | head -3 || echo "No docs directory"`
- Documentation files: !`fd "\\.md$" docs/ -t f | head -10 || echo "No markdown files found"`

## Your Task

**STEP 1: Determine Update Scope**

- ANALYZE $ARGUMENTS to detect update type:
  - IF $ARGUMENTS contains "validate": SET type = "validate"
  - ELSE IF $ARGUMENTS contains "all": SET type = "all"
  - ELSE IF $ARGUMENTS is empty: SET type = "all"
  - ELSE: SET type = "specific" and target = $ARGUMENTS

**STEP 2: Identify Documentation Files**

FOR ALL types:

- SCAN existing documentation files in docs/ directory
- IDENTIFY files needing updates based on type:
  - FOR "validate": CHECK all files for broken links and outdated content
  - FOR "all": UPDATE all documentation files
  - FOR "specific": FIND files matching target pattern

**STEP 3: Analyze Current Content**

FOR EACH identified documentation file:

- READ existing documentation content
- IDENTIFY sections with file references and code examples
- DETECT outdated information by comparing with current codebase
- LOCATE broken internal links and missing file references

**STEP 4: Update Documentation Content**

APPLY updates based on documentation type detected:

**FOR Component Documentation:**
- UPDATE file links to match current project structure
- REFRESH code examples with current implementations
- VERIFY configuration examples match current config files
- UPDATE technology stack references if changed

**FOR Guide Documentation:**
- VALIDATE step-by-step instructions against current codebase
- UPDATE file references in prerequisites and examples
- REFRESH command examples and outputs
- VERIFY external links are still valid

**FOR Troubleshooting Documentation:**
- UPDATE diagnostic commands and their expected outputs
- REFRESH log file locations and configuration paths
- VERIFY solutions still apply to current implementation
- UPDATE related file references

**STEP 5: Apply Content Standards**

- PRESERVE existing structure and manual content
- UPDATE only outdated file references and examples
- MAINTAIN relative path format: `See [filename](../path/to/file)`
- VERIFY all file links point to existing files
- KEEP original documentation tone and style

**STEP 6: Validation and Cleanup**

FOR type = "validate" OR after updates:

- CHECK all internal links point to existing files
- VERIFY external links are accessible
- VALIDATE code examples syntax
- ENSURE file references use correct relative paths
- REPORT any issues found

**STEP 7: Apply Changes**

- EDIT documentation files with updated content
- PRESERVE manual additions and customizations
- MAINTAIN original file organization
- PROVIDE summary of changes made

## Expected Output

Updated documentation files with:
- Current file references and links
- Refreshed code examples matching current implementation
- Validated internal and external links
- Updated configuration examples
- Preserved manual content and structure

## Examples

**Update All Documentation:**
`/docs-update`
`/docs-update all`

**Update Specific Files:**
`/docs-update "user-auth"`
`/docs-update "api-*.md"`
`/docs-update "troubleshooting"`

**Validate Documentation:**
`/docs-update validate`

## Validation Scope

When running validation, the command checks:

- **File Links**: All `[text](../path/to/file)` references
- **Code Examples**: Syntax validation for code blocks
- **External Links**: HTTP/HTTPS link accessibility
- **Image References**: Verify image files exist
- **Configuration Examples**: Match current config file structure

## Important Notes

- **Preserve Manual Content**: Only update file references and examples
- **Maintain Structure**: Keep existing documentation organization
- **Relative Paths**: Ensure all paths are relative from documentation location
- **Link Validation**: Verify all referenced files exist in current project
- **Focused Updates**: Update only what needs refreshing, preserve custom content