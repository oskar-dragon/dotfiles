# Dotfiles with Chezmoi

This repository contains my personal dotfiles managed using [Chezmoi](https://www.chezmoi.io/), a dotfile manager that helps you synchronize your dotfiles across multiple machines securely.

## Overview

These dotfiles include configurations for:

- Zsh shell configuration
- Git configuration
- Editor settings (Zed)
- Terminal configuration (Ghostty)
- Package managers (Homebrew, npm)
- Development tooling
- Custom aliases and functions

## Features

- Cross-platform support (macOS, Linux)
- Secret management with Bitwarden
- Conditional configurations for personal and work machines
- Automated dependency installation
- Template-based configuration files
- Idempotent setup scripts
- Machine-specific customizations

## Prerequisites

- [Chezmoi](https://www.chezmoi.io/install/)
- Git
- macOS or Linux-based system
- Bash or Zsh shell

## Getting Started

### Installation

```bash
# Install Chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply oskar-dragon
```

This will:

1. Install Chezmoi if it's not already installed
2. Clone this repository
3. Ask you a few configuration questions
4. Apply the dotfiles to your system

### Update

To update your dotfiles on any machine, run:

```bash
chezmoi update
```

### Making Changes

To make changes to your dotfiles:

```bash
# Edit a managed file
chezmoi edit ~/.zshrc

# See what changes would be made
chezmoi diff

# Apply the changes
chezmoi apply
```

### Adding New Files

To add a new file to your dotfiles:

```bash
# Add a file
chezmoi add ~/.config/new-tool/config

# Commit and push the changes
chezmoi cd
git add .
git commit -m "Add new-tool config"
git push
```

## Structure

- `.chezmoi.toml.tmpl`: Template for Chezmoi configuration
- `.chezmoiscripts`: Scripts that run during installation
  - `run_once_before_*.sh.tmpl`: Scripts that run before applying dotfiles
  - `run_once_after_*.sh.tmpl`: Scripts that run after applying dotfiles
- `.chezmoitemplates`: Template files used across multiple dotfiles
- `.chezmoiignore`: Files to ignore when applying dotfiles
- `dot_*`: Regular dotfiles that get installed to your home directory
- `executable_*`: Files that should be made executable
- `private_*`: Files that should have their permissions set to 0600
- `symlink_*`: Symbolic links to be created

### Naming Conventions

Chezmoi uses special prefixes to determine how files should be treated:

- `dot_` becomes `.` (e.g., `dot_zshrc` → `.zshrc`)
- Files with `.tmpl` extension are processed as templates
- `private_` files have restricted permissions (0600)
- `executable_` files are made executable (0755)
- `symlink_` creates symbolic links instead of regular files

## Inspiration

These dotfiles were inspired by:

- [Nate Landau's dotfiles](https://github.com/natelandau/dotfiles/tree/master)
- [Daniel M. Schmidt's guide on dev environment setup with Chezmoi](https://danielmschmidt.de/posts/2024-07-28-dev-env-setup-with-chezmoi/)

## Customization

The dotfiles can be customized for different environments by editing the `.chezmoi.toml.tmpl` file. This file contains variables that control which components are installed and how they're configured.

Key customization options include:

- Work vs. personal computer settings
- Optional component installation
- Machine-specific configurations
- Secret management preferences

## Troubleshooting

If you encounter issues:

1. Check the output of `chezmoi doctor` for diagnostic information
2. Run `chezmoi diff` to see what changes would be made
3. For application-specific issues, check the relevant configuration file
