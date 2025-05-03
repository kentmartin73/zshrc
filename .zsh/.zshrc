# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/c901471
# Zsh Modular Configuration - A comprehensive modular Zsh setup for improved performance and maintainability
# Version: https://github.com/kentmartin73/zshrc/commit/84264bd
# Main zsh configuration file
# Sources all modular configuration files

# Check if this is the first run
FIRST_RUN_MARKER="$HOME/.zsh/.first_run_complete"

# Only show loading message on first run
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "ZSH modular configuration loading..."
fi

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