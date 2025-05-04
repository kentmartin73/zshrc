# Powerlevel10k theme configuration
# Note: These settings will be used as fallback if ~/.p10k.zsh doesn't exist
# When using p10k configure, settings will be saved to ~/.p10k.zsh and take precedence
#
# This file provides comprehensive default styling to ensure a consistent look
# We include our custom exitcode segment to ensure error codes are always displayed
# Users can still customize their prompt using p10k configure which will take precedence

# Define a custom segment to show exit code
# This is defined outside the if block so it's always available
# Note: This function captures the exit code of the last command run
# Powerlevel10k will call this at the right time to capture the exit code
# of the command you just ran, before any other commands are executed
function prompt_exitcode() {
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    p10k segment -f red -t "↵ $exit_code"
  fi
}

# Check if p10k.zsh exists and source it, otherwise use these default settings
if [[ -f ~/.p10k.zsh ]]; then
  # p10k.zsh exists and is already sourced in the main .zshrc
  # No need to define settings here
  :
else
  # Default Powerlevel10k settings if p10k.zsh doesn't exist

  # Context-aware prompt
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    exitcode                # custom segment to show exit code (our custom implementation)
    status                  # built-in status segment (kept as backup)
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

  # Status segment configuration
  
  # Success status
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
  
  # Critical settings to ensure error codes are shown
  typeset -g POWERLEVEL9K_STATUS_VERBOSE=true
  typeset -g POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=true
  typeset -g POWERLEVEL9K_STATUS_HIDE_SIGNAME=false
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_CROSS=true
  typeset -g POWERLEVEL9K_STATUS_ALWAYS_SHOW=true
  
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
fi

# Ensure exitcode segment is in the right prompt elements
# This is done outside the if block so it works regardless of p10k.zsh existence
# The exitcode segment provides a more reliable way to show exit codes than the built-in status segment
# This is especially important for non-zero exit codes, which should always be visible
# Add exitcode segment to right prompt elements if it's not already there
if typeset -p POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS &>/dev/null &&
   ! typeset -p POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS 2>/dev/null | grep -q exitcode; then
  # Get the current right prompt elements and add exitcode to the beginning
  eval "current_elements=(\${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]})"
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(exitcode "${current_elements[@]}")
fi

# Add a function to run p10k configure and ensure it works with our setup
p10k-setup() {
  echo "Setting up Powerlevel10k configuration..."
  
  # Handle existing configuration
  if [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh ]]; then
    # User has a non-symlink p10k.zsh file
    echo "Backing up existing ~/.p10k.zsh to ~/.p10k.zsh.backup"
    cp ~/.p10k.zsh ~/.p10k.zsh.backup
    
    # Copy to our directory
    echo "Copying existing configuration to ~/.zsh/p10k.zsh"
    cp ~/.p10k.zsh ~/.zsh/p10k.zsh
    rm ~/.p10k.zsh
    
    # Create symlink
    echo "Creating symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
    ln -s ~/.zsh/p10k.zsh ~/.p10k.zsh
  elif [[ ! -f ~/.zsh/p10k.zsh ]]; then
    # No configuration exists yet
    touch ~/.zsh/p10k.zsh
    
    # Create symlink if it doesn't exist
    if [[ ! -L ~/.p10k.zsh ]]; then
      echo "Creating symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
      ln -s ~/.zsh/p10k.zsh ~/.p10k.zsh
    fi
  elif [[ ! -L ~/.p10k.zsh ]]; then
    # We have a configuration in our directory but no symlink
    echo "Creating symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
    ln -s ~/.zsh/p10k.zsh ~/.p10k.zsh
  fi
  
  # Run the p10k configuration wizard
  echo "Running Powerlevel10k configuration wizard..."
  command p10k configure
  
  # After configuration, remind the user about the symlink
  echo "Configuration complete! Your Powerlevel10k settings are in ~/.zsh/p10k.zsh"
  echo "(symlinked from ~/.p10k.zsh for compatibility)"
  echo "These settings will take precedence over any settings in ~/.zsh/conf.d/30-theme.zsh"
}

# Create a hook to intercept p10k configure command and use our custom setup function
p10k() {
  [[ "$1" == "configure" ]] && p10k-setup || command p10k "$@"
}

# Handle p10k.zsh file location and symlinks
if [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh ]]; then
  if [[ ! -f ~/.zsh/p10k.zsh ]]; then
    # User ran p10k configure directly, copy to our directory
    echo "Detected p10k.zsh in home directory, copying to ~/.zsh/p10k.zsh"
    cp ~/.p10k.zsh ~/.zsh/p10k.zsh
    mv ~/.p10k.zsh ~/.p10k.zsh.original
  fi
  # Create symlink to ensure future updates work properly
  echo "Creating symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
  ln -s ~/.zsh/p10k.zsh ~/.p10k.zsh
fi

# Add an alias for p10k configure to ensure it works with our setup
alias p10k-configure="p10k-setup"