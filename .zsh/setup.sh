#!/bin/bash
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/c901471
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/84264bd

# Setup script for modular zsh configuration

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Automatically detect the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ZSH_CONFIG_DIR="$SCRIPT_DIR"
USER_ZSH_DIR="$HOME/.zsh"

# Print header
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Modular Zsh Configuration Setup       ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Error: Zsh is not installed. Please install Zsh first.${NC}"
    exit 1
fi

# Backup existing configuration
echo -e "${YELLOW}Backing up existing configuration...${NC}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/.zsh_backup_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$BACKUP_DIR/"
    echo -e "  - Backed up .zshrc to $BACKUP_DIR/.zshrc"
fi

if [ -f "$HOME/.p10k.zsh" ]; then
    cp "$HOME/.p10k.zsh" "$BACKUP_DIR/"
    echo -e "  - Backed up .p10k.zsh to $BACKUP_DIR/.p10k.zsh"
fi

if [ -f "$HOME/.alias" ]; then
    cp "$HOME/.alias" "$BACKUP_DIR/"
    echo -e "  - Backed up .alias to $BACKUP_DIR/.alias"
fi

# Create .zsh directory if it doesn't exist
echo -e "${YELLOW}Setting up .zsh directory...${NC}"
mkdir -p "$USER_ZSH_DIR/lazy"
mkdir -p "$USER_ZSH_DIR/cache"

# Copy configuration files
echo -e "${YELLOW}Copying configuration files...${NC}"
cp -r "$ZSH_CONFIG_DIR"/* "$USER_ZSH_DIR/"
cp "$ZSH_CONFIG_DIR/.gitignore" "$USER_ZSH_DIR/" 2>/dev/null || true
cp "$ZSH_CONFIG_DIR/.zshrc" "$HOME/.zshrc"
echo -e "  - Copied configuration files to $USER_ZSH_DIR"
echo -e "  - Copied .zshrc to $HOME/.zshrc"

# Create local.zsh from template if it doesn't exist
if [ ! -f "$USER_ZSH_DIR/local.zsh" ]; then
    echo -e "${YELLOW}Creating local.zsh from template...${NC}"
    cp "$USER_ZSH_DIR/local.zsh.template" "$USER_ZSH_DIR/local.zsh"
    echo -e "  - Created local.zsh from template"
fi

# Initialize git repository if git is available
if command -v git &> /dev/null; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    cd "$USER_ZSH_DIR"
    
    # Check if it's already a git repository
    if [ ! -d ".git" ]; then
        git init
        git add .
        git commit -m "Initial commit of modular zsh configuration"
        echo -e "  - Initialized git repository in $USER_ZSH_DIR"
    else
        echo -e "  - Git repository already exists in $USER_ZSH_DIR"
    fi
fi

# Note: We're intentionally NOT creating the .setup_complete marker file here
# so that the first-run installation will happen when the user starts a new shell

# Final instructions
echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Setup Complete!                       ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "To start using your new zsh configuration:"
echo -e "  1. Start a new zsh session: ${YELLOW}exec zsh${NC}"
echo -e "  2. Customize your local settings in: ${YELLOW}~/.zsh/local.zsh${NC}"
echo
echo -e "Your previous configuration has been backed up to: ${YELLOW}$BACKUP_DIR${NC}"
echo
echo -e "${YELLOW}Note: In any application that you use a shell (e.g. VS Code), you shoukd change the font to \"MesloLGS Nerd Font\"${NC}"
echo