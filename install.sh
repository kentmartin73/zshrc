#!/bin/bash
# Zsh Modular Configuration Installer

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

# Check if running in iTerm
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    echo -e "${RED}Error: This script cannot be run in iTerm.${NC}"
    echo -e "${RED}Please use another terminal, such as Apple's built-in Terminal app.${NC}"
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed.${NC}"
    echo -e "${YELLOW}Please install Git using your package manager.${NC}"
    exit 1
fi

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Error: Zsh is not installed.${NC}"
    echo -e "${YELLOW}Please install Zsh using your package manager.${NC}"
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo -e "${YELLOW}Creating temporary directory...${NC}"

# Clone the repository
echo -e "${YELLOW}Cloning the repository...${NC}"
if ! git clone --depth 1 https://github.com/kentmartin73/zshrc.git "$TEMP_DIR"; then
    echo -e "${RED}Error: Failed to clone the repository.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Install required tools
echo -e "${YELLOW}Installing required tools...${NC}"
if [ -f "$TEMP_DIR/install_tools.sh" ]; then
    chmod +x "$TEMP_DIR/install_tools.sh"
    (cd "$TEMP_DIR" && ./install_tools.sh)
else
    echo -e "${YELLOW}No tools installation script found, skipping...${NC}"
fi

# Run the setup script
echo -e "${YELLOW}Running the setup script...${NC}"
if [ -f "$TEMP_DIR/setup.sh" ]; then
    chmod +x "$TEMP_DIR/setup.sh"
    "$TEMP_DIR/setup.sh"
else
    echo -e "${RED}Error: setup.sh not found.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Clean up the repository
echo -e "${YELLOW}Cleaning up repository...${NC}"
rm -rf "$TEMP_DIR" && echo -e "${GREEN}Repository removed successfully.${NC}"

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

# Add note about fonts
echo -e "${YELLOW}Note: For best results, install MesloLGS Nerd Font on your system.${NC}"
echo