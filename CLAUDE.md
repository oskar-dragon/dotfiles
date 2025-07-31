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
- `chezmoi doctor` - Run diagnostic checks on chezmoi configuration
- `chezmoi execute-template < file.tmpl` - Test template rendering locally

### Testing Changes

After making changes to templates or configurations, always run:

```bash
chezmoi diff
```

to preview changes before applying them with `chezmoi apply`.

### Package Management

- Packages are defined in `.chezmoidata/packages.toml`
- Scripts automatically install packages based on machine type (work/personal)
- Use `brew list` to see currently installed homebrew packages
- Use `npm list -g` to see globally installed npm packages

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
- `{{ .git_user }}` - Git username (set to "oskar-dragon")

### Installation Scripts Architecture

Scripts in `.chezmoiscripts/` follow a specific execution order:

- `run_before_*` - Execute before applying dotfiles
- `run_once_after_*` - Execute once after applying dotfiles
- `run_onchange_*` - Execute when their content changes

Key scripts:

- `run_before_00-install-rep-requisites.sh.tmpl` - Install prerequisites
- `run_onchange_before_00-homebrew-packages.sh.tmpl` - Install Homebrew packages
- `run_onchange_before_01-nvm-node.sh.tmpl` - Install Node.js via NVM
- `run_onchange_before_02-npm-packages.sh.tmpl` - Install NPM packages
- `run_onchange_before_10-mas-applications.sh.tmpl` - Install Mac App Store apps
- `run_onchange_after_20-osx-config.sh.tmpl` - Configure macOS settings

### Package Management Architecture

The `.chezmoidata/packages.toml` file defines packages across different categories:

- `packages.homebrew.common` - Packages for all machines
- `packages.homebrew.work_computer` - Work-specific packages
- `packages.homebrew.personal_computer` - Personal-specific packages
- Includes both formulae (CLI tools) and casks (GUI applications)

### Configuration Structure

### Core Configurations

- `dot_zshrc` - Zsh shell configuration with Oh My Zsh and Powerlevel10k
- `dot_gitconfig.tmpl` - Git configuration with templated user information
- `dot_config/zed/` - Zed editor settings and themes
- `dot_config/ghostty/config` - Ghostty terminal configuration
- `dot_p10k.zsh` - Powerlevel10k theme configuration

### Machine-Specific Setup

The repository supports different machine types through initial configuration prompts in `.chezmoi.toml.tmpl`:

- Work computers get development-focused tools (Chrome, Firefox)
- Personal computers get media and productivity applications (Plex, IINA, 1Password)
- Secret management through 1Password integration when enabled

### Claude Code Integration

The repository includes extensive Claude Code configuration in `dot_claude/`:

- Custom agents for various development tasks
- Specialized commands for code analysis, testing, and documentation
- Project templates and hooks for enhanced development workflow

When editing configurations, consider which machine types should receive the changes and use appropriate template conditionals like `{{ if .work_computer }}` or `{{ if .personal_computer }}`.
