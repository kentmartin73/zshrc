#!/bin/bash
# Cleanup script to remove the entire repository after installation

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Cleaning up installation files        ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Get the current directory
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e "${YELLOW}Repository directory: $REPO_DIR${NC}"

# Check if we're in a git repository
if [ -d "$REPO_DIR/.git" ]; then
    echo -e "${YELLOW}Removing entire repository directory...${NC}"
    
    # Create a temporary script to delete the repository
    # This is needed because the script can't delete itself while running
    TEMP_SCRIPT=$(mktemp)
    cat > "$TEMP_SCRIPT" << EOF
#!/bin/bash
# Wait for the parent script to exit
sleep 1
# Remove the entire repository directory
rm -rf "$REPO_DIR"
# Remove this temporary script
rm -f "\$0"
EOF
    
    chmod +x "$TEMP_SCRIPT"
    
    echo -e "${GREEN}=========================================${NC}"
    echo -e "${GREEN}  Cleanup Complete!                    ${NC}"
    echo -e "${GREEN}=========================================${NC}"
    echo
    
    # Execute the temporary script in the background
    "$TEMP_SCRIPT" &
    
    # Exit this script
    exit 0
else
    echo -e "${YELLOW}Not a git repository. Exiting without cleanup.${NC}"
    exit 1
fi