#!/bin/bash
# Simple setup script for modular zsh configuration

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Automatically detect the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ZSH_CONFIG_DIR="$SCRIPT_DIR/.zsh"
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

# Backup key files
for file in "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.aliases"; do
    if [ -e "$file" ]; then
        cp -r "$file" "$BACKUP_DIR/"
        echo -e "  - Backed up $(basename "$file")"
    fi
done

# Backup .zsh directory if it exists
if [ -d "$HOME/.zsh" ]; then
    cp -r "$HOME/.zsh" "$BACKUP_DIR/"
    echo -e "  - Backed up .zsh directory"
fi

# Create directory structure
echo -e "${YELLOW}Setting up directory structure...${NC}"
mkdir -p "$USER_ZSH_DIR/conf.d" "$USER_ZSH_DIR/lazy" "$USER_ZSH_DIR/cache"
mkdir -p "$HOME/.antigen"

# Copy configuration files
echo -e "${YELLOW}Copying configuration files...${NC}"
if [ -d "$ZSH_CONFIG_DIR" ]; then
    cp -r "$ZSH_CONFIG_DIR"/* "$USER_ZSH_DIR/" 2>/dev/null
else
    # Create basic configuration
    echo -e "${YELLOW}Creating basic configuration...${NC}"
    
    # Create 01-common.zsh
    echo '# Define marker for first run detection
FIRST_RUN_MARKER="$HOME/.zsh/.first_run_complete"' > "$USER_ZSH_DIR/conf.d/01-common.zsh"
    
    # Create 30-theme.zsh
    echo '# Powerlevel10k theme configuration
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time)
typeset -g POWERLEVEL9K_MODE=nerdfont-complete' > "$USER_ZSH_DIR/conf.d/30-theme.zsh"
    
    # Create zshrc
    echo '# Load all configuration files from conf.d in numerical order
for config_file in ~/.zsh/conf.d/[0-9]*-*.zsh; do
  source "$config_file"
done

# Load local configuration if it exists
[ -f ~/.zsh/local.zsh ] && source ~/.zsh/local.zsh

# Initialize zoxide if available
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"' > "$USER_ZSH_DIR/zshrc"
fi

# Create .zshrc
echo -e "${YELLOW}Creating .zshrc...${NC}"
echo '# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source the main configuration file
source ~/.zsh/zshrc

# Source p10k configuration
source ~/.p10k.zsh' > "$HOME/.zshrc"

# Create symlinks
echo -e "${YELLOW}Creating symlinks...${NC}"
ln -sf "$USER_ZSH_DIR/conf.d/30-theme.zsh" "$HOME/.p10k.zsh"

# Create aliases.zsh if it doesn't exist
if [ ! -f "$USER_ZSH_DIR/aliases.zsh" ]; then
    echo "# User aliases - add your aliases here" > "$USER_ZSH_DIR/aliases.zsh"
fi
ln -sf "$USER_ZSH_DIR/aliases.zsh" "$HOME/.aliases"

# Create local.zsh if it doesn't exist
if [ ! -f "$USER_ZSH_DIR/local.zsh" ]; then
    echo "# User local settings - add your custom settings here" > "$USER_ZSH_DIR/local.zsh"
fi

# Create marker file
touch "$USER_ZSH_DIR/.setup_complete"

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
echo -e "${YELLOW}Note: Change your terminal font to \"MesloLGS Nerd Font\" for best results${NC}"