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

# Download and install the Homebrew theme for iTerm2
echo "Installing Homebrew theme for iTerm2..."

# Create temporary directory for theme files
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Clone the iTerm2-Color-Schemes repository to get the Homebrew theme
git clone --depth=1 https://github.com/mbadolato/iTerm2-Color-Schemes.git
cd iTerm2-Color-Schemes

# Install the Homebrew theme
open "schemes/Homebrew.itermcolors"

# Wait a moment for the theme to be imported
sleep 2

# Create a temporary script to configure iTerm2
ITERM_CONFIG_SCRIPT=$(mktemp)
cat > "$ITERM_CONFIG_SCRIPT" << 'EOL'
#!/bin/bash

# Script to configure iTerm2 with Homebrew theme and Meslo font

# Set the default profile to use Homebrew theme
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "Homebrew"

# Set the font to Meslo Nerd Font
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Normal Font' 'MesloLGSNerdFontComplete-Regular 12'" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Non Ascii Font' 'MesloLGSNerdFontComplete-Regular 12'" ~/Library/Preferences/com.googlecode.iterm2.plist

echo "iTerm2 configured with Homebrew theme and Meslo Nerd Font."
echo "Please restart iTerm2 for changes to take effect."
EOL

# Make the script executable
chmod +x "$ITERM_CONFIG_SCRIPT"

# Run the configuration script
echo "Configuring iTerm2 automatically..."
"$ITERM_CONFIG_SCRIPT"

# Clean up
rm -f "$ITERM_CONFIG_SCRIPT"
cd
rm -rf "$TEMP_DIR"

echo "iTerm2 has been configured with Homebrew theme and Meslo Nerd Font."
echo "Please restart iTerm2 for changes to take effect."