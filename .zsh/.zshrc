# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/c901471
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/84264bd
# Main zsh configuration file
# Sources all modular configuration files

# Always output at least one line to ensure Powerlevel10k warning appears
# This is intentional to keep the warning visible on all runs
echo "ZSH modular configuration loading..."

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source performance optimizations first
source ~/.zsh/performance.zsh

# Source all other configuration files
for config_file (~/.zsh/*.zsh); do
  if [[ "$config_file" != "$HOME/.zsh/performance.zsh" ]]; then
    source $config_file
  fi
done

# Source all tool-specific configuration files
if [[ -d ~/.zsh/tools.d ]]; then
  for tool_file (~/.zsh/tools.d/*.zsh); do
    source $tool_file
  done
fi

# Source local configuration if it exists (not in version control)
if [[ -f ~/.zsh/local.zsh ]]; then
  source ~/.zsh/local.zsh
fi