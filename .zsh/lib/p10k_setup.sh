#!/bin/bash
# Shared p10k.zsh handling logic for modular zsh configuration

# Function to handle p10k.zsh setup
# This ensures consistent handling across install.sh, setup.sh, and .zshrc
setup_p10k_symlinks() {
  local quiet=$1
  local backup_suffix=${2:-"backup"}
  
  # Create ~/.zsh directory if it doesn't exist
  mkdir -p ~/.zsh 2>/dev/null
  
  # Handle existing p10k.zsh file
  if [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh && -f ~/.zsh/p10k.zsh ]]; then
    # Non-symlink p10k.zsh exists alongside our version - fix this
    mv ~/.p10k.zsh ~/.p10k.zsh.$backup_suffix
    [[ "$quiet" != "quiet" ]] && echo "Found conflicting p10k.zsh files. Backed up ~/.p10k.zsh to ~/.p10k.zsh.$backup_suffix"
    ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
    [[ "$quiet" != "quiet" ]] && echo "Created symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
  elif [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh ]]; then
    # Non-symlink p10k.zsh exists but we don't have our own version yet
    cp ~/.p10k.zsh ~/.zsh/p10k.zsh
    mv ~/.p10k.zsh ~/.p10k.zsh.$backup_suffix
    ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
    [[ "$quiet" != "quiet" ]] && echo "Integrated existing p10k.zsh into modular setup"
  elif [[ -f ~/.zsh/p10k.zsh && ! -e ~/.p10k.zsh ]]; then
    # Our version exists but symlink is missing
    ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
    [[ "$quiet" != "quiet" ]] && echo "Restored missing symlink to p10k.zsh"
  fi
  
  return 0
}