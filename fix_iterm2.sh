#!/bin/bash

# Script to fix iTerm2 font configuration by using the complete profile

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Configuration Fix             ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Run the use_complete_profile.sh script
echo -e "${YELLOW}Installing the complete iTerm2 profile...${NC}"
"$SCRIPT_DIR/use_complete_profile.sh"

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Configuration Complete!        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "The iTerm2 profile has been installed with the correct font and color settings."
echo -e "Please restart iTerm2 for the changes to take effect."
echo