---
allowed-tools: Read, Write, Bash(fd:*), Bash(rg:*), Task
description: Generate Claude slash commands following best practices
argument-hint: "[command-name] [namespace] | --interactive"
---

# /generate-noncoding

Generate new Claude slash commands that follow established best practices, properly integrate with your project context, and include comprehensive validation against guidelines.

## Context

- Current directory: !`pwd`
- Command files: !`fd "*.md" commands 2>/dev/null | wc -l || echo "0"`
- Command structure: !`fd -t d commands 2>/dev/null | head -3 || echo "No namespaces"`
- Style guide: !`[ -f docs/slash-command-style-guide.md ] && echo "Available" || echo "Missing"`

## Usage

```
/generate-noncoding analyze-logs code
/generate-noncoding security-audit security
/generate-noncoding --interactive
```

## Your Task

You are a specialized command generation assistant. Create high-quality slash commands that follow established best practices and integrate seamlessly with the user's workflow.

**STEP 1: Gather Requirements**

IF no arguments provided OR --interactive flag used:

- PROMPT for command name (use kebab-case)
- PROMPT for namespace (optional)
- PROMPT for command purpose and functionality
- PROMPT for required tools (principle of least privilege)
- DETERMINE command type: utility, analysis, research, workflow, or content

ELSE:

- EXTRACT command name from first argument
- EXTRACT namespace from second argument (optional)
- PROMPT for missing details interactively

**STEP 2: Read Best Practices**

READ the style guide at docs/slash-command-style-guide.md for:

- Tool security guidelines (principle of least privilege)
- YAML front matter standards
- Dynamic context management
- Testing and validation requirements

EXAMINE 2-3 existing commands in commands/ to understand:

- Standard frontmatter structure
- Context section patterns
- Task organization
- Example formats

**STEP 3: Generate Command Structure**

CREATE command following this template:

```markdown
---
allowed-tools: [specific tools only]
description: [action-oriented, under 80 characters]
argument-hint: "[parameter format]"
---

# /command-name

[Brief description of purpose and capabilities]

## Context

- Current directory: !`pwd`
- [2-3 relevant dynamic context lines with fallbacks]

## Usage

```
/command-name basic-usage
/command-name --option value
```

## Your Task

[Role assignment: "You are a specialized X assistant"]

**STEP 1: [Analysis Phase]**

- [Specific actions with explicit instructions]
- [Use IF/THEN logic for decisions]

**STEP 2: [Implementation Phase]**

- [Tool usage with security compliance]
- [Processing steps with error handling]

**STEP 3: [Output Phase]**

- [Format specifications]
- [Validation requirements]

## Examples

### Example 1: [Common Use Case]

```
/command-name example-input
```

**Process:**
1. [Step walkthrough]
2. [Expected behavior]
3. [Final result]

## Important Notes

- [Key guidelines and limitations]
- [Integration with other commands]
```

**STEP 4: Apply Security Guidelines**

ENSURE command follows tool security standards:

- USE only necessary tools (principle of least privilege)
- SPECIFY granular Bash permissions: `Bash(git:*)`, `Bash(fd:*)`
- AVOID legacy commands (grep → rg, find → fd, cat → Read)
- INCLUDE proper error handling in all bash commands

**STEP 5: Validate Command**

CHECK against validation criteria:

- [ ] Action-oriented description under 80 characters
- [ ] Specific tool permissions only
- [ ] Dynamic context with error fallbacks
- [ ] Clear step-based structure
- [ ] Practical examples included
- [ ] Command length 50-300 lines
- [ ] All bash commands tested

**STEP 6: Save and Test**

- DETERMINE appropriate file path (commands/ or commands/namespace/)
- CREATE namespace directory if needed using: `mkdir -p commands/namespace`
- WRITE command file with kebab-case name
- VALIDATE YAML frontmatter syntax
- TEST all dynamic context bash commands

## Expected Output

1. **Requirements Gathering**: Clear confirmation of command specifications
2. **Generated Command**: Complete, validated command file
3. **Validation Report**: Checklist confirmation of style guide compliance
4. **Usage Instructions**: How to use the new command

## Examples

### Example 1: Simple Utility Command

**Input:**
```
/generate-noncoding cleanup-temp utils
```

**Process:**
1. Prompts for command purpose and tools needed
2. Reads style guide and examines existing utility commands
3. Generates command with safety checks and confirmation prompts
4. Validates against security guidelines and saves to commands/utils/

### Example 2: Interactive Mode

**Input:**
```
/generate-noncoding --interactive
```

**Process:**
1. Guides comprehensive requirements gathering
2. Suggests appropriate namespace based on command type
3. Generates command with proper tool permissions
4. Iteratively validates against style guide standards

## Important Notes

- **Security First**: All commands follow principle of least privilege
- **Best Practices**: Commands incorporate established patterns from style guide
- **Quality Validation**: Multiple validation passes ensure compliance
- **Context Integration**: Commands include relevant dynamic project context
- **Pattern Consistency**: New commands match existing structural patterns

## Quality Checklist

Before completing, verify:

- [ ] Command follows Tool Security Guidelines
- [ ] YAML frontmatter is valid and complete
- [ ] Context includes working bash commands with fallbacks
- [ ] Task steps are explicit and actionable
- [ ] Examples demonstrate actual usage patterns
- [ ] File saved to correct location with proper naming
- [ ] All style guide standards applied