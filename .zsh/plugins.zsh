# Plugin management with Antigen

# Source common variables if not already sourced
if [[ -z "$FIRST_RUN_MARKER" ]]; then
  source ~/.zsh/common.zsh
fi

# Only show initialization message on first run
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "ZSH initialization in progress..."
fi

# Create necessary directories and set up logging
if [[ ! -d "$HOME/.antigen" ]]; then
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    echo "First-time setup: Creating Antigen directories..."
  fi
  mkdir -p "$HOME/.antigen"
  touch "$HOME/.antigen/antigen.log"
  chmod 644 "$HOME/.antigen/antigen.log"
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    echo "Antigen log file created at ~/.antigen/antigen.log"
  fi
fi

# Add descriptive echo statements to show what's happening
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  echo "Loading ZSH plugins with Antigen..."
fi

# Load Antigen (OS-specific path)
if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
  # During first run, show errors directly (no redirection)
  if [[ -f ~/.zsh/antigen_path.zsh ]]; then
    source ~/.zsh/antigen_path.zsh
  else
    # Default macOS Homebrew path
    source /opt/homebrew/share/antigen/antigen.zsh || \
    # Alternative Homebrew path
    source /usr/local/share/antigen/antigen.zsh || \
    # Fallback to home directory
    source $HOME/antigen.zsh || \
    echo "Warning: Antigen not found. Plugin management disabled."
  fi
else
  # After first run, just log errors silently
  {
    if [[ -f ~/.zsh/antigen_path.zsh ]]; then
      source ~/.zsh/antigen_path.zsh
    else
      # Default macOS Homebrew path
      source /opt/homebrew/share/antigen/antigen.zsh || \
      # Alternative Homebrew path
      source /usr/local/share/antigen/antigen.zsh || \
      # Fallback to home directory
      source $HOME/antigen.zsh || \
      echo "Warning: Antigen not found. Plugin management disabled."
    fi
  } 2>>"$HOME/.antigen/antigen.log"
fi

# Only load plugins if Antigen is available
if type antigen > /dev/null 2>&1; then
  # Determine if we should show output or redirect to log
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    # First run - show messages in console
    log_file="/dev/stdout"
    echo "Loading Antigen plugins..."
    echo "Loading core plugins..."
  else
    # Subsequent runs - log to file silently
    log_file="$HOME/.antigen/antigen.log"
    {
      echo "Loading Antigen plugins..." >> "$log_file"
    } 2>>"$HOME/.antigen/antigen.log"
  fi
  
  # Use a function to load plugins with appropriate output redirection
  load_plugins() {
    # === Core Plugins (Load First) ===
    # History substring search - provides better history navigation
    antigen bundle history-substring-search
    
    # === Utility Plugins ===
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Loading utility plugins..."
    fi
    # Command not found - suggests package to install when command not found
    antigen bundle command-not-found
    # Directory persistence - automatically creates directory bookmarks
    antigen bundle dirpersist
    # Colored man pages - adds color to man pages
    antigen bundle colored-man-pages
    # Colorize - syntax highlighting for cat/less
    antigen bundle colorize
    # URL tools - URL encoding/decoding functions
    antigen bundle ohmyzsh/ohmyzsh plugins/urltools
    # Tab title - sets terminal tab title based on current directory/command
    antigen bundle trystan2k/zsh-tab-title --branch=main
    # Directory navigation - fast directory jumping
    # Note: zoxide is not an antigen plugin, it's initialized in .zshrc after plugins are loaded
    
    # === Completion Plugins ===
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Loading completion plugins..."
    fi
    # ZSH completions - additional completion definitions
    antigen bundle zsh-users/zsh-completions
    
    # === Interactive Plugins ===
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Loading interactive plugins..."
    fi
    # Auto suggestions - suggests commands as you type based on history
    antigen bundle zsh-users/zsh-autosuggestions
    
    # === Theme ===
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Loading Powerlevel10k theme..."
    fi
    antigen theme romkatv/powerlevel10k
    
    # Note: We're removing zsh-autocomplete as it conflicts with other completion systems
    # and history-search-multi-word as it's redundant with history-substring-search
    
    # === Syntax Highlighting (Load Last) ===
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Loading syntax highlighting..."
    fi
    # Fast syntax highlighting - syntax highlighting for ZSH
    antigen bundle z-shell/F-Sy-H --branch=main
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)
    
    # Apply all plugins
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Applying all plugins..."
    fi
    antigen apply
    
    # Show success message
    if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
      echo "Antigen plugins loaded successfully"
    else
      echo "Antigen plugins loaded successfully" >> "$log_file"
    fi
  }
  
  # Load plugins with appropriate redirection
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    # First run - show output
    load_plugins
  else
    # Subsequent runs - redirect output
    {
      load_plugins
    } 2>>"$HOME/.antigen/antigen.log"
  fi
  
  # Set up history-substring-search keybindings after plugins are loaded
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    echo "Setting up keybindings..."
  fi
  if [[ -n "${terminfo[kcuu1]}" ]]; then
    bindkey "${terminfo[kcuu1]}" history-substring-search-up
  fi
  if [[ -n "${terminfo[kcud1]}" ]]; then
    bindkey "${terminfo[kcud1]}" history-substring-search-down
  fi
  
  # Bind up and down arrows for history substring search
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  
  # Bind k and j for vi mode
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi
# Note: First run marker is now created in .zshrc after all configuration is complete

