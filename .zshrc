# Kent Martin's Zsh Modular Configuration (commit ba9f262) - A comprehensive modular Zsh setup
# Version: commit ba9f262 (https://github.com/kentmartin73/zshrc/commit/ba9f262) - Updated: 2025-05-04 13:10:29 UTC
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ensure p10k.zsh symlink is properly set up before sourcing anything
if [[ -f ~/.zsh/lib/p10k_setup.sh ]]; then
  source ~/.zsh/lib/p10k_setup.sh
  setup_p10k_symlinks "" "user"
fi

# Source the main configuration file
source ~/.zsh/zshrc

# Source p10k configuration if it exists
# This line is needed for p10k configure to work properly
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
