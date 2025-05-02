#!/bin/bash

# Script to fix iTerm2 font configuration
# This creates a profile file that can be manually imported into iTerm2

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Font Configuration Fix         ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ]; then
    echo -e "${RED}Error: iTerm2 is not installed. Please install it first.${NC}"
    exit 1
fi

# Install Meslo Nerd Font if not already installed
if ! ls ~/Library/Fonts/Meslo*Nerd*Font* &>/dev/null; then
    echo -e "${YELLOW}Installing Meslo Nerd Font...${NC}"
    brew tap homebrew/cask-fonts
    brew install --cask font-meslo-lg-nerd-font
fi

# Create the profile file
PROFILE_FILE=~/Desktop/ZshModular.itermprofile
echo -e "${YELLOW}Creating iTerm2 profile file at ${PROFILE_FILE}...${NC}"

cat > "$PROFILE_FILE" << 'EOL'
{
  "Profiles": [
    {
      "Name": "Zsh Modular",
      "Guid": "zsh-modular-profile",
      "Normal Font": "MesloLGSNerdFontComplete-Regular 12",
      "Non Ascii Font": "MesloLGSNerdFontComplete-Regular 12",
      "Use Non-ASCII Font": true,
      "Horizontal Spacing": 1,
      "Vertical Spacing": 1,
      "Use Bold Font": true,
      "Use Bright Bold": true,
      "Use Italic Font": true,
      "ASCII Anti Aliased": true,
      "Non-ASCII Anti Aliased": true,
      "Ambiguous Double Width": false,
      "Draw Powerline Glyphs": true,
      "Cursor Type": 2,
      "Cursor Text Color": {
        "Red Component": 0,
        "Green Component": 0,
        "Blue Component": 0
      },
      "Cursor Color": {
        "Red Component": 0.73333334922790527,
        "Green Component": 0.73333334922790527,
        "Blue Component": 0.73333334922790527
      },
      "Background Color": {
        "Red Component": 0,
        "Green Component": 0,
        "Blue Component": 0
      },
      "Foreground Color": {
        "Red Component": 0.73333334922790527,
        "Green Component": 0.73333334922790527,
        "Blue Component": 0.73333334922790527
      },
      "Selected Text Color": {
        "Red Component": 0,
        "Green Component": 0,
        "Blue Component": 0
      },
      "Selection Color": {
        "Red Component": 0.73333334922790527,
        "Green Component": 0.73333334922790527,
        "Blue Component": 0.73333334922790527
      }
    }
  ]
}
EOL

# Create a simple HTML file with instructions
INSTRUCTIONS_FILE=~/Desktop/iTerm2_Instructions.html
echo -e "${YELLOW}Creating instructions file at ${INSTRUCTIONS_FILE}...${NC}"

cat > "$INSTRUCTIONS_FILE" << 'EOL'
<!DOCTYPE html>
<html>
<head>
    <title>iTerm2 Configuration Instructions</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        h1, h2 {
            color: #333;
        }
        .step {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .step h2 {
            margin-top: 0;
        }
        img {
            max-width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 10px 0;
        }
        code {
            background-color: #f1f1f1;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <h1>iTerm2 Configuration Instructions</h1>
    
    <div class="step">
        <h2>Step 1: Import the Profile</h2>
        <p>Open iTerm2 and go to <code>Preferences</code> (⌘,)</p>
        <p>Click on the <code>Profiles</code> tab</p>
        <p>Click the <code>Other Actions...</code> button at the bottom of the profile list</p>
        <p>Select <code>Import JSON Profiles...</code></p>
        <p>Navigate to your Desktop and select the <code>ZshModular.itermprofile</code> file</p>
    </div>
    
    <div class="step">
        <h2>Step 2: Set as Default Profile</h2>
        <p>In the profile list, select the newly imported <code>Zsh Modular</code> profile</p>
        <p>Click the <code>Other Actions...</code> button again</p>
        <p>Select <code>Set as Default</code></p>
    </div>
    
    <div class="step">
        <h2>Step 3: Verify Font Settings</h2>
        <p>With the <code>Zsh Modular</code> profile selected, click on the <code>Text</code> tab</p>
        <p>Verify that both the font and non-ASCII font are set to <code>MesloLGSNerdFontComplete-Regular</code></p>
        <p>If not, manually select this font for both settings</p>
    </div>
    
    <div class="step">
        <h2>Step 4: Restart iTerm2</h2>
        <p>Close iTerm2 completely</p>
        <p>Reopen iTerm2 - it should now use the new profile with the correct font</p>
    </div>
    
    <div class="step">
        <h2>Troubleshooting</h2>
        <p>If you still don't see the correct font or Powerlevel10k icons:</p>
        <ol>
            <li>Make sure the Meslo Nerd Font is installed (it should be in <code>~/Library/Fonts/</code>)</li>
            <li>Try manually setting the font in Preferences > Profiles > Text</li>
            <li>Run <code>p10k configure</code> to reconfigure Powerlevel10k</li>
        </ol>
    </div>
</body>
</html>
EOL

# Open the instructions file
open "$INSTRUCTIONS_FILE"

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  iTerm2 Profile Created!              ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "A new iTerm2 profile has been created at: ${YELLOW}${PROFILE_FILE}${NC}"
echo -e "Instructions have been opened in your browser."
echo
echo -e "Please follow the instructions to:"
echo -e "1. Import the profile into iTerm2"
echo -e "2. Set it as the default profile"
echo -e "3. Restart iTerm2"
echo
echo -e "If you still have issues, you can manually set the font in iTerm2:"
echo -e "Preferences > Profiles > Text > Font: ${YELLOW}MesloLGSNerdFontComplete-Regular${NC}"
echo