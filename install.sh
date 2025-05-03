#!/bin/bash
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/84264bd

# Zsh Modular Configuration Installer
# Version: GitHub Actions (7ccce6b)
# This script installs the modular zsh configuration from GitHub

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if running in iTerm
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    echo -e "${RED}Error: This script cannot be run in iTerm.${NC}"
    echo -e "${RED}iTerm needs to be shut down during the installation process.${NC}"
    echo -e "${RED}Please use another terminal, such as Apple's built-in Terminal app.${NC}"
    exit 1
fi

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

# Handle existing p10k.zsh file
echo -e "${YELLOW}Checking for existing Powerlevel10k configuration...${NC}"
if [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh ]]; then
    echo -e "${YELLOW}Found existing p10k.zsh file. Integrating with modular setup...${NC}"
    # Copy to our directory
    cp ~/.p10k.zsh ~/.zsh/p10k.zsh
    # Backup original
    mv ~/.p10k.zsh ~/.p10k.zsh.backup
    # Create symlink
    ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
    echo -e "${GREEN}Successfully integrated existing Powerlevel10k configuration.${NC}"
    echo -e "${GREEN}Original file backed up to ~/.p10k.zsh.backup${NC}"
elif [[ -f ~/.zsh/p10k.zsh && ! -e ~/.p10k.zsh ]]; then
    # Our version exists but symlink is missing
    echo -e "${YELLOW}Creating symlink for Powerlevel10k configuration...${NC}"
    ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
fi

# Handle existing .aliases file
echo -e "${YELLOW}Checking for existing .aliases file...${NC}"
if [[ -f ~/.aliases && ! -L ~/.aliases ]]; then
    # Backup existing .aliases file
    cp ~/.aliases ~/.aliases.backup
    echo -e "${GREEN}Backed up existing .aliases to ~/.aliases.backup${NC}"
    
    # If it has content, integrate it first
    if [[ -s ~/.aliases ]]; then
        echo -e "${YELLOW}Integrating existing .aliases content with modular setup...${NC}"
        echo -e "\n# Content integrated from ~/.aliases during installation\n" >> ~/.zsh/aliases.zsh
        cat ~/.aliases >> ~/.zsh/aliases.zsh
        echo -e "${GREEN}Integrated .aliases content into ~/.zsh/aliases.zsh${NC}"
    fi
    
    # Remove the original file
    rm ~/.aliases
fi

# Create symlink (always do this, even if there was no existing .aliases file)
echo -e "${YELLOW}Creating symlink from ~/.aliases to ~/.zsh/aliases.zsh...${NC}"
ln -sf ~/.zsh/aliases.zsh ~/.aliases
echo -e "${GREEN}Created symlink: ~/.aliases -> ~/.zsh/aliases.zsh${NC}"

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