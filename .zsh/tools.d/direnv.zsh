# direnv initialization
# This file is sourced by .zshrc to initialize direnv if it's installed

# Initialize direnv if it's installed
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi