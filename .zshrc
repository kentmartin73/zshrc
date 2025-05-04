# Kent Martin's Zsh Modular Configuration (commit b1d336b) - A comprehensive modular Zsh setup
# Version: commit b1d336b (https://github.com/kentmartin73/zshrc/commit/b1d336b) - Updated: 2025-05-04 15:03:52 UTC
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# p10k.zsh is now a symlink to ~/.zsh/conf.d/30-theme.zsh
# No need for additional setup

# Source the main configuration file
source ~/.zsh/zshrc

# Source p10k configuration (symlinked to ~/.zsh/conf.d/30-theme.zsh)
source ~/.p10k.zsh
