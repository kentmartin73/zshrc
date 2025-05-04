#!/bin/bash
# Simple script to install required tools for zsh configuration

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installing Required Tools             ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Install Antigen
echo -e "${YELLOW}Installing Antigen...${NC}"
mkdir -p "$HOME/.antigen"
curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh" || {
    echo -e "${RED}Failed to download Antigen. Please install manually.${NC}"
}

# Detect operating system and install tools
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v brew &>/dev/null; then
        echo -e "${YELLOW}Installing tools with Homebrew...${NC}"
        brew install zoxide neovim bat fd
        
        # Install Meslo Nerd Font
        echo -e "${YELLOW}Installing Meslo Nerd Font...${NC}"
        brew tap homebrew/cask-fonts
        brew install --cask font-meslo-lg-nerd-font
    else
        echo -e "${YELLOW}Homebrew not found. Please install these tools manually:${NC}"
        echo -e "  - zoxide (directory jumper)"
        echo -e "  - neovim (text editor)"
        echo -e "  - bat (better cat)"
        echo -e "  - fd (better find)"
        echo -e "  - MesloLGS Nerd Font"
    fi
elif [[ -f /etc/debian_version ]]; then
    # Debian/Ubuntu
    echo -e "${YELLOW}On Debian/Ubuntu systems, consider installing:${NC}"
    echo -e "  sudo apt install zoxide neovim bat fd-find"
elif [[ -f /etc/fedora-release ]]; then
    # Fedora
    echo -e "${YELLOW}On Fedora systems, consider installing:${NC}"
    echo -e "  sudo dnf install zoxide neovim bat fd"
elif [[ -f /etc/arch-release ]]; then
    # Arch Linux
    echo -e "${YELLOW}On Arch Linux systems, consider installing:${NC}"
    echo -e "  sudo pacman -S zoxide neovim bat fd"
else
    echo -e "${YELLOW}Unknown OS. Please install these tools manually:${NC}"
    echo -e "  - zoxide (directory jumper)"
    echo -e "  - neovim (text editor)"
    echo -e "  - bat (better cat)"
    echo -e "  - fd (better find)"
fi

echo -e "${YELLOW}Remember to install MesloLGS Nerd Font for best results.${NC}"

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Tool Installation Complete!           ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo