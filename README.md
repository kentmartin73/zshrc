# Zsh Modular Configuration

A comprehensive modular Zsh setup for improved performance and maintainability.

## Quick Installation

Install the latest release with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/kentmartin73/zshrc/latest/install.sh | bash
```

Install the latest HEAD:

```bash
curl -fsSL https://raw.githubusercontent.com/kentmartin73/zshrc/install.sh | bash
```

**Note:** Do not run the installation script from within iTerm2. The script will modify iTerm2 settings, so it should be run from another terminal like the built-in Terminal app.

## Features

- **Performance Optimizations**: Lazy loading of commands and completions
- **Plugin Management**: Using Antigen with carefully selected plugins
- **Completions**: Comprehensive completion system with lazy loading
- **Theme**: Powerlevel10k with context-aware prompt elements
- **First-Run Setup**: Automatic installation of required utilities
- **macOS Enhancements**: iTerm2 configuration with Homebrew theme and Meslo Nerd Font
- **Modular Organization**: Each aspect of the configuration is in its own file

## Installation (Manual)

```bash
# Clone the repository
git clone https://github.com/kentmartin73/zshrc.git

# Run the installation script
cd zshrc
./install.sh
```

**Note:** Do not run the installation script from within iTerm2. The script will modify iTerm2 settings, so it should be run from another terminal like the built-in Terminal app.

## Directory Structure

```
.zsh/                # Main configuration directory
├── .zshrc           # Main config file (copied to ~/.zshrc during setup)
├── aliases.zsh      # All command aliases
├── functions.zsh    # Custom shell functions
├── plugins.zsh      # Plugin management (Antigen)
├── completions.zsh  # Completion settings
├── lazy/            # Directory for lazy-loaded completions
├── theme.zsh        # Theme settings (Powerlevel10k)
├── history.zsh      # History configuration
├── options.zsh      # Zsh options and settings
├── performance.zsh  # Performance optimizations
├── local.zsh        # Machine-specific settings (gitignored)
├── macos_setup.zsh  # macOS-specific setup (iTerm2, fonts, etc.)
└── tools.d/         # Tool-specific configurations
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
- zoxide (smart cd command)



## Uninstallation

If you need to revert to your previous Zsh configuration or completely uninstall this setup, please refer to the [REVERT.md](REVERT.md) file for detailed instructions.

## Testing and Troubleshooting

### Testing Performance

You can test the startup performance of your Zsh configuration:

```bash
# Measure shell startup time
time zsh -i -c exit
```

### Troubleshooting

If you encounter issues with your Zsh configuration:

1. **Plugin Loading Issues**
   - Check if Antigen is properly installed
   - Verify plugin paths in `plugins.zsh`

2. **Completion Problems**
   - Clear the completion cache: `rm -rf ~/.zsh/cache/*`
   - Regenerate completions: `compinit -d ~/.zcompdump; zcompile ~/.zcompdump`

3. **Performance Issues**
   - Use the profiling functions to identify bottlenecks:
     ```bash
     # Add these lines to your .zshrc to enable profiling
     zmodload zsh/zprof
     # At the end of your session, run:
     zprof
     ```
   - Consider disabling heavy plugins temporarily

4. **Powerlevel10k Issues**
   - Run `p10k configure` to set up the theme
   - Verify that the theme is properly loaded in `plugins.zsh`