#!/bin/bash

# Script to automatically install the iTerm2 profile and set it as default

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Profile Auto Installer        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if the profile file exists
PROFILE_FILE=~/Desktop/ZshModular.json
if [ ! -f "$PROFILE_FILE" ]; then
    echo -e "${RED}Error: Profile file not found at $PROFILE_FILE${NC}"
    echo -e "Please run fix_iterm2.sh first to create the profile file."
    exit 1
fi

# Close iTerm2 if it's running
echo -e "${YELLOW}Closing iTerm2 if it's running...${NC}"
osascript -e 'tell application "iTerm" to quit' 2>/dev/null || true
sleep 2

# Create the Dynamic Profiles directory if it doesn't exist
DYNAMIC_PROFILES_DIR=~/Library/Application\ Support/iTerm2/DynamicProfiles
mkdir -p "$DYNAMIC_PROFILES_DIR"

# Copy the profile to the Dynamic Profiles directory
echo -e "${YELLOW}Installing profile to iTerm2 Dynamic Profiles directory...${NC}"
cp "$PROFILE_FILE" "$DYNAMIC_PROFILES_DIR/"

# Extract the profile GUID from the JSON file
PROFILE_GUID=$(grep -o '"Guid": "[^"]*"' "$PROFILE_FILE" | cut -d'"' -f4)

if [ -z "$PROFILE_GUID" ]; then
    echo -e "${RED}Error: Could not extract profile GUID from the JSON file.${NC}"
    exit 1
fi

# Set the profile as the default
echo -e "${YELLOW}Setting profile as default...${NC}"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$PROFILE_GUID"

# Force iTerm2 to reload its preferences
killall cfprefsd

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Profile Installation Complete!       ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "The iTerm2 profile has been installed and set as the default."
echo -e "Please restart iTerm2 for the changes to take effect."
echo