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
    brew install dust lsd neovim bat fd duf pyenv zoxide
    
    # Install GNU coreutils and other GNU tools for better Linux compatibility
    echo -e "${YELLOW}Installing GNU coreutils and tools for better Linux compatibility...${NC}"
    brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
    
    # Install Antigen if not already installed
    if ! brew list antigen &>/dev/null; then
      echo -e "${YELLOW}Installing Antigen...${NC}"
      brew install antigen
    fi
    
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
    "$SCRIPT_DIR/configure_iterm2.sh"
    
  else
    echo -e "${RED}Homebrew not found. Please install manually: dust, lsd, neovim, bat, fd, duf, iTerm2, Meslo Nerd Font, pyenv, and zoxide${NC}"
    
    # Install Antigen manually
    echo -e "${YELLOW}Installing Antigen manually...${NC}"
    mkdir -p "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
    echo -e "${GREEN}Antigen installed to $HOME/.antigen/antigen.zsh${NC}"
    echo -e "${YELLOW}Add this to your .zshrc to use Antigen:${NC}"
    echo -e "  source $HOME/.antigen/antigen.zsh"
  fi
elif [[ -f /etc/debian_version ]]; then
  # Debian/Ubuntu
  if command -v apt &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with apt...${NC}"
    sudo apt update
    sudo apt install -y dust lsd neovim bat fd-find duf zoxide
    
    # Install Antigen
    echo -e "${YELLOW}Installing Antigen...${NC}"
    sudo mkdir -p /usr/local/share/antigen
    sudo curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh
    
    # Install pyenv dependencies
    echo -e "${YELLOW}Installing pyenv dependencies...${NC}"
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    
    # Install pyenv
    echo -e "${YELLOW}Installing pyenv...${NC}"
    curl https://pyenv.run | bash
    
  else
    echo -e "${RED}Cannot install with apt. Please install manually: dust, lsd, neovim, bat, fd-find, duf, pyenv, and zoxide${NC}"
    
    # Install Antigen manually
    echo -e "${YELLOW}Installing Antigen manually...${NC}"
    mkdir -p "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
    echo -e "${GREEN}Antigen installed to $HOME/.antigen/antigen.zsh${NC}"
    echo -e "${YELLOW}Add this to your .zshrc to use Antigen:${NC}"
    echo -e "  source $HOME/.antigen/antigen.zsh"
  fi
elif [[ -f /etc/fedora-release ]]; then
  # Fedora
  if command -v dnf &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with dnf...${NC}"
    sudo dnf install -y dust lsd neovim bat fd duf zoxide
    
    # Install Antigen
    echo -e "${YELLOW}Installing Antigen...${NC}"
    sudo mkdir -p /usr/local/share/antigen
    sudo curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh
    
    # Install pyenv dependencies
    echo -e "${YELLOW}Installing pyenv dependencies...${NC}"
    sudo dnf install -y make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
    openssl-devel tk-devel libffi-devel xz-devel
    
    # Install pyenv
    echo -e "${YELLOW}Installing pyenv...${NC}"
    curl https://pyenv.run | bash
    
  else
    echo -e "${RED}Cannot install with dnf. Please install manually: dust, lsd, neovim, bat, fd, duf, pyenv, and zoxide${NC}"
    
    # Install Antigen manually
    echo -e "${YELLOW}Installing Antigen manually...${NC}"
    mkdir -p "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
    echo -e "${GREEN}Antigen installed to $HOME/.antigen/antigen.zsh${NC}"
    echo -e "${YELLOW}Add this to your .zshrc to use Antigen:${NC}"
    echo -e "  source $HOME/.antigen/antigen.zsh"
  fi
elif [[ -f /etc/arch-release ]]; then
  # Arch Linux
  if command -v pacman &>/dev/null && sudo -n true 2>/dev/null; then
    echo -e "${YELLOW}Installing utilities with pacman...${NC}"
    sudo pacman -S --noconfirm dust lsd neovim bat fd duf zoxide
    
    # Install Antigen
    echo -e "${YELLOW}Installing Antigen...${NC}"
    sudo mkdir -p /usr/local/share/antigen
    sudo curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh
    
    # Install pyenv dependencies
    echo -e "${YELLOW}Installing pyenv dependencies...${NC}"
    sudo pacman -S --noconfirm base-devel openssl zlib xz
    
    # Install pyenv
    echo -e "${YELLOW}Installing pyenv...${NC}"
    curl https://pyenv.run | bash
    
  else
    echo -e "${RED}Cannot install with pacman. Please install manually: dust, lsd, neovim, bat, fd, duf, pyenv, and zoxide${NC}"
    
    # Install Antigen manually
    echo -e "${YELLOW}Installing Antigen manually...${NC}"
    mkdir -p "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
    echo -e "${GREEN}Antigen installed to $HOME/.antigen/antigen.zsh${NC}"
    echo -e "${YELLOW}Add this to your .zshrc to use Antigen:${NC}"
    echo -e "  source $HOME/.antigen/antigen.zsh"
  fi
else
  echo -e "${RED}Unknown OS. Please install manually: dust, lsd, neovim, bat, fd, duf, pyenv, and zoxide${NC}"
  
  # Install Antigen manually
  echo -e "${YELLOW}Installing Antigen manually...${NC}"
  mkdir -p "$HOME/.antigen"
  curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
  echo -e "${GREEN}Antigen installed to $HOME/.antigen/antigen.zsh${NC}"
  echo -e "${YELLOW}Add this to your .zshrc to use Antigen:${NC}"
  echo -e "  source $HOME/.antigen/antigen.zsh"
fi

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Tool Installation Complete!           ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo