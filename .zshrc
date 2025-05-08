# Kent Martin's Zsh Modular Configuration (commit 8c54ddf) - A comprehensive modular Zsh setup
# Version: commit 8c54ddf (https://github.com/kentmartin73/zshrc/commit/8c54ddf) - Updated: 2025-05-08 10:47:26 UTC
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# p10k.zsh is now a symlink to ~/.zsh/conf.d/30-theme.zsh
# No need for additional setup

# Source the main configuration file
source ~/.zsh/zshrc

# p10k.zsh is already sourced by ~/.zsh/zshrc as ~/.zsh/conf.d/30-theme.zsh
# No need to source it again
