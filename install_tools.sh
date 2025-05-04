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

# Detect operating system and install tools
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v brew &>/dev/null; then
        echo -e "${YELLOW}Installing tools with Homebrew...${NC}"
        
        # Install Antigen via Homebrew
        echo -e "${YELLOW}Installing Antigen...${NC}"
        brew install antigen
        
        # Install other tools
        echo -e "${YELLOW}Installing other tools...${NC}"
        brew install zoxide neovim bat fd
        
        # Install Meslo Nerd Font
        echo -e "${YELLOW}Installing Meslo Nerd Font...${NC}"
        brew tap homebrew/cask-fonts
        brew install --cask font-meslo-lg-nerd-font
    else
        echo -e "${YELLOW}Homebrew not found. Consider installing it:${NC}"
        echo -e "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        
        # Install Antigen manually as fallback
        echo -e "${YELLOW}Installing Antigen manually...${NC}"
        mkdir -p "$HOME/.antigen"
        curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh" || {
            echo -e "${RED}Failed to download Antigen. Please install manually.${NC}"
        }
    fi
elif [[ -f /etc/debian_version ]]; then
    # Debian/Ubuntu
    if command -v apt &>/dev/null && sudo -n true 2>/dev/null; then
        echo -e "${YELLOW}Installing tools with apt...${NC}"
        sudo apt update
        sudo apt install -y zoxide neovim bat fd-find
        
        # Install Antigen
        echo -e "${YELLOW}Installing Antigen...${NC}"
        if [ -d "/usr/local/share/antigen" ]; then
            echo -e "${GREEN}Antigen already installed.${NC}"
        else
            sudo mkdir -p /usr/local/share/antigen
            sudo curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh
        fi
    else
        echo -e "${YELLOW}Cannot use apt or sudo. Please install these tools manually:${NC}"
        echo -e "  sudo apt install zoxide neovim bat fd-find"
        
        # Install Antigen manually as fallback
        echo -e "${YELLOW}Installing Antigen manually...${NC}"
        mkdir -p "$HOME/.antigen"
        curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh" || {
            echo -e "${RED}Failed to download Antigen. Please install manually.${NC}"
        }
    fi
elif [[ -f /etc/fedora-release ]]; then
    # Fedora
    if command -v dnf &>/dev/null && sudo -n true 2>/dev/null; then
        echo -e "${YELLOW}Installing tools with dnf...${NC}"
        sudo dnf install -y zoxide neovim bat fd
        
        # Install Antigen
        echo -e "${YELLOW}Installing Antigen...${NC}"
        if [ -d "/usr/local/share/antigen" ]; then
            echo -e "${GREEN}Antigen already installed.${NC}"
        else
            sudo mkdir -p /usr/local/share/antigen
            sudo curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh
        fi
    else
        echo -e "${YELLOW}Cannot use dnf or sudo. Please install these tools manually:${NC}"
        echo -e "  sudo dnf install zoxide neovim bat fd"
        
        # Install Antigen manually as fallback
        echo -e "${YELLOW}Installing Antigen manually...${NC}"
        mkdir -p "$HOME/.antigen"
        curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh" || {
            echo -e "${RED}Failed to download Antigen. Please install manually.${NC}"
        }
    fi
elif [[ -f /etc/arch-release ]]; then
    # Arch Linux
    if command -v pacman &>/dev/null && sudo -n true 2>/dev/null; then
        echo -e "${YELLOW}Installing tools with pacman...${NC}"
        sudo pacman -S --noconfirm zoxide neovim bat fd
        
        # Install Antigen
        echo -e "${YELLOW}Installing Antigen...${NC}"
        if [ -d "/usr/local/share/antigen" ]; then
            echo -e "${GREEN}Antigen already installed.${NC}"
        else
            sudo mkdir -p /usr/local/share/antigen
            sudo curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh
        fi
    else
        echo -e "${YELLOW}Cannot use pacman or sudo. Please install these tools manually:${NC}"
        echo -e "  sudo pacman -S zoxide neovim bat fd"
        
        # Install Antigen manually as fallback
        echo -e "${YELLOW}Installing Antigen manually...${NC}"
        mkdir -p "$HOME/.antigen"
        curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh" || {
            echo -e "${RED}Failed to download Antigen. Please install manually.${NC}"
        }
    fi
else
    echo -e "${YELLOW}Unknown OS. Installing minimal required tools...${NC}"
    
    # Install Antigen manually as fallback
    echo -e "${YELLOW}Installing Antigen manually...${NC}"
    mkdir -p "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh" || {
        echo -e "${RED}Failed to download Antigen. Please install manually.${NC}"
    }
    
    echo -e "${YELLOW}Please consider installing these tools with your package manager:${NC}"
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