# Powerlevel10k theme configuration
# Note: These settings will be used as fallback if ~/.p10k.zsh doesn't exist
# When using p10k configure, settings will be saved to ~/.p10k.zsh and take precedence
#
# This file provides minimal default settings and lets p10k configure handle most customizations
# We only define what's necessary for our custom exitcode segment and critical functionality
# This approach allows users to customize their prompt using p10k configure without conflicts

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
  
  # Ensure status segment shows the exit code
  typeset -g POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=true

  # Let p10k handle Node.js and Python version settings
  # These will be configured by the user when they run p10k configure

  # Let p10k handle Kubernetes and AWS context settings
  # These will be configured by the user when they run p10k configure

  # Status segment configuration
  # Let p10k handle most of the status configuration
  # We only set the critical settings needed for our use case
  
  # Critical settings to ensure error codes are shown
  typeset -g POWERLEVEL9K_STATUS_VERBOSE=true
  typeset -g POWERLEVEL9K_STATUS_SHOW_PIPESTATUS=true
  typeset -g POWERLEVEL9K_STATUS_ALWAYS_SHOW=true

  # Let p10k handle background jobs and command execution time settings
  # These will be configured by the user when they run p10k configure

  # Let p10k handle prompt appearance settings
  # Only set the font mode to ensure proper icon display
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete

  # Let p10k handle directory, VCS, and segment separator settings
  # These will be configured by the user when they run p10k configure
fi

# Ensure exitcode segment is in the right prompt elements
# This is done outside the if block so it works regardless of p10k.zsh existence
# The exitcode segment provides a more reliable way to show exit codes than the built-in status segment
# This is especially important for non-zero exit codes, which should always be visible
# Check if POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS is defined and doesn't contain exitcode
if typeset -p POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS &>/dev/null; then
  if ! typeset -p POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS 2>/dev/null | grep -q exitcode; then
    # Get the current right prompt elements
    eval "current_elements=(\${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]})"
    # Add exitcode to the beginning
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(exitcode "${current_elements[@]}")
  fi
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

# Create a hook to intercept p10k configure command
p10k() {
  if [[ "$1" == "configure" ]]; then
    echo "Using p10k-setup to ensure proper configuration with our modular setup..."
    p10k-setup
  else
    command p10k "$@"
  fi
}

# Check if p10k.zsh exists in home directory but is not a symlink to our version
if [[ -f ~/.p10k.zsh && ! -L ~/.p10k.zsh && ! -f ~/.zsh/p10k.zsh ]]; then
  # User ran p10k configure directly, copy the file to our directory
  echo "Detected p10k.zsh in home directory, copying to ~/.zsh/p10k.zsh"
  cp ~/.p10k.zsh ~/.zsh/p10k.zsh
  # Create symlink back to ensure future updates work properly
  mv ~/.p10k.zsh ~/.p10k.zsh.original
  ln -s ~/.zsh/p10k.zsh ~/.p10k.zsh
  echo "Created symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh for better organization"
elif [[ -f ~/.zsh/p10k.zsh && ! -L ~/.p10k.zsh ]]; then
  # We have our version but no symlink in home directory
  echo "Creating symlink from ~/.p10k.zsh to ~/.zsh/p10k.zsh"
  ln -s ~/.zsh/p10k.zsh ~/.p10k.zsh
fi

# Add an alias for p10k configure to ensure it works with our setup
alias p10k-configure="p10k-setup"