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
    brew install dust lsd neovim bat fd duf pyenv
    
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
    # "$SCRIPT_DIR/configure_iterm2.sh"
    
    # Configure pyenv
    echo -e "${YELLOW}Configuring pyenv...${NC}"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  else
    echo -e "${RED}Homebrew not found. Please install manually: dust, lsd, neovim, bat, fd, duf, iTerm2, Meslo Nerd Font, and pyenv${NC}"
  fi
elif [[ -f /etc/debian_version ]]; then
  # Debian/Ubuntu
  if command -v apt &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with apt...${NC}"
    sudo apt update
    sudo apt install -y dust lsd neovim bat fd-find duf
    
    # Install pyenv dependencies
    echo -e "${YELLOW}Installing pyenv dependencies...${NC}"
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    
    # Install pyenv
    echo -e "${YELLOW}Installing pyenv...${NC}"
    curl https://pyenv.run | bash
    
    # Configure pyenv
    echo -e "${YELLOW}Configuring pyenv...${NC}"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  else
    echo -e "${RED}Cannot install with apt. Please install manually: dust, lsd, neovim, bat, fd-find, duf, and pyenv${NC}"
  fi
elif [[ -f /etc/fedora-release ]]; then
  # Fedora
  if command -v dnf &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with dnf...${NC}"
    sudo dnf install -y dust lsd neovim bat fd duf
    
    # Install pyenv dependencies
    echo -e "${YELLOW}Installing pyenv dependencies...${NC}"
    sudo dnf install -y make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
    openssl-devel tk-devel libffi-devel xz-devel
    
    # Install pyenv
    echo -e "${YELLOW}Installing pyenv...${NC}"
    curl https://pyenv.run | bash
    
    # Configure pyenv
    echo -e "${YELLOW}Configuring pyenv...${NC}"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  else
    echo -e "${RED}Cannot install with dnf. Please install manually: dust, lsd, neovim, bat, fd, duf, and pyenv${NC}"
  fi
elif [[ -f /etc/arch-release ]]; then
  # Arch Linux
  if command -v pacman &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with pacman...${NC}"
    sudo pacman -S --noconfirm dust lsd neovim bat fd duf
    
    # Install pyenv dependencies
    echo -e "${YELLOW}Installing pyenv dependencies...${NC}"
    sudo pacman -S --noconfirm base-devel openssl zlib xz
    
    # Install pyenv
    echo -e "${YELLOW}Installing pyenv...${NC}"
    curl https://pyenv.run | bash
    
    # Configure pyenv
    echo -e "${YELLOW}Configuring pyenv...${NC}"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  else
    echo -e "${RED}Cannot install with pacman. Please install manually: dust, lsd, neovim, bat, fd, duf, and pyenv${NC}"
  fi
else
  echo -e "${RED}Unknown OS. Please install manually: dust, lsd, neovim, bat, fd, duf, and pyenv${NC}"
fi

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Tool Installation Complete!           ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo