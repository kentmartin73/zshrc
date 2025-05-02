#!/bin/bash

# Zsh Modular Configuration Installer
# This script installs the modular zsh configuration from GitHub

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Zsh Modular Configuration Installer   ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git first.${NC}"
    exit 1
fi

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Error: Zsh is not installed. Please install Zsh first.${NC}"
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo -e "${YELLOW}Creating temporary directory...${NC}"

# Clone the repository
echo -e "${YELLOW}Cloning the repository...${NC}"
git clone https://github.com/kentmartin73/zshrc.git "$TEMP_DIR" || {
    echo -e "${RED}Error: Failed to clone the repository.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Run the setup script
echo -e "${YELLOW}Running the setup script...${NC}"
cd "$TEMP_DIR/.zsh" || {
    echo -e "${RED}Error: Failed to navigate to the .zsh directory.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

./setup.sh || {
    echo -e "${RED}Error: Failed to run the setup script.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Clean up
echo -e "${YELLOW}Cleaning up...${NC}"
cd
rm -rf "$TEMP_DIR"

# Print success message
echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installation Complete!                ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "To start using your new zsh configuration:"
echo -e "  1. Start a new zsh session: ${YELLOW}exec zsh${NC}"
echo -e "  2. Customize your local settings in: ${YELLOW}~/.zsh/local.zsh${NC}"
echo
echo -e "${YELLOW}Note: The first time you start a new shell, the configuration will install required utilities like iTerm2, dust, lsd, etc.${NC}"
echo