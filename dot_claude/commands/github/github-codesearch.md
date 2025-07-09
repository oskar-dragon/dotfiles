---
allowed-tools: Bash(gh api:*), Bash(gh auth:*), Bash(base64:*), Bash(grep:*)
description: Search GitHub for code using GitHub CLI and display results with permalinks
---

Search GitHub for code using GitHub CLI and display results with permalinks.

## Context

- Search query: $ARGUMENTS
- Current directory: !`pwd`
- GitHub CLI auth status: !`gh auth status 2>/dev/null || echo "Not authenticated"`

## Your Task

STEP 1: Validate Query and Authentication

IF no search query provided:

- SHOW usage examples and common patterns
- EXIT with guidance

IF not authenticated:

- INSTRUCT user to run `gh auth login`
- EXPLAIN that GitHub code search requires authentication
- EXIT with setup instructions

STEP 2: Execute GitHub Code Search

SEARCH for code using GitHub CLI:

```bash
gh api search/code --header "Accept: application/vnd.github.text-match+json" --raw-field q="$ARGUMENTS"
```

STEP 3: Process Search Results

FOR EACH result (limit to first 10):

- EXTRACT repository information
- EXTRACT file path and content snippet
- GENERATE permalink with line numbers when possible

STEP 4: Display Results

FORMAT output as:

```
🔍 GitHub Code Search Results for: {query}

Found {total_count} results:

📁 {repository_name} - {repository_description}
📄 {file_path}
💻 Code snippet:
{highlighted_code_fragment}
🔗 {html_url}

---
```

STEP 5: Handle Errors

IF API rate limit exceeded:

- INFORM user to try again later
- SUGGEST using more specific queries

IF no results found:

- SUGGEST refining the search query
- PROVIDE example search patterns

Common search patterns:

- `path:**/*.ts` - Search TypeScript files
- `language:javascript react` - Search JavaScript files containing "react"
- `extension:md documentation` - Search Markdown files containing "documentation"
- `filename:package.json` - Search package.json files
