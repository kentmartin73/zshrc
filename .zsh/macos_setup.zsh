# macOS-specific setup for iTerm2, fonts, and themes
# This file is only sourced during first-run setup on macOS

echo "Setting up macOS enhancements..."

# Install iTerm2
if ! brew list --cask iterm2 &>/dev/null; then
  echo "Installing iTerm2..."
  brew install --cask iterm2
fi

# Install Meslo Nerd Font (recommended for Powerlevel10k)
if ! brew list --cask font-meslo-lg-nerd-font &>/dev/null; then
  echo "Installing Meslo Nerd Font..."
  brew tap homebrew/cask-fonts
  brew install --cask font-meslo-lg-nerd-font
fi

# Get the directory of the zsh configuration
ZSH_DIR="${0:a:h}"
REPO_DIR="${ZSH_DIR:h}"
FIX_ITERM2_SCRIPT="${REPO_DIR}/fix_iterm2.sh"

# Check if the script exists
if [[ -f "$FIX_ITERM2_SCRIPT" ]]; then
  # Run the fix_iterm2.sh script to configure iTerm2
  echo "Configuring iTerm2..."
  "$FIX_ITERM2_SCRIPT"
  
  echo "iTerm2 has been configured with the correct font and theme."
  echo "Please restart iTerm2 for changes to take effect."
else
  echo "Warning: Could not find fix_iterm2.sh script at $FIX_ITERM2_SCRIPT"
  echo "iTerm2 configuration skipped."
fi