# Performance optimizations for zsh

# Uncomment these lines to profile zsh startup time
# zmodload zsh/zprof

# Function to lazy load commands
function lazy_load() {
  local load_func=$1
  local cmd=$2
  
  eval "$cmd() { unfunction $cmd; $load_func; $cmd \$@ }"
}

# Example: Lazy load nvm if it exists
if [ -d "$HOME/.nvm" ]; then
  lazy_load 'source ~/.nvm/nvm.sh' nvm
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

# Enhanced completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' accept-exact '*(N)'