#!/bin/bash

# Script to provide instructions for manually setting the Homebrew color preset in iTerm2

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Color Preset Instructions      ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Create a text file with instructions
INSTRUCTIONS_FILE=~/Desktop/iTerm2_Color_Instructions.txt
echo -e "${YELLOW}Creating instructions file at ${INSTRUCTIONS_FILE}...${NC}"

cat > "$INSTRUCTIONS_FILE" << 'EOL'
# iTerm2 Color Preset Instructions

Follow these steps to apply the Homebrew color preset to your iTerm2 profile:

## Step 1: Open iTerm2 Preferences
1. Open iTerm2
2. Go to Preferences (⌘,)

## Step 2: Navigate to Your Profile's Colors Tab
1. Click on the "Profiles" tab
2. Select your "Zsh Modular" profile in the list on the left
3. Click on the "Colors" tab on the right

## Step 3: Apply the Homebrew Color Preset
1. Click on the "Color Presets..." dropdown in the bottom right
2. Select "Homebrew" from the list
3. If "Homebrew" is not in the list, you may need to import it:
   a. Click on "Import..." in the dropdown
   b. Navigate to ~/Desktop/Homebrew.itermcolors (if it exists)
   c. If the file doesn't exist, you can download it from:
      https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Homebrew.itermcolors

## Step 4: Save and Close
1. Click "Close" to save your changes
2. Restart iTerm2 for the changes to take effect

## Alternative: Use the Default "Dark Background" Preset
If you can't find the Homebrew preset, you can use the built-in "Dark Background" preset:
1. Click on the "Color Presets..." dropdown
2. Select "Dark Background" from the list
EOL

# Create the Homebrew.itermcolors file on the Desktop
echo -e "${YELLOW}Creating Homebrew.itermcolors file on the Desktop...${NC}"
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

# Open the instructions file
open "$INSTRUCTIONS_FILE"

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Instructions Created!                ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "Instructions have been created at: ${YELLOW}${INSTRUCTIONS_FILE}${NC}"
echo -e "The Homebrew color preset file has been created at: ${YELLOW}${COLORS_FILE}${NC}"
echo
echo -e "Please follow the instructions to manually set the Homebrew color preset."
echo