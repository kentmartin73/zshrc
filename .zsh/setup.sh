#!/bin/bash
# Simplified setup script for modular zsh configuration

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

# Create backup directory
echo -e "${YELLOW}Backing up existing configuration...${NC}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/.zsh_backup_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
BACKED_UP_FILES=()

# Backup existing files
backup_file() {
    local file="$1"
    if [ -e "$file" ]; then
        local basename=$(basename "$file")
        cp -r "$file" "$BACKUP_DIR/"
        BACKED_UP_FILES+=("$basename")
        echo -e "  - Backed up $basename"
    fi
}

# Backup key files
backup_file "$HOME/.zshrc"
backup_file "$HOME/.p10k.zsh"
backup_file "$HOME/.aliases"
[ -d "$HOME/.zsh" ] && backup_file "$HOME/.zsh"

# Create .zsh directory structure
echo -e "${YELLOW}Setting up .zsh directory...${NC}"
mkdir -p "$USER_ZSH_DIR/conf.d"
mkdir -p "$USER_ZSH_DIR/lazy"
mkdir -p "$USER_ZSH_DIR/cache"

# Create .antigen directory
echo -e "${YELLOW}Setting up .antigen directory...${NC}"
mkdir -p "$HOME/.antigen"

# Copy configuration files
echo -e "${YELLOW}Copying configuration files...${NC}"
cp -r "$ZSH_CONFIG_DIR"/* "$USER_ZSH_DIR/"
cp "$ZSH_CONFIG_DIR/.gitignore" "$USER_ZSH_DIR/" 2>/dev/null || true

# Copy the top-level .zshrc to the user's home directory
cp "$(dirname "$ZSH_CONFIG_DIR")/.zshrc" "$HOME/.zshrc"
echo -e "  - Copied configuration files to $USER_ZSH_DIR"
echo -e "  - Copied top-level .zshrc to $HOME/.zshrc"

# Create symlinks
echo -e "${YELLOW}Creating symlinks...${NC}"
ln -sf "$USER_ZSH_DIR/conf.d/30-theme.zsh" "$HOME/.p10k.zsh"
ln -sf "$USER_ZSH_DIR/aliases.zsh" "$HOME/.aliases"
echo -e "  - Created symlink: ~/.p10k.zsh -> ~/.zsh/conf.d/30-theme.zsh"
echo -e "  - Created symlink: ~/.aliases -> ~/.zsh/aliases.zsh"

# Create local.zsh from template if it doesn't exist
if [ ! -f "$USER_ZSH_DIR/local.zsh" ]; then
    echo -e "${YELLOW}Creating local.zsh from template...${NC}"
    cp "$USER_ZSH_DIR/local.zsh.template" "$USER_ZSH_DIR/local.zsh"
    echo -e "  - Created local.zsh from template"
fi

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

# Show backup information if files were backed up
if [ ${#BACKED_UP_FILES[@]} -gt 0 ]; then
    echo -e "${YELLOW}The following files were backed up to: ${BACKUP_DIR}${NC}"
    for file in "${BACKED_UP_FILES[@]}"; do
        echo -e "  - $file"
    done
    echo
fi

echo -e "${YELLOW}Note: In any application that you use a shell (e.g. VS Code), you should change the font to \"MesloLGS Nerd Font\"${NC}"
echo