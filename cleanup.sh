#!/bin/bash
# Cleanup script to remove installation files

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Cleaning up installation files        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Get the current directory
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e "${YELLOW}Running from directory: $REPO_DIR${NC}"

# Remove installation files
echo -e "${YELLOW}Removing installation files...${NC}"
rm -f "$REPO_DIR/install.sh"
rm -f "$REPO_DIR/install_tools.sh"
rm -f "$REPO_DIR/configure_iterm2.sh"
rm -f "$REPO_DIR/iterm2_profile.json"
rm -f "$REPO_DIR/setup.sh"

# Remove GitHub workflows directory if it exists
[ -d "$REPO_DIR/.github" ] && rm -rf "$REPO_DIR/.github"

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Cleanup Complete!                    ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "The following files have been kept for reference:"
echo -e "  - REVERT.md (instructions for reverting changes)"
echo

# Self-delete
echo -e "${YELLOW}Deleting cleanup script...${NC}"
rm -f "$0"