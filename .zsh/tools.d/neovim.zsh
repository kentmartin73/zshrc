# Neovim initialization
# This file is sourced by .zshrc to initialize Neovim if it's installed

# Initialize Neovim if it's installed
if command -v nvim &>/dev/null; then
  # Set Neovim as the default editor
  export EDITOR="nvim"
  export VISUAL="nvim"
  
  # Add some useful Neovim aliases
  alias vim="nvim"
  alias vi="nvim"
  alias v="nvim"
  
  # Open Neovim with fuzzy finder
  if command -v fzf &>/dev/null; then
    vf() {
      nvim $(fzf)
    }
  fi
fi