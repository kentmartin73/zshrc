# Completion system configuration

# Initialize the completion system
autoload -Uz compinit
compinit

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
# Git completions
if command -v git &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  curl -o ~/.zsh/lazy/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 2>/dev/null
  curl -o ~/.zsh/lazy/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh 2>/dev/null
  lazy_load_completion git "~/.zsh/lazy/_git"
fi

# Docker completions
if command -v docker &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > ~/.zsh/lazy/_docker 2>/dev/null
  lazy_load_completion docker "~/.zsh/lazy/_docker"
fi

# Docker Compose completions
if command -v docker-compose &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose > ~/.zsh/lazy/_docker-compose 2>/dev/null
  lazy_load_completion docker-compose "~/.zsh/lazy/_docker-compose"
fi

# npm completions
if command -v npm &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  npm completion > ~/.zsh/lazy/_npm 2>/dev/null
  lazy_load_completion npm "~/.zsh/lazy/_npm"
fi

# pip completions
if command -v pip &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  pip completion --zsh > ~/.zsh/lazy/_pip 2>/dev/null
  lazy_load_completion pip "~/.zsh/lazy/_pip"
fi

# SSH host completions
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:scp:*' hosts $h
fi

# Kubectl completions
if command -v kubectl &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  kubectl completion zsh > ~/.zsh/lazy/_kubectl 2>/dev/null
  lazy_load_completion kubectl "~/.zsh/lazy/_kubectl"
fi

# AWS CLI completions
if command -v aws &>/dev/null; then
  mkdir -p ~/.zsh/lazy
  complete -C aws_completer aws
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