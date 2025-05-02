# Zsh Modular Configuration

This repository contains a comprehensive modular Zsh configuration designed for improved performance, maintainability, and extensibility.

## Overview

The configuration is organized into modular files, each responsible for a specific aspect of the Zsh environment. This approach makes it easier to understand, maintain, and customize your shell configuration.

## Features

- **Modular Organization**: Each aspect of the configuration is in its own file
- **Performance Optimizations**: Lazy loading of commands and completions
- **Plugin Management**: Using Antigen with carefully selected plugins
- **Completions**: Comprehensive completion system with lazy loading
- **Theme**: Powerlevel10k with context-aware prompt elements
- **First-Run Setup**: Automatic installation of required utilities
- **macOS Enhancements**: iTerm2 configuration with Homebrew theme and Meslo Nerd Font

## Installation

### Quick Installation (Recommended)

Install with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/kentmartin73/zshrc/main/install.sh | bash
```

This will:
1. Clone the repository
2. Run the setup script
3. Clean up temporary files

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kentmartin73/zshrc.git
   ```
2. Run the setup script:
   ```bash
   cd zshrc/.zsh
   ./setup.sh
   ```
3. Start a new shell session

## Directory Structure

```
zshrc/
├── .zsh/                # Main configuration directory
│   ├── .zshrc           # Main config file (copied to ~/.zshrc during setup)
│   ├── aliases.zsh      # All command aliases
│   ├── functions.zsh    # Custom shell functions
│   ├── plugins.zsh      # Plugin management (Antigen)
│   ├── completions.zsh  # Completion settings
│   ├── lazy/            # Directory for lazy-loaded completions
│   ├── theme.zsh        # Theme settings (Powerlevel10k)
│   ├── history.zsh      # History configuration
│   ├── options.zsh      # Zsh options and settings
│   ├── performance.zsh  # Performance optimizations
│   ├── local.zsh        # Machine-specific settings (gitignored)
│   ├── macos_setup.zsh  # macOS-specific setup (iTerm2, fonts, etc.)
│   └── setup.sh         # Setup script to install the configuration
├── .alias               # Original alias file (for reference)
├── .gitignore           # Git ignore file
├── .zshrc               # Original zshrc file (for reference)
├── install.sh           # One-line installation script
├── fix_iterm2.sh        # Script to fix iTerm2 font configuration
└── README.md            # This documentation file
```

## Customization

- Machine-specific settings can be added to `~/.zsh/local.zsh` (copy from `local.zsh.template`)
- Custom aliases can be added to `~/.zsh/aliases.zsh`
- Custom functions can be added to `~/.zsh/functions.zsh`

## Requirements

- Zsh (version 5.0 or later recommended)
- Git (for initial setup and plugin management)
- Antigen (for plugin management)

## Optional Tools

The configuration will attempt to install these tools on first run:

- dust (modern replacement for du)
- lsd (modern replacement for ls)
- neovim (modern vim)
- bat (modern replacement for cat)
- fd (modern replacement for find)
- duf (modern replacement for df)

## Troubleshooting

### iTerm2 Font Issues

If you're using iTerm2 and the Powerlevel10k theme doesn't display correctly (missing icons or incorrect font), run the included fix script:

```bash
./fix_iterm2.sh
```

This script will:
1. Install the Meslo Nerd Font if it's not already installed
2. Create a new iTerm2 profile with the correct font settings
3. Set this profile as the default

After running the script, restart iTerm2 for the changes to take effect.

## License

This configuration is available under the MIT License.