# Powerlevel10k theme configuration

# Context-aware prompt
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # exit code of the last command
  command_execution_time  # duration of the last command
  background_jobs         # presence of background jobs
  direnv                  # direnv status
  asdf                    # asdf version manager
  virtualenv              # python virtual environment
  pyenv                   # python environment
  goenv                   # go environment
  nodenv                  # node.js version from nodenv
  nvm                     # node.js version from nvm
  kubecontext             # current kubernetes context
  terraform               # terraform workspace
  aws                     # aws profile
  azure                   # azure account name
  gcloud                  # google cloud cli account and project
)

# Show Node.js version only when package.json or node_modules exists
typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true

# Show Python version only when .py files or virtual environment exists
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=true
typeset -g POWERLEVEL9K_VIRTUALENV_GENERIC_NAMES=(virtualenv venv .venv env)

# Kubernetes context settings
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|kubeseal|skaffold'
typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
  '*prod*'  PROD
  '*'       DEFAULT
)
typeset -g POWERLEVEL9K_KUBECONTEXT_PROD_BACKGROUND=red
typeset -g POWERLEVEL9K_KUBECONTEXT_PROD_FOREGROUND=white
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND=blue
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=white

# AWS context settings
typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt'
typeset -g POWERLEVEL9K_AWS_CLASSES=(
  '*prod*'  PROD
  '*'       DEFAULT
)
typeset -g POWERLEVEL9K_AWS_PROD_BACKGROUND=red
typeset -g POWERLEVEL9K_AWS_PROD_FOREGROUND=white
typeset -g POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=208
typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=white

# Status settings - show green tick for success, red cross with code for failure
typeset -g POWERLEVEL9K_STATUS_OK=true
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0

# Show error code and red cross for error
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=3
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1
# Show error code before the error symbol
typeset -g POWERLEVEL9K_STATUS_ERROR_CONTENT_EXPANSION='%B%F{1}${P9K_CONTENT}%f%b'
typeset -g POWERLEVEL9K_STATUS_HIDE_SIGNAME=true

# Enable extended status for pipelines
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
typeset -g POWERLEVEL9K_STATUS_VERBOSE=true
typeset -g POWERLEVEL9K_STATUS_CROSS=true
typeset -g POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=true

# Configure pipe status
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=3
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=1

typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=3
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=1

# Background jobs settings
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false

# Command execution time settings
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

# Customize prompt appearance
typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}❯%f '

# Directory settings
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_from_right

# VCS settings
typeset -g POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)

# Segment separator settings - round instead of pointy
# The right end of left prompt (round)
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
# The left end of right prompt (round)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
# The left end of left prompt (round)
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
# The right end of right prompt (round)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'