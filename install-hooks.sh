#!/bin/bash

# Script to install git hooks for the zsh modular configuration repository

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installing Git Hooks                  ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if .git directory exists
if [ ! -d "$SCRIPT_DIR/.git" ]; then
    echo -e "${RED}Error: This script must be run from the root of the git repository.${NC}"
    exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p "$SCRIPT_DIR/.git/hooks"

# Create pre-commit hook
echo -e "${YELLOW}Creating pre-commit hook...${NC}"
cat > "$SCRIPT_DIR/.git/hooks/pre-commit" << 'EOL'
#!/bin/bash

# Pre-commit hook to add version information and product description to files
# This script adds a link to the commit/tag at the top of specified files

# Files to update
FILES=("install.sh" ".zsh/setup.sh" ".zsh/.zshrc")

# Product description
DESCRIPTION="Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability"

# Get the current commit hash
COMMIT_SHA=$(git rev-parse --short HEAD 2>/dev/null)
if [ -z "$COMMIT_SHA" ]; then
  # If we can't get the commit hash (e.g., initial commit), use a placeholder
  COMMIT_SHA="initial-commit"
fi

# Get the repository URL
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//')
if [[ $REPO_URL == *"github.com"* ]]; then
  # Convert SSH URL to HTTPS URL if needed
  REPO_URL=$(echo $REPO_URL | sed 's/git@github.com:/https:\/\/github.com\//')
  COMMIT_URL="$REPO_URL/commit/$COMMIT_SHA"
else
  # If not GitHub or can't determine URL, just use the commit hash
  COMMIT_URL="commit: $COMMIT_SHA"
fi

# Check if we're on a tag
TAG=$(git describe --exact-match --tags 2>/dev/null)
if [ -n "$TAG" ]; then
  if [[ $REPO_URL == *"github.com"* ]]; then
    VERSION_INFO="# $DESCRIPTION\n# Version: $TAG ($COMMIT_URL)"
  else
    VERSION_INFO="# $DESCRIPTION\n# Version: $TAG (commit: $COMMIT_SHA)"
  fi
else
  if [[ $REPO_URL == *"github.com"* ]]; then
    VERSION_INFO="# $DESCRIPTION\n# Version: $COMMIT_URL"
  else
    VERSION_INFO="# $DESCRIPTION\n# Version: commit: $COMMIT_SHA"
  fi
fi

# Update each file
for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    # Create a temporary file
    TEMP_FILE=$(mktemp)
    
    # Add version info at the top, preserving the shebang if it exists
    if grep -q "^#!" "$file"; then
      # If file has shebang, keep it at the top
      SHEBANG=$(head -n 1 "$file")
      echo "$SHEBANG" > "$TEMP_FILE"
      echo -e "$VERSION_INFO" >> "$TEMP_FILE"
      tail -n +2 "$file" >> "$TEMP_FILE"
    else
      # No shebang, just add version info at the top
      echo -e "$VERSION_INFO" > "$TEMP_FILE"
      cat "$file" >> "$TEMP_FILE"
    fi
    
    # Replace the original file
    mv "$TEMP_FILE" "$file"
    
    # Stage the modified file
    git add "$file"
    
    echo "Added version info to $file"
  else
    echo "Warning: File $file not found, skipping"
  fi
done

exit 0
EOL

# Make the hook executable
chmod +x "$SCRIPT_DIR/.git/hooks/pre-commit"

echo -e "${GREEN}Git hooks installed successfully!${NC}"
echo -e "The pre-commit hook will automatically add version information to:"
echo -e "  - install.sh"
echo -e "  - .zsh/setup.sh"
echo -e "  - .zsh/.zshrc"
echo
echo -e "When you make a commit, these files will be updated with:"
echo -e "  - A description of the project"
echo -e "  - The current tag (if available) or commit hash"
echo -e "  - A link to the commit on GitHub (if available)"
echo