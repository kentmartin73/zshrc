# Kent Martin's Zsh Modular Configuration v1.2.3 - A comprehensive modular Zsh setup
# Version: v1.2.3 (https://github.com/kentmartin73/zshrc/releases/tag/v1.2.3) - Updated: 2025-05-04 16:18:56 UTC
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
