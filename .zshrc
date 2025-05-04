# Kent Martin's Zsh Modular Configuration (commit fdfc98e) - A comprehensive modular Zsh setup
# Version: commit fdfc98e (https://github.com/kentmartin73/zshrc/commit/fdfc98e) - Updated: 2025-05-04 17:34:35 UTC
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
