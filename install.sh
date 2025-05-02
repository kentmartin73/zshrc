#!/bin/bash
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/c901471
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/84264bd

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

# Install required tools
echo -e "${YELLOW}Installing required tools...${NC}"
cd "$TEMP_DIR" || {
    echo -e "${RED}Error: Failed to navigate to the cloned repository.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

./install_tools.sh || {
    echo -e "${RED}Error: Failed to install required tools.${NC}"
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

# Make the setup script executable
chmod +x ./setup.sh

./setup.sh || {
    echo -e "${RED}Error: Failed to run the setup script.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Create marker file to indicate setup is complete
touch ~/.zsh/.setup_complete

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