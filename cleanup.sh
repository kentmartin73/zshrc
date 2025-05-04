#!/bin/bash

# Cleanup script to remove files that are no longer needed after installation
# This script should be run after the installation is complete
# It will also delete itself when finished

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Cleaning up installation files        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# This script should only be run from the repository directory
# It should not delete any files in the user's home directory except within ~/.zsh

# Get the current directory (should be the repository directory)
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e "${YELLOW}Running from repository directory: $REPO_DIR${NC}"

# Files to remove in the repository directory
echo -e "${YELLOW}Removing installation scripts...${NC}"
rm -f "$REPO_DIR/install.sh" 2>/dev/null
rm -f "$REPO_DIR/install_tools.sh" 2>/dev/null
rm -f "$REPO_DIR/configure_iterm2.sh" 2>/dev/null
rm -f "$REPO_DIR/iterm2_profile.json" 2>/dev/null

# Note: We've moved all images to .zsh/images, so there's no top-level images directory to remove

# Remove GitHub workflows directory (only needed for development)
if [[ -d "$REPO_DIR/.github" ]]; then
  echo -e "${YELLOW}Removing GitHub workflows directory...${NC}"
  rm -rf "$REPO_DIR/.github" 2>/dev/null
fi

# Note: Temporary scripts (move_to_confd.sh and remove_old_files.sh) have already been removed

# Note: We're keeping REVERT.md as it might be useful for reference

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Cleanup Complete!                    ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "The following files have been kept for reference:"
echo -e "  - REVERT.md (instructions for reverting changes)"
echo

# Delete this script only if it's the cleanup.sh script
echo -e "${YELLOW}Deleting cleanup script...${NC}"
if [[ "$(basename "$0")" == "cleanup.sh" ]]; then
  rm -f "$0"
else
  echo -e "${RED}Warning: Script filename is not cleanup.sh, skipping self-deletion for safety${NC}"
fi