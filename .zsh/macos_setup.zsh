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

# Make sure the preferences are loaded
defaults read com.googlecode.iterm2 > /dev/null

# Get the GUID of the Default profile
DEFAULT_PROFILE_GUID=$(defaults read com.googlecode.iterm2 "Default Bookmark Guid")

# Set the font for the Default profile
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Normal Font' 'MesloLGSNerdFontComplete-Regular 12'" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Non Ascii Font' 'MesloLGSNerdFontComplete-Regular 12'" ~/Library/Preferences/com.googlecode.iterm2.plist

# Set the color preset for the Default profile
# First, get the name of the Default profile
DEFAULT_PROFILE_NAME=$(/usr/libexec/PlistBuddy -c "Print 'New Bookmarks':0:'Name'" ~/Library/Preferences/com.googlecode.iterm2.plist)

# Use osascript to set the color preset
osascript <<EOF
tell application "iTerm2"
    tell current terminal
        tell session id "Default"
            set profile name to "$DEFAULT_PROFILE_NAME"
            set background color to {0, 0, 0}
            set normal text color to {255, 255, 255}
            set bold color to {255, 255, 255}
            set selection color to {64, 64, 64}
            set cursor color to {255, 255, 255}
            set cursor text color to {0, 0, 0}
        end tell
    end tell
end tell
EOF

# Force iTerm2 to save its preferences
killall cfprefsd

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

# Create a more direct approach to set the font
cat > ~/set_iterm_font.sh << 'EOL'
#!/bin/bash

# This script sets the font for iTerm2 to MesloLGSNerdFontComplete-Regular
# Run this script if the font is not set correctly after installation

# Kill iTerm2 if it's running
killall iTerm2 2>/dev/null

# Wait a moment for iTerm2 to fully close
sleep 1

# Set the font for the Default profile
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Normal Font' 'MesloLGSNerdFontComplete-Regular 12'" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Non Ascii Font' 'MesloLGSNerdFontComplete-Regular 12'" ~/Library/Preferences/com.googlecode.iterm2.plist

# Force iTerm2 to reload its preferences
killall cfprefsd

echo "Font set to MesloLGSNerdFontComplete-Regular."
echo "Please start iTerm2 again."
EOL

chmod +x ~/set_iterm_font.sh

echo "If the font is not set correctly after installation, run ~/set_iterm_font.sh"