#!/bin/bash

# Script to install all required tools and configure iTerm2
# This script is called by install.sh

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installing Required Tools             ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Detect operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS - use Homebrew if available
  if command -v brew &>/dev/null; then
    echo -e "${YELLOW}Installing utilities with Homebrew...${NC}"
    brew install dust lsd neovim bat fd duf
    
    # Install iTerm2 if not already installed
    if ! brew list --cask iterm2 &>/dev/null; then
      echo -e "${YELLOW}Installing iTerm2...${NC}"
      brew install --cask iterm2
    fi
    
    # Install Meslo Nerd Font (recommended for Powerlevel10k)
    if ! brew list --cask font-meslo-lg-nerd-font &>/dev/null; then
      echo -e "${YELLOW}Installing Meslo Nerd Font...${NC}"
      brew tap homebrew/cask-fonts
      brew install --cask font-meslo-lg-nerd-font
    fi
    
    # Configure iTerm2
    echo -e "${YELLOW}Configuring iTerm2...${NC}"
    "$SCRIPT_DIR/fix_iterm2.sh"
  else
    echo -e "${RED}Homebrew not found. Please install manually: dust, lsd, neovim, bat, fd, duf, iTerm2, and Meslo Nerd Font${NC}"
  fi
elif [[ -f /etc/debian_version ]]; then
  # Debian/Ubuntu
  if command -v apt &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with apt...${NC}"
    sudo apt update
    sudo apt install -y dust lsd neovim bat fd-find duf
  else
    echo -e "${RED}Cannot install with apt. Please install manually: dust, lsd, neovim, bat, fd-find, duf${NC}"
  fi
elif [[ -f /etc/fedora-release ]]; then
  # Fedora
  if command -v dnf &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with dnf...${NC}"
    sudo dnf install -y dust lsd neovim bat fd duf
  else
    echo -e "${RED}Cannot install with dnf. Please install manually: dust, lsd, neovim, bat, fd, duf${NC}"
  fi
elif [[ -f /etc/arch-release ]]; then
  # Arch Linux
  if command -v pacman &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with pacman...${NC}"
    sudo pacman -S --noconfirm dust lsd neovim bat fd duf
  else
    echo -e "${RED}Cannot install with pacman. Please install manually: dust, lsd, neovim, bat, fd, duf${NC}"
  fi
else
  echo -e "${RED}Unknown OS. Please install manually: dust, lsd, neovim, bat, fd, duf${NC}"
fi

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Tool Installation Complete!           ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo