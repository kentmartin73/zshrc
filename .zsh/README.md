# Zsh Modular Configuration - User Guide

This guide provides information for using and customizing your Zsh Modular Configuration after installation.

> **⚠️ Important:** If you are connecting from another system (e.g., via SSH), you will still need to install the "MesloLGS Nerd Font" on the system you are connecting from to properly display all Powerlevel10k icons. Download the font from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) or install it via your system's package manager.

## Font Setup in Other Applications

You should set your font to "MesloLGS Nerd Font" in other applications, for example in VS Code:

1. Change the font in VS Code to "MesloLGS Nerd Font" to properly display all Powerlevel10k icons:
   - Open VS Code Settings (Cmd+, on macOS or Ctrl+, on Windows/Linux)
   - Search for "font family"
   - Add "MesloLGS NF" to the beginning of the font family list
   - Example: `"MesloLGS NF", Menlo, Monaco, 'Courier New', monospace`

2. The configuration automatically adds VS Code to your PATH if it's installed in the standard location.

![VS Code Font Setup](images/vscode-font-setup.png)

## Directory Structure

```
.zsh/                # Main configuration directory
├── zshrc            # Main config file (copied to ~/.zsh/zshrc during setup)
├── conf.d/          # Configuration files loaded in numerical order
│   ├── 01-common.zsh       # Common variables and settings
│   ├── 05-performance.zsh  # Performance optimizations
│   ├── 10-options.zsh      # Zsh options and settings
│   ├── 15-history.zsh      # History configuration
│   ├── 20-plugins.zsh      # Plugin management (Antigen)
│   ├── 25-completions.zsh  # Completion settings
│   ├── 30-theme.zsh        # Theme settings (Powerlevel10k)
│   ├── 35-aliases.zsh      # All command aliases
│   ├── 40-functions.zsh    # Custom shell functions
│   ├── 45-macos_setup.zsh  # macOS-specific setup (iTerm2, fonts, etc.)
│   └── 50-local.zsh        # Machine-specific settings (gitignored)
├── lazy/            # Directory for lazy-loaded completions
└── tools.d/         # Tool-specific configurations
```

## Customization

- **Machine-specific settings**: Add your custom settings to `~/.zsh/conf.d/50-local.zsh`
  - This file is gitignored, so your changes won't be overwritten by updates
  - If the file doesn't exist, copy from `50-local.zsh.template`

- **Custom aliases**: Add your personal aliases to `~/.zsh/conf.d/35-aliases.zsh`

- **Custom functions**: Add your shell functions to `~/.zsh/conf.d/40-functions.zsh`

- **Adding new configuration files**: You can add new configuration files to the `~/.zsh/conf.d/` directory

## Configuration Files Numbering Scheme

The configuration files in `~/.zsh/conf.d/` follow this numbering scheme:

- **01-09**: Core system variables and early initialization
- **10-19**: Basic shell options and settings
- **20-29**: Plugin management and completions
- **30-39**: UI/Theme and aliases
- **40-49**: Functions and OS-specific configurations
- **50+**: User customizations and local settings

### How to Add Your Own Configuration Files

To add your own configuration files:

1. Choose an appropriate number based on when you want it to load
2. Create a file with the format `XX-name.zsh` (e.g., `75-custom.zsh`)
3. Add your configuration to the file

### Best Practices

- Keep each file focused on a specific aspect of configuration
- Add comments to explain complex configurations
- When adding new files, consider if they should be loaded before or after existing files
- Use the appropriate number range for your configuration type

## Installed Tools

Your configuration includes these modern command-line tools:

- **dust**: A more intuitive version of `du` (disk usage)
- **lsd**: A modern replacement for `ls` with colors and icons
- **neovim**: An enhanced version of Vim
- **bat**: A `cat` clone with syntax highlighting and Git integration
- **fd**: A simple, fast and user-friendly alternative to `find`
- **duf**: A better `df` alternative with colors and graphs
- **zoxide**: A smarter `cd` command that learns your habits (Note: This is not an Antigen plugin but is initialized separately)

### macOS Specific Tools

If you're using macOS, it's recommended to install GNU coreutils for better compatibility with Linux:

```bash
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
```

The configuration will automatically use these GNU tools if they're installed, providing more consistent behavior across different operating systems.

## Testing Performance

You can test the startup performance of your Zsh configuration:

```bash
# Measure shell startup time
time zsh -i -c exit
```

## Troubleshooting

If you encounter issues with your Zsh configuration:

### Plugin Loading Issues
- Check if Antigen is properly installed
- Verify plugin paths in `~/.zsh/conf.d/20-plugins.zsh`

### Completion Problems
- Clear the completion cache: `rm -rf ~/.zsh/cache/*`
- Regenerate completions: `compinit -d ~/.zcompdump; zcompile ~/.zcompdump`

### Performance Issues
- Use the profiling functions to identify bottlenecks:
  ```bash
  # Add these lines to your .zshrc to enable profiling
  zmodload zsh/zprof
  # At the end of your session, run:
  zprof
  ```
- Consider disabling heavy plugins temporarily

### Powerlevel10k Issues
- Run `p10k configure` to set up the theme
- Verify that the theme is properly loaded in `~/.zsh/conf.d/20-plugins.zsh`

---

# Kent Martin's Zsh Modular Configuration (commit 3af1634) - A comprehensive modular Zsh setup
# Version: commit 3af1634 (https://github.com/kentmartin73/zshrc/commit/3af1634) - Updated: 2025-05-04 12:29:24 UTC
