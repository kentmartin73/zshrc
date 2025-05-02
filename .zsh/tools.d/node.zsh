# Node.js version managers initialization
# This file is sourced by .zshrc to initialize Node.js version managers if they're installed

# Initialize nvm if it's installed
if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
  # This loads nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # This loads nvm bash_completion
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Initialize nodenv if it's installed
if command -v nodenv &>/dev/null; then
  eval "$(nodenv init -)"
fi