# asdf version manager initialization
# This file is sourced by .zshrc to initialize asdf if it's installed

# Initialize asdf if it's installed
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  # Source asdf
  . "$HOME/.asdf/asdf.sh"
  
  # Add asdf completions
  fpath=(${ASDF_DIR}/completions $fpath)
  autoload -Uz compinit
  compinit
elif [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  # Source asdf from Homebrew
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
  
  # Add asdf completions
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
  autoload -Uz compinit
  compinit
fi