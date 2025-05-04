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
cp -r "$ZSH_CONFIG_DIR"/* "$USER_ZSH_DIR/" 2>/dev/null || {
    echo -e "${YELLOW}No .zsh directory found in repository, creating basic structure...${NC}"
    
    # Create basic conf.d files
    echo -e "${YELLOW}Creating basic configuration files...${NC}"
    
    # Create 01-common.zsh
    cat > "$USER_ZSH_DIR/conf.d/01-common.zsh" << 'EOF'
# Common variables and settings

# Define marker for first run detection
FIRST_RUN_MARKER="$HOME/.zsh/.first_run_complete"
EOF
    
    # Create 30-theme.zsh
    cat > "$USER_ZSH_DIR/conf.d/30-theme.zsh" << 'EOF'
# Powerlevel10k theme configuration
# This file is symlinked from ~/.p10k.zsh for compatibility with Powerlevel10k

# Default Powerlevel10k settings
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time)
typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
EOF
    
    # Create basic zshrc file
    cat > "$USER_ZSH_DIR/zshrc" << 'EOF'
# Main configuration file for Zsh Modular Configuration

# Load all configuration files from conf.d in numerical order
for config_file in ~/.zsh/conf.d/[0-9]*-*.zsh; do
  # Skip macOS setup on non-macOS systems
  if [[ "$config_file" == *"macos_setup"* && "$OSTYPE" != "darwin"* ]]; then
    continue
  fi
  
  # Skip local.zsh.template (it's just a template)
  if [[ "$config_file" == *"local.zsh.template" ]]; then
    continue
  fi
  
  # Source the configuration file
  source "$config_file"
done

# Load local configuration if it exists
if [[ -f ~/.zsh/local.zsh ]]; then
  source ~/.zsh/local.zsh
fi

# Initialize zoxide if available
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi
EOF
}

# Copy the top-level .zshrc to the user's home directory
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc" 2>/dev/null || {
    echo -e "${YELLOW}Creating basic .zshrc file...${NC}"
    cat > "$HOME/.zshrc" << 'EOF'
# Basic .zshrc created by setup.sh
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source the main configuration file
source ~/.zsh/zshrc

# Source p10k configuration
source ~/.p10k.zsh
EOF
}

echo -e "  - Copied configuration files to $USER_ZSH_DIR"

# Create symlinks
echo -e "${YELLOW}Creating symlinks...${NC}"

# Create p10k.zsh symlink
ln -sf "$USER_ZSH_DIR/conf.d/30-theme.zsh" "$HOME/.p10k.zsh"
echo -e "  - Created symlink: ~/.p10k.zsh -> ~/.zsh/conf.d/30-theme.zsh"

# Create aliases.zsh if it doesn't exist
if [ ! -f "$USER_ZSH_DIR/aliases.zsh" ]; then
    echo "# User aliases - add your aliases here" > "$USER_ZSH_DIR/aliases.zsh"
    echo "# Created by setup.sh on $(date)" >> "$USER_ZSH_DIR/aliases.zsh"
fi

# Create aliases symlink
ln -sf "$USER_ZSH_DIR/aliases.zsh" "$HOME/.aliases"
echo -e "  - Created symlink: ~/.aliases -> ~/.zsh/aliases.zsh"

# Create local.zsh if it doesn't exist
if [ ! -f "$USER_ZSH_DIR/local.zsh" ]; then
    echo "# User local settings - add your custom settings here" > "$USER_ZSH_DIR/local.zsh"
    echo "# Created by setup.sh on $(date)" >> "$USER_ZSH_DIR/local.zsh"
    echo -e "  - Created local.zsh file"
fi

# Create marker file to indicate setup is complete
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