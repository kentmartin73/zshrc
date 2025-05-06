# Performance optimizations for zsh

# Note: FIRST_RUN_MARKER is defined in 01-common.zsh and available to all files

# Only show echo statements on first run
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "Loading ZSH performance optimizations..."
fi

# Profiling configuration
# To use: run `zsh_profile_start` before commands you want to profile,
# then `zsh_profile_stop` to see the results
function zsh_profile_start() {
  zmodload zsh/zprof
  echo "Profiling started. Run your commands now."
  echo "When finished, run 'zsh_profile_stop' to see results."
}

function zsh_profile_stop() {
  zprof
  echo "Profiling stopped and results displayed above."
}

# Function to lazy load commands
function lazy_load() {
  local load_func=$1
  local cmd=$2
  
  eval "$cmd() { unfunction $cmd; $load_func; $cmd \$@ }"
}

# Lazy load version managers and other heavy tools
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "Setting up lazy loading for version managers..."
fi
# Node Version Manager
if [ -d "$HOME/.nvm" ]; then
  lazy_load 'source ~/.nvm/nvm.sh' nvm
  lazy_load 'source ~/.nvm/bash_completion' nvm_completion
fi

# Python version manager
if [ -d "$HOME/.pyenv" ]; then
  lazy_load 'eval "$(pyenv init -)"' pyenv
fi

# Ruby version manager
if [ -d "$HOME/.rvm" ]; then
  lazy_load 'source ~/.rvm/scripts/rvm' rvm
fi

# Function to load completions directly
function load_completion() {
  local command=$1
  local completion_file=$2
  
  # Load completion directly if file exists
  if [[ -f $completion_file ]]; then
    # Add completion file directory to fpath
    fpath=($(dirname $completion_file) $fpath)
    
    # Ensure compinit is loaded
    autoload -Uz compinit
    compinit -i
  fi
}

# Old lazy_load_completion function is deprecated
# This is a compatibility wrapper that just calls load_completion
function lazy_load_completion() {
  load_completion "$1" "$2"
}

# Create directory for lazy-loaded completions
mkdir -p ~/.zsh/lazy
mkdir -p ~/.zsh/cache

# Enhanced completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' accept-exact '*(N)'

# Optimize command execution
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "Optimizing ZSH completion system..."
fi
# Load compinit first
autoload -Uz compinit

# Compile zsh completion dump to speed up loading
if [ -f ~/.zcompdump ]; then
  compinit -d ~/.zcompdump
  if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -d ~/.zcompdump
  else
    compinit -C -d ~/.zcompdump
  fi
  zcompile ~/.zcompdump
fi

# Optimize path lookup
typeset -U path cdpath fpath manpath