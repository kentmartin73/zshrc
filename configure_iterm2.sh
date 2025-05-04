#!/bin/bash
# Simple script to configure iTerm2 with the profile from the repository

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROFILE_PATH="$SCRIPT_DIR/iterm2_profile.json"

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Configuration Tool            ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed.${NC}"
    exit 1
fi

# Check if the profile file exists
if [ ! -f "$PROFILE_PATH" ]; then
    echo -e "${RED}Error: Profile file not found.${NC}"
    exit 1
fi

# Close iTerm2 if it's running
echo -e "${YELLOW}Closing iTerm2 if it's running...${NC}"
osascript -e 'tell application "iTerm" to quit' 2>/dev/null || true
sleep 1

# Install the profile
echo -e "${YELLOW}Installing iTerm2 profile...${NC}"
PROFILE_GUID="zsh-modular-profile-guid"
DYNAMIC_PROFILES_DIR=~/Library/Application\ Support/iTerm2/DynamicProfiles
mkdir -p "$DYNAMIC_PROFILES_DIR"

# Create profile with specific GUID
sed 's/"Guid" *: *"[^"]*"/"Guid": "'"$PROFILE_GUID"'"/' "$PROFILE_PATH" > "$DYNAMIC_PROFILES_DIR/ZshModular.json"

# Set as default profile
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$PROFILE_GUID"

# Force reload preferences
killall cfprefsd 2>/dev/null || true

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Configuration Complete!        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "Please restart iTerm2 for the changes to take effect."
echo