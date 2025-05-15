# Dotfiles with Chezmoi

This repository contains my personal dotfiles managed using [Chezmoi](https://www.chezmoi.io/), a dotfile manager that helps you synchronize your dotfiles across multiple machines securely.

## Overview

These dotfiles include configurations for:
hello

- Zsh shell configuration
- Git configuration
- Editor settings (Zed)
- Terminal configuration (Ghostty)
- And more

## Features

- Cross-platform support (macOS, Linux)
- Secret management with Bitwarden
- Conditional configurations for personal and work machines
- Automated dependency installation

## Prerequisites

- [Chezmoi](https://www.chezmoi.io/install/)
- For secrets management: [Bitwarden CLI](https://bitwarden.com/help/article/cli/) (optional)
- Git

## Getting Started

### Installation

```bash
# Install Chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply oskar-dragon
```

### Update

To update your dotfiles on any machine, run:

```bash
chezmoi update
```

## Structure

- `.chezmoi.toml.tmpl`: Template for Chezmoi configuration
- `.chezmoiscripts`: Scripts that run during installation
- `.chezmoitemplates`: Template files used across multiple dotfiles
- `dot_*`: Dotfiles for various applications

## License

MIT
