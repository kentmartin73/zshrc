#!/bin/bash
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability

# Zsh Modular Configuration Installer
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
    echo -e "${RED}Error: Git is not installed.${NC}"
    echo -e "${YELLOW}Please install Git using your package manager:${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "  ${GREEN}brew install git${NC}"
    elif [[ -f /etc/debian_version ]]; then
        echo -e "  ${GREEN}sudo apt-get install git${NC}"
    elif [[ -f /etc/redhat-release ]]; then
        echo -e "  ${GREEN}sudo yum install git${NC}"
    else
        echo -e "  Please install Git using your system's package manager"
    fi
    exit 1
fi

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Error: Zsh is not installed.${NC}"
    echo -e "${YELLOW}Please install Zsh using your package manager:${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "  ${GREEN}brew install zsh${NC}"
    elif [[ -f /etc/debian_version ]]; then
        echo -e "  ${GREEN}sudo apt-get install zsh${NC}"
    elif [[ -f /etc/redhat-release ]]; then
        echo -e "  ${GREEN}sudo yum install zsh${NC}"
    else
        echo -e "  Please install Zsh using your system's package manager"
    fi
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo -e "${YELLOW}Creating temporary directory...${NC}"

# Clone the repository (shallow clone for faster installation)
echo -e "${YELLOW}Cloning the repository...${NC}"
if ! git clone --depth 1 --single-branch https://github.com/kentmartin73/zshrc.git "$TEMP_DIR"; then
    echo -e "${RED}Error: Failed to clone the repository.${NC}"
    echo -e "${YELLOW}Possible reasons:${NC}"
    echo -e "  - No internet connection"
    echo -e "  - GitHub is unreachable"
    echo -e "  - Repository URL has changed"
    echo -e "${YELLOW}Please check your internet connection and try again.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Install required tools
echo -e "${YELLOW}Installing required tools...${NC}"
if ! cd "$TEMP_DIR"; then
    echo -e "${RED}Error: Failed to navigate to the cloned repository at $TEMP_DIR.${NC}"
    echo -e "${YELLOW}This could be due to:${NC}"
    echo -e "  - Insufficient permissions"
    echo -e "  - The directory was not created properly"
    rm -rf "$TEMP_DIR"
    exit 1
fi

if [ ! -f ./install_tools.sh ]; then
    echo -e "${RED}Error: install_tools.sh script not found in the cloned repository.${NC}"
    echo -e "${YELLOW}This could be due to:${NC}"
    echo -e "  - Repository structure has changed"
    echo -e "  - Clone was incomplete"
    rm -rf "$TEMP_DIR"
    exit 1
fi

chmod +x ./install_tools.sh
if ! ./install_tools.sh; then
    echo -e "${RED}Error: Failed to install required tools.${NC}"
    echo -e "${YELLOW}Please check the error messages above for more details.${NC}"
    echo -e "${YELLOW}You may need to install some dependencies manually.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Run the simplified setup script
echo -e "${YELLOW}Running the setup script...${NC}"
cd "$TEMP_DIR/.zsh" || {
    echo -e "${RED}Error: Failed to navigate to the .zsh directory.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Use simple_setup.sh if available, otherwise use setup.sh
if [[ -f "$TEMP_DIR/.zsh/simple_setup.sh" ]]; then
    cp "$TEMP_DIR/.zsh/simple_setup.sh" ./setup.sh
else
    echo -e "${YELLOW}Using standard setup script...${NC}"
fi

# Make the setup script executable and run it
chmod +x ./setup.sh
./setup.sh || {
    echo -e "${RED}Error: Setup script failed.${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Create marker file to indicate setup is complete
touch ~/.zsh/.setup_complete

# Run cleanup script to remove unnecessary files
echo -e "${YELLOW}Running cleanup script to remove unnecessary files...${NC}"
if [[ -f "$TEMP_DIR/cleanup.sh" ]]; then
    chmod +x "$TEMP_DIR/cleanup.sh"
    (cd "$TEMP_DIR" && ./cleanup.sh) || echo -e "${YELLOW}Cleanup script encountered issues, continuing anyway...${NC}"
else
    echo -e "${YELLOW}Cleanup script not found, continuing without cleanup...${NC}"
fi

# Clean up temporary directory
echo -e "${YELLOW}Cleaning up temporary directory...${NC}"
rm -rf "$TEMP_DIR" 2>/dev/null || echo -e "${YELLOW}Could not remove temporary directory: ${TEMP_DIR}${NC}"

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
echo -e "${YELLOW}Important:${NC} If you are connecting from another system (e.g., via SSH),"
echo -e "you will need to install the ${YELLOW}MesloLGS Nerd Font${NC} on that system"
echo -e "to properly display all Powerlevel10k icons."
echo

# Add note about GNU tools for macOS users
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo -e "${YELLOW}macOS Users:${NC} For better compatibility with Linux, consider installing GNU tools:"
  echo -e "  ${YELLOW}brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep${NC}"
  echo
fi

echo -e "For more detailed information and customization options, refer to:"
echo -e "  ${YELLOW}~/.zsh/README.md${NC}"
echo