#!/bin/bash

# Script to fix iTerm2 configuration and set Meslo Nerd Font

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Font Configuration Fix         ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if Meslo Nerd Font is installed
if ! ls ~/Library/Fonts/Meslo*Nerd*Font* &>/dev/null; then
    echo -e "${YELLOW}Installing Meslo Nerd Font...${NC}"
    brew tap homebrew/cask-fonts
    brew install --cask font-meslo-lg-nerd-font
fi

echo -e "${YELLOW}Closing iTerm2 if it's running...${NC}"
osascript -e 'tell application "iTerm" to quit' 2>/dev/null || true
sleep 2

echo -e "${YELLOW}Setting up iTerm2 configuration...${NC}"

# Create a direct configuration file for iTerm2
ITERM_CONFIG_DIR=~/Library/Application\ Support/iTerm2/DynamicProfiles
mkdir -p "$ITERM_CONFIG_DIR"

cat > "$ITERM_CONFIG_DIR/zsh-modular.json" << 'EOL'
{
  "Profiles": [
    {
      "Name": "Zsh Modular",
      "Guid": "zsh-modular-profile",
      "Normal Font": "MesloLGSNerdFontComplete-Regular 12",
      "Non Ascii Font": "MesloLGSNerdFontComplete-Regular 12",
      "Use Non-ASCII Font": true,
      "Horizontal Spacing": 1,
      "Vertical Spacing": 1,
      "Use Bold Font": true,
      "Use Bright Bold": true,
      "Use Italic Font": true,
      "ASCII Anti Aliased": true,
      "Non-ASCII Anti Aliased": true,
      "Ambiguous Double Width": false,
      "Draw Powerline Glyphs": true,
      "Cursor Type": 2,
      "Cursor Text Color": {
        "Red Component": 0,
        "Green Component": 0,
        "Blue Component": 0
      },
      "Cursor Color": {
        "Red Component": 0.73333334922790527,
        "Green Component": 0.73333334922790527,
        "Blue Component": 0.73333334922790527
      },
      "Background Color": {
        "Red Component": 0,
        "Green Component": 0,
        "Blue Component": 0
      },
      "Foreground Color": {
        "Red Component": 0.73333334922790527,
        "Green Component": 0.73333334922790527,
        "Blue Component": 0.73333334922790527
      },
      "Selected Text Color": {
        "Red Component": 0,
        "Green Component": 0,
        "Blue Component": 0
      },
      "Selection Color": {
        "Red Component": 0.73333334922790527,
        "Green Component": 0.73333334922790527,
        "Blue Component": 0.73333334922790527
      },
      "Dynamic Profile Filename": "~/Library/Application Support/iTerm2/DynamicProfiles/zsh-modular.json"
    }
  ]
}
EOL

# Set the Zsh Modular profile as the default
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "zsh-modular-profile"

# Create a script to directly modify the iTerm2 preferences
DIRECT_SCRIPT=$(mktemp)
cat > "$DIRECT_SCRIPT" << 'EOL'
#!/usr/bin/osascript

tell application "iTerm"
  create window with default profile
  tell current session of current window
    set font name to "MesloLGSNerdFontComplete-Regular"
    set font size to 12
    set non ascii font to "MesloLGSNerdFontComplete-Regular"
    set non ascii font size to 12
  end tell
end tell
EOL

chmod +x "$DIRECT_SCRIPT"

# Force iTerm2 to reload its preferences
killall cfprefsd

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Configuration Complete!        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "A new profile called ${YELLOW}Zsh Modular${NC} has been created with the correct font."
echo -e "This profile has been set as the default profile."
echo
echo -e "To verify the changes:"
echo -e "1. Start iTerm2"
echo -e "2. Go to Preferences > Profiles"
echo -e "3. You should see 'Zsh Modular' profile selected as default"
echo -e "4. Check that the font is set to 'MesloLGSNerdFontComplete-Regular'"
echo
echo -e "If the font is still not set correctly, you can run this script again."
echo -e "Alternatively, you can manually set the font in iTerm2 preferences:"
echo -e "1. Go to Preferences > Profiles > Text"
echo -e "2. Change the font to 'MesloLGSNerdFontComplete-Regular'"
echo

# Create a direct AppleScript to set the font
cat > ~/set_iterm_font.scpt << 'EOL'
tell application "iTerm"
  tell current session of current window
    set font name to "MesloLGSNerdFontComplete-Regular"
    set font size to 12
    set non ascii font to "MesloLGSNerdFontComplete-Regular"
    set non ascii font size to 12
  end tell
end tell
EOL

echo -e "You can also run this command to set the font for the current session:"
echo -e "${YELLOW}osascript ~/set_iterm_font.scpt${NC}"