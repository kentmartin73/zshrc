# Performance optimizations for zsh
echo "Loading ZSH performance optimizations..."

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
echo "Setting up lazy loading for version managers..."
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

# Function to lazy load completions
function lazy_load_completion() {
  local command=$1
  local completion_file=$2
  
  # Only load completion when the command is first used
  eval "
  function $command() {
    # Remove this function
    unfunction $command
    
    # Load completion
    if [[ -f $completion_file ]]; then
      source $completion_file
    fi
    
    # Execute the command
    $command \"\$@\"
  }
  "
}

# Create directory for lazy-loaded completions
mkdir -p ~/.zsh/lazy
mkdir -p ~/.zsh/cache

# Enhanced completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' accept-exact '*(N)'

# Optimize command execution
echo "Optimizing ZSH completion system..."
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