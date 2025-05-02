#!/bin/bash

# Script to use the complete iTerm2 profile from the repository

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROFILE_PATH="$SCRIPT_DIR/iterm2_profile.json"

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Complete Profile Installer     ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if the profile file exists
if [ ! -f "$PROFILE_PATH" ]; then
    echo -e "${RED}Error: Profile file not found at $PROFILE_PATH${NC}"
    exit 1
fi

# Close iTerm2 if it's running
echo -e "${YELLOW}Closing iTerm2 if it's running...${NC}"
osascript -e 'tell application "iTerm" to quit' 2>/dev/null || true
sleep 2

# Create a modified version of the profile with a specific GUID
echo -e "${YELLOW}Creating a modified profile with a specific GUID...${NC}"
TEMP_PROFILE=$(mktemp)
PROFILE_GUID="zsh-modular-profile-guid"

# Add the GUID to the profile
cat "$PROFILE_PATH" | sed 's/"Guid" *: *"[^"]*"/"Guid": "'"$PROFILE_GUID"'"/' > "$TEMP_PROFILE"

# Create the Dynamic Profiles directory if it doesn't exist
DYNAMIC_PROFILES_DIR=~/Library/Application\ Support/iTerm2/DynamicProfiles
mkdir -p "$DYNAMIC_PROFILES_DIR"

# Copy the profile to the Dynamic Profiles directory
echo -e "${YELLOW}Installing profile to iTerm2 Dynamic Profiles directory...${NC}"
cp "$TEMP_PROFILE" "$DYNAMIC_PROFILES_DIR/ZshModular.json"

# Set the profile as the default
echo -e "${YELLOW}Setting profile as default...${NC}"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$PROFILE_GUID"

# Force iTerm2 to reload its preferences
killall cfprefsd

# Clean up
rm -f "$TEMP_PROFILE"

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installation Complete!               ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "The complete iTerm2 profile has been installed from $PROFILE_PATH."
echo -e "The profile has been set as the default with GUID: ${YELLOW}$PROFILE_GUID${NC}"
echo
echo -e "Please restart iTerm2 for the changes to take effect."
echo -e "If the profile is still not set as default, you can manually set it:"
echo -e "1. Open iTerm2 Preferences (⌘,)"
echo -e "2. Go to Profiles"
echo -e "3. Select the profile"
echo -e "4. Click 'Other Actions...' > 'Set as Default'"
echo