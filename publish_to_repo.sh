#!/bin/bash

# Script to publish the modular zsh configuration to a GitHub repository

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Repository name
REPO_NAME="zshrc"

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed. Please install it first:${NC}"
    echo -e "  - macOS: brew install gh"
    echo -e "  - Linux: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git first.${NC}"
    exit 1
fi

# Check if user is logged in to GitHub CLI
if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}You need to login to GitHub CLI first:${NC}"
    gh auth login
fi

# Print header
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Publishing Zsh Configuration to GitHub ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Navigate to the project root directory
cd "$(dirname "$0")" || exit 1

# Check if the repository already exists
if ! gh repo view "$REPO_NAME" &> /dev/null; then
    echo -e "${YELLOW}Creating new GitHub repository: $REPO_NAME...${NC}"
    gh repo create "$REPO_NAME" --public --description "Modular Zsh Configuration" --confirm
else
    echo -e "${YELLOW}Repository $REPO_NAME already exists.${NC}"
fi

# Initialize git repository if not already initialized
if [ ! -d .git ]; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    git init
fi

# Check if the remote already exists
if ! git remote | grep -q "origin"; then
    echo -e "${YELLOW}Adding remote origin...${NC}"
    git remote add origin "https://github.com/$(gh api user | jq -r .login)/$REPO_NAME.git"
else
    echo -e "${YELLOW}Remote origin already exists.${NC}"
fi

# Add all files
echo -e "${YELLOW}Adding files to git...${NC}"
git add .

# Commit changes
echo -e "${YELLOW}Committing changes...${NC}"
git commit -m "Update modular zsh configuration"

# Push to GitHub
echo -e "${YELLOW}Pushing to GitHub...${NC}"
git push -u origin main || git push -u origin master

# Print success message
echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Repository Published Successfully!     ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "Your repository is available at: ${YELLOW}https://github.com/$(gh api user | jq -r .login)/$REPO_NAME${NC}"
echo
echo -e "To install from this repository, run:"
echo -e "${YELLOW}git clone https://github.com/$(gh api user | jq -r .login)/$REPO_NAME.git${NC}"
echo -e "${YELLOW}cd $REPO_NAME${NC}"
echo -e "${YELLOW}cd .zsh${NC}"
echo -e "${YELLOW}./setup.sh${NC}"
echo