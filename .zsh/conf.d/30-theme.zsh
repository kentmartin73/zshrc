# Powerlevel10k theme configuration
# This file is symlinked from ~/.p10k.zsh for compatibility with Powerlevel10k
# When using p10k configure, settings will be saved to this file
#
# This file provides comprehensive default styling to ensure a consistent look
# We configure the built-in status segment to always show error codes
# Users can customize their prompt using p10k configure

# Default Powerlevel10k settings
# These will be used when sourced directly or through the ~/.p10k.zsh symlink

# Context-aware prompt
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # built-in status segment (configured to always show error codes)
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

# Make sure status is always shown with code
typeset -g POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=true
  
# Status settings are defined below in the status segment configuration section

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

# Status segment configuration - optimized to always show error codes

# Success status - always show
typeset -g POWERLEVEL9K_STATUS_OK=true
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0

# Error status - always show the error code
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=3
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1
typeset -g POWERLEVEL9K_STATUS_ERROR_CONTENT_EXPANSION='%F{1}${P9K_CONTENT}%f'
  
# Critical settings to ensure error codes are always shown
typeset -g POWERLEVEL9K_STATUS_VERBOSE=true
typeset -g POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=true
typeset -g POWERLEVEL9K_STATUS_HIDE_SIGNAME=false
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
typeset -g POWERLEVEL9K_STATUS_CROSS=true
typeset -g POWERLEVEL9K_STATUS_ALWAYS_SHOW=true

# Force status segment to always show with explicit content
typeset -g POWERLEVEL9K_STATUS_OK_CONTENT_EXPANSION='%F{2}0%f'
typeset -g POWERLEVEL9K_STATUS_ERROR_CONTENT_EXPANSION='%F{1}${P9K_CONTENT}%f'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_CONTENT_EXPANSION='%F{2}0|%F{1}${P9K_CONTENT}%f'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_CONTENT_EXPANSION='%F{1}${P9K_CONTENT}%f'

# Pipe status configuration
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=3
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=1
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_CONTENT_EXPANSION='%F{1}${P9K_CONTENT}%f'

typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=3
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=1
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_CONTENT_EXPANSION='%F{1}${P9K_CONTENT}%f'

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

# OS icon settings
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=7

# Directory settings
typeset -g POWERLEVEL9K_DIR_BACKGROUND=4
typeset -g POWERLEVEL9K_DIR_FOREGROUND=254
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=250
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=255
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

# VCS settings
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2
typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=3
typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=8
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
typeset -g POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)

# Segment separator settings
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B1'
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B3'
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

# The status segment is configured to always show error codes
# This is done by setting POWERLEVEL9K_STATUS_ALWAYS_SHOW=true and other critical settings