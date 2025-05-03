# Plugin management with Antigen

# Check if this is the first run (marker file defined in performance.zsh)
FIRST_RUN_MARKER="$HOME/.zsh/.first_run_complete"

# Always output at least one line to ensure Powerlevel10k warning appears
# This is intentional to keep the warning visible on all runs
echo "ZSH initialization in progress..."

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
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    # During first run, show errors directly (no redirection)
    echo "Loading Antigen plugins..."
    
    # === Core Plugins (Load First) ===
    echo "Loading core plugins..."
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
    antigen bundle ajeetdsouza/zoxide
    
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
    echo "Antigen plugins loaded successfully"
  else
    # After first run, just log errors silently
    {
    echo "Loading Antigen plugins..." >> "$HOME/.antigen/antigen.log"
    
    # === Core Plugins (Load First) ===
    # Plugin loading continues silently...
    
    echo "Antigen plugins loaded successfully" >> "$HOME/.antigen/antigen.log"
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
  
  if [[ ! -f "$FIRST_RUN_MARKER" ]]; then
    echo "ZSH configuration complete!"
    # Create the marker file to indicate first run is complete
    touch "$FIRST_RUN_MARKER"
  fi
fi