# Completion system configuration

# Check if this is the first run (marker file defined in performance.zsh)
FIRST_RUN_MARKER="$HOME/.zsh/.first_run_complete"

# Note: compinit is now initialized in performance.zsh
# We don't need to initialize it again here

# Cache completion to speed things up
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Menu selection for completion
zstyle ':completion:*' menu select

# Case-insensitive (all), partial-word, and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better completion grouping
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''

# Fuzzy matching of completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors allowed based on the length of the typed word
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Setup lazy loading for various completions
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "Setting up ZSH completions system..."
fi

# Note: Moved to a function to avoid duplication and improve maintainability
function setup_completion() {
  local command=$1
  local url=$2
  local output_file=~/.zsh/lazy/_$command
  
  if command -v $command &>/dev/null; then
    mkdir -p ~/.zsh/lazy
    if [[ ! -f $output_file ]]; then
      if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
        echo "Downloading completion for $command..."
      fi
      if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
        # Show errors during first run
        curl -L "$url" > "$output_file"
      else
        # Suppress errors after first run
        curl -L "$url" > "$output_file" 2>/dev/null
      fi
    else
      if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
        echo "Using existing completion for $command"
      fi
    fi
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Setting up lazy loading for $command"
    fi
    lazy_load_completion $command "$output_file"
  fi
}

# Git completions
setup_completion git "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh"

# Docker completions
setup_completion docker "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker"

# Docker Compose completions
setup_completion docker-compose "https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose"

# npm completions
if command -v npm &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  if [[ ! -f ~/.zsh/lazy/_npm ]]; then
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      # Show errors during first run
      npm completion > ~/.zsh/lazy/_npm
    else
      # Suppress errors after first run
      npm completion > ~/.zsh/lazy/_npm 2>/dev/null
    fi
  fi
  lazy_load_completion npm "~/.zsh/lazy/_npm"
fi

# pip completions
if command -v pip &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  if [[ ! -f ~/.zsh/lazy/_pip ]]; then
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      # Show errors during first run
      pip completion --zsh > ~/.zsh/lazy/_pip
    else
      # Suppress errors after first run
      pip completion --zsh > ~/.zsh/lazy/_pip 2>/dev/null
    fi
  fi
  lazy_load_completion pip "~/.zsh/lazy/_pip"
fi

# SSH host completions
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  # Use command cat to bypass any cat alias (like bat)
  h=($h ${${${(f)"$(command cat ~/.ssh/known_hosts{,2} 2>/dev/null || true)"}%%\ *}%%,*})
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:scp:*' hosts $h
fi

# Kubectl completions
if command -v kubectl &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  if [[ ! -f ~/.zsh/lazy/_kubectl ]]; then
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      # Show errors during first run
      kubectl completion zsh > ~/.zsh/lazy/_kubectl
    else
      # Suppress errors after first run
      kubectl completion zsh > ~/.zsh/lazy/_kubectl 2>/dev/null
    fi
  fi
  lazy_load_completion kubectl "~/.zsh/lazy/_kubectl"
fi

# AWS CLI completions
if command -v aws &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  if [[ ! -f ~/.zsh/lazy/_aws ]]; then
    # Use zsh-specific AWS completion instead of the bash 'complete' command
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      # Show errors during first run
      if [[ -d "$(brew --prefix)/share/zsh/site-functions" ]]; then
        # For Homebrew installations
        ln -sf "$(brew --prefix)/bin/aws_zsh_completer.sh" ~/.zsh/lazy/_aws
      elif [[ -f /usr/local/bin/aws_zsh_completer.sh ]]; then
        # For standard installations
        ln -sf /usr/local/bin/aws_zsh_completer.sh ~/.zsh/lazy/_aws
      elif [[ -f /usr/bin/aws_zsh_completer.sh ]]; then
        # For system-wide installations
        ln -sf /usr/bin/aws_zsh_completer.sh ~/.zsh/lazy/_aws
      else
        # Generate completion script if available
        aws_completer=$(which aws_completer)
      fi
    else
      # Suppress errors after first run
      if [[ -d "$(brew --prefix 2>/dev/null)/share/zsh/site-functions" ]]; then
        # For Homebrew installations
        ln -sf "$(brew --prefix)/bin/aws_zsh_completer.sh" ~/.zsh/lazy/_aws 2>/dev/null
      elif [[ -f /usr/local/bin/aws_zsh_completer.sh ]]; then
        # For standard installations
        ln -sf /usr/local/bin/aws_zsh_completer.sh ~/.zsh/lazy/_aws 2>/dev/null
      elif [[ -f /usr/bin/aws_zsh_completer.sh ]]; then
        # For system-wide installations
        ln -sf /usr/bin/aws_zsh_completer.sh ~/.zsh/lazy/_aws 2>/dev/null
      else
        # Generate completion script if available
        aws_completer=$(which aws_completer 2>/dev/null)
      fi
      if [[ -n "$aws_completer" ]]; then
        echo '#compdef aws
_aws() {
  local -a args
  args=(
    "*: :->args"
  )
  local -a _comp_priv_prefix
  _arguments $args
  
  local -a completions
  completions=($('$aws_completer' --no-cli-auto-prompt))
  _describe "options" completions
}
_aws' > ~/.zsh/lazy/_aws
      fi
    fi
  fi
  lazy_load_completion aws "~/.zsh/lazy/_aws"
fi

# Homebrew completions
if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Man page completions
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# Completion for aliases
setopt complete_aliases