# Reverting Zsh Modular Configuration

> **⚠️ WARNING: These uninstallation instructions have never been tested. Use at your own risk and consider backing up your system before proceeding.**

This document provides instructions on how to revert or uninstall the Zsh Modular Configuration from your system.

## Simple Reversion

If you want to revert to your previous Zsh configuration:

1. Restore your backup files (created during installation):

```bash
# Find your backup directory (replace TIMESTAMP with the actual timestamp)
ls -la ~/.zsh_backup_*

# Restore your previous .zshrc
cp ~/.zsh_backup_TIMESTAMP/.zshrc ~/
```

2. Remove the modular configuration:

```bash
# Remove the .zsh directory
rm -rf ~/.zsh
```

## Complete Uninstallation

If you want to completely remove the Zsh Modular Configuration and all installed tools:

1. Restore your backup files as described above.

2. Remove the modular configuration:

```bash
# Remove the .zsh directory
rm -rf ~/.zsh
```

3. Remove Antigen:

```bash
# If installed via Homebrew
brew uninstall antigen

# If installed manually
rm -rf ~/.antigen
```

4. Optionally remove installed tools (if you don't use them elsewhere):

```bash
# macOS
brew uninstall dust lsd neovim bat fd duf pyenv zoxide

# Debian/Ubuntu
sudo apt remove dust lsd neovim bat fd-find duf zoxide

# Fedora
sudo dnf remove dust lsd neovim bat fd duf zoxide

# Arch Linux
sudo pacman -R dust lsd neovim bat fd duf zoxide
```

5. Remove iTerm2 configuration (if you want to revert iTerm2 settings):

```bash
# Reset iTerm2 preferences
defaults delete com.googlecode.iterm2
```

## Keeping Some Components

If you want to keep some components of the configuration:

1. Copy specific files you want to keep:

```bash
# Example: Keep your aliases
cp ~/.zsh/aliases.zsh ~/my_aliases.zsh
```

2. Incorporate them into your own configuration:

```bash
# Add to your .zshrc
echo "source ~/my_aliases.zsh" >> ~/.zshrc
```

## Troubleshooting

If you encounter issues after reverting:

1. Start a new shell session:

```bash
exec zsh
```

2. Check for any remaining configuration files:

```bash
find ~/ -name "*zsh*" -type f
```

3. Ensure your PATH doesn't contain references to the removed configuration:

```bash
echo $PATH