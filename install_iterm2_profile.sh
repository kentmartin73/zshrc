#!/bin/bash

# Comprehensive script to install both the Homebrew theme and a profile with the correct font settings

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Theme and Profile Installer    ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Step 1: Create the Homebrew.itermcolors file
echo -e "${YELLOW}Creating Homebrew.itermcolors file...${NC}"
COLORS_FILE=~/Desktop/Homebrew.itermcolors

cat > "$COLORS_FILE" << 'EOL'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Ansi 0 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Ansi 1 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.73333334922790527</real>
	</dict>
	<key>Ansi 10 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.3333333432674408</real>
		<key>Green Component</key>
		<real>1</real>
		<key>Red Component</key>
		<real>0.3333333432674408</real>
	</dict>
	<key>Ansi 11 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.3333333432674408</real>
		<key>Green Component</key>
		<real>1</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Ansi 12 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>0.3333333432674408</real>
		<key>Red Component</key>
		<real>0.3333333432674408</real>
	</dict>
	<key>Ansi 13 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>0.3333333432674408</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Ansi 14 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>1</real>
		<key>Red Component</key>
		<real>0.3333333432674408</real>
	</dict>
	<key>Ansi 15 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>1</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Ansi 2 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Green Component</key>
		<real>0.73333334922790527</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Ansi 3 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Green Component</key>
		<real>0.73333334922790527</real>
		<key>Red Component</key>
		<real>0.73333334922790527</real>
	</dict>
	<key>Ansi 4 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.73333334922790527</real>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Ansi 5 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.73333334922790527</real>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.73333334922790527</real>
	</dict>
	<key>Ansi 6 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.73333334922790527</real>
		<key>Green Component</key>
		<real>0.73333334922790527</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Ansi 7 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.73333334922790527</real>
		<key>Green Component</key>
		<real>0.73333334922790527</real>
		<key>Red Component</key>
		<real>0.73333334922790527</real>
	</dict>
	<key>Ansi 8 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.3333333432674408</real>
		<key>Green Component</key>
		<real>0.3333333432674408</real>
		<key>Red Component</key>
		<real>0.3333333432674408</real>
	</dict>
	<key>Ansi 9 Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.3333333432674408</real>
		<key>Green Component</key>
		<real>0.3333333432674408</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Background Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Bold Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>1</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Cursor Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.73333334922790527</real>
		<key>Green Component</key>
		<real>0.73333334922790527</real>
		<key>Red Component</key>
		<real>0.73333334922790527</real>
	</dict>
	<key>Cursor Text Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>1</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Foreground Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.73333334922790527</real>
		<key>Green Component</key>
		<real>0.73333334922790527</real>
		<key>Red Component</key>
		<real>0.73333334922790527</real>
	</dict>
	<key>Selected Text Color</key>
	<dict>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Selection Color</key>
	<dict>
		<key>Blue Component</key>
		<real>1</real>
		<key>Green Component</key>
		<real>0.8353000283241272</real>
		<key>Red Component</key>
		<real>0.70980000495910645</real>
	</dict>
</dict>
</plist>
EOL

# Step 2: Install the Homebrew theme
echo -e "${YELLOW}Installing Homebrew theme...${NC}"
open "$COLORS_FILE"
echo -e "Waiting for the theme to be imported..."
sleep 2

# Step 3: Create the profile file
echo -e "${YELLOW}Creating iTerm2 profile file...${NC}"
PROFILE_FILE=~/Desktop/ZshModular.json

cat > "$PROFILE_FILE" << 'EOL'
{
  "Profiles": [
    {
      "Name": "Zsh Modular",
      "Guid": "zsh-modular-profile",
      "Normal Font": "MesloLGSNF-Regular 11",
      "Non Ascii Font": "MesloLGSNF-Regular 11",
      "Use Non-ASCII Font": true,
      "Horizontal Spacing": 1,
      "Vertical Spacing": 1,
      "Use Bold Font": true,
      "Use Bright Bold": true,
      "Use Italic Font": true,
      "Use Ligatures": true,
      "ASCII Anti Aliased": true,
      "Non-ASCII Anti Aliased": true,
      "Ambiguous Double Width": false,
      "Draw Powerline Glyphs": true,
      "Cursor Type": 2,
      "Custom Directory": "No",
      "Background Color": {
        "Red Component": 0.0,
        "Green Component": 0.0,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Foreground Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Bold Color": {
        "Red Component": 1.0,
        "Green Component": 1.0,
        "Blue Component": 1.0,
        "Alpha Component": 1.0
      },
      "Link Color": {
        "Red Component": 0.023,
        "Green Component": 0.391,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Selection Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Selected Text Color": {
        "Red Component": 0.0,
        "Green Component": 0.0,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Cursor Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Cursor Text Color": {
        "Red Component": 0.0,
        "Green Component": 0.0,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Ansi 0 Color": {
        "Red Component": 0.0,
        "Green Component": 0.0,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Ansi 1 Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.0,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Ansi 2 Color": {
        "Red Component": 0.0,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Ansi 3 Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.0,
        "Alpha Component": 1.0
      },
      "Ansi 4 Color": {
        "Red Component": 0.0,
        "Green Component": 0.0,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 5 Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.0,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 6 Color": {
        "Red Component": 0.0,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 7 Color": {
        "Red Component": 0.7333333333333333,
        "Green Component": 0.7333333333333333,
        "Blue Component": 0.7333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 8 Color": {
        "Red Component": 0.3333333333333333,
        "Green Component": 0.3333333333333333,
        "Blue Component": 0.3333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 9 Color": {
        "Red Component": 1.0,
        "Green Component": 0.3333333333333333,
        "Blue Component": 0.3333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 10 Color": {
        "Red Component": 0.3333333333333333,
        "Green Component": 1.0,
        "Blue Component": 0.3333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 11 Color": {
        "Red Component": 1.0,
        "Green Component": 1.0,
        "Blue Component": 0.3333333333333333,
        "Alpha Component": 1.0
      },
      "Ansi 12 Color": {
        "Red Component": 0.3333333333333333,
        "Green Component": 0.3333333333333333,
        "Blue Component": 1.0,
        "Alpha Component": 1.0
      },
      "Ansi 13 Color": {
        "Red Component": 1.0,
        "Green Component": 0.3333333333333333,
        "Blue Component": 1.0,
        "Alpha Component": 1.0
      },
      "Ansi 14 Color": {
        "Red Component": 0.3333333333333333,
        "Green Component": 1.0,
        "Blue Component": 1.0,
        "Alpha Component": 1.0
      },
      "Ansi 15 Color": {
        "Red Component": 1.0,
        "Green Component": 1.0,
        "Blue Component": 1.0,
        "Alpha Component": 1.0
      }
    }
  ]
}
EOL

# Step 4: Close iTerm2 if it's running
echo -e "${YELLOW}Closing iTerm2 if it's running...${NC}"
osascript -e 'tell application "iTerm" to quit' 2>/dev/null || true
sleep 2

# Step 5: Create the Dynamic Profiles directory if it doesn't exist
DYNAMIC_PROFILES_DIR=~/Library/Application\ Support/iTerm2/DynamicProfiles
mkdir -p "$DYNAMIC_PROFILES_DIR"

# Step 6: Copy the profile to the Dynamic Profiles directory
echo -e "${YELLOW}Installing profile to iTerm2 Dynamic Profiles directory...${NC}"
cp "$PROFILE_FILE" "$DYNAMIC_PROFILES_DIR/"

# Step 7: Extract the profile GUID from the JSON file
PROFILE_GUID=$(grep -o '"Guid": "[^"]*"' "$PROFILE_FILE" | cut -d'"' -f4)

# Step 8: Set the profile as the default
echo -e "${YELLOW}Setting profile as default...${NC}"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$PROFILE_GUID"

# Step 9: Force iTerm2 to reload its preferences
killall cfprefsd

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installation Complete!               ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "The Homebrew theme and iTerm2 profile have been installed."
echo -e "The profile has been set as the default."
echo
echo -e "Please restart iTerm2 for the changes to take effect."
echo