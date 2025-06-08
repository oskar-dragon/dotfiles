# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by [Chezmoi](https://www.chezmoi.io/), a tool for managing configuration files across multiple machines. The repository contains personal configurations for development tools, shell environments, and applications.

## Key Commands

### Chezmoi Management
- `chezmoi diff` - Show what changes would be made to your dotfiles
- `chezmoi apply` - Apply the dotfiles to your system
- `chezmoi update` - Pull and apply the latest changes
- `chezmoi edit <file>` - Edit a managed file (e.g., `chezmoi edit ~/.zshrc`)
- `chezmoi add <file>` - Add a new file to be managed by chezmoi
- `chezmoi cd` - Change to the chezmoi source directory for git operations

### Testing Changes
After making changes to templates or configurations, always run:
```bash
chezmoi diff
```
to preview changes before applying them with `chezmoi apply`.

## Architecture

### File Naming Conventions
Chezmoi uses special prefixes to determine file handling:
- `dot_` → `.` (e.g., `dot_zshrc` becomes `.zshrc`)
- `.tmpl` extension → processed as Go templates with variables
- `private_` → files with restricted permissions (0600)
- `executable_` → files made executable (0755)
- `symlink_` → creates symbolic links

### Template System
Files ending in `.tmpl` are processed as Go templates using variables defined in `.chezmoi.toml.tmpl`. Key template variables include:
- `{{ .git_email }}` - Git email address
- `{{ .work_computer }}` - Boolean for work machine configurations
- `{{ .personal_computer }}` - Boolean for personal machine configurations
- `{{ .use_secrets }}` - Boolean for 1Password integration

### Package Management
Package installations are defined in `.chezmoidata/packages.toml` with sections for:
- `packages.homebrew.common` - Packages for all machines
- `packages.homebrew.work_computer` - Work-specific packages
- `packages.homebrew.personal_computer` - Personal-specific packages

### Scripts Directory
`.chezmoiscripts/` contains installation and configuration scripts:
- `run_before_*` - Scripts that run before applying dotfiles
- `run_once_after_*` - Scripts that run once after applying dotfiles
- `run_onchange_*` - Scripts that run when their content changes

## Configuration Structure

### Core Configurations
- `dot_zshrc.tmpl` - Zsh shell configuration with Oh My Zsh
- `dot_gitconfig.tmpl` - Git configuration with templated email
- `dot_config/zed/` - Zed editor settings and themes
- `dot_config/ghostty/config` - Ghostty terminal configuration

### Machine-Specific Setup
The repository supports different machine types through the initial configuration prompts:
- Work computers get additional development tools
- Personal computers get media and productivity applications
- Secret management through 1Password integration

When editing configurations, consider which machine types should receive the changes and use appropriate template conditionals.