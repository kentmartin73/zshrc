# Kent Martin's Zsh Modular Configuration (commit d3ced9c) - A comprehensive modular Zsh setup
# Version: commit d3ced9c (https://github.com/kentmartin73/zshrc/commit/d3ced9c) - Updated: 2025-05-04 12:55:52 UTC
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ensure p10k.zsh symlink is properly set up before sourcing anything
if [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh && -f ~/.zsh/p10k.zsh ]]; then
  # Non-symlink p10k.zsh exists alongside our version - fix this
  mv ~/.p10k.zsh ~/.p10k.zsh.user
  echo "Found conflicting p10k.zsh files. Backed up ~/.p10k.zsh to ~/.p10k.zsh.user"
  ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
  echo "Created symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
elif [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh ]]; then
  # Non-symlink p10k.zsh exists but we don't have our own version yet
  mkdir -p ~/.zsh
  cp ~/.p10k.zsh ~/.zsh/p10k.zsh
  mv ~/.p10k.zsh ~/.p10k.zsh.original
  ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
  echo "Integrated existing p10k.zsh into modular setup"
elif [[ -f ~/.zsh/p10k.zsh && ! -e ~/.p10k.zsh ]]; then
  # Our version exists but symlink is missing
  ln -sf ~/.zsh/p10k.zsh ~/.p10k.zsh
  echo "Restored missing symlink to p10k.zsh"
fi

# Source the main configuration file
source ~/.zsh/zshrc

# Source p10k configuration if it exists
# This line is needed for p10k configure to work properly
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
