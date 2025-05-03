# Plugin management with Antigen

# Create necessary directories and set up logging
if [[ ! -d "$HOME/.antigen" ]]; then
  echo "First-time setup: Creating Antigen directories..."
  mkdir -p "$HOME/.antigen"
  touch "$HOME/.antigen/antigen.log"
  chmod 644 "$HOME/.antigen/antigen.log"
  echo "Antigen log file created at ~/.antigen/antigen.log"
fi

# Add descriptive echo statements to show what's happening
echo "Loading ZSH plugins with Antigen..."

# Redirect all error output to the log file for the Antigen section
{
  # Load Antigen (OS-specific path)
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

# Only load plugins if Antigen is available
if type antigen > /dev/null 2>&1; then
  # Redirect all error output to the log file for the plugin loading section
  {
    echo "Loading Antigen plugins..." >> "$HOME/.antigen/antigen.log"
    
    # === Core Plugins (Load First) ===
    echo "Loading core plugins..."
    # History substring search - provides better history navigation
    antigen bundle history-substring-search
    
    # === Utility Plugins ===
    echo "Loading utility plugins..."
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
    echo "Loading completion plugins..."
    # ZSH completions - additional completion definitions
    antigen bundle zsh-users/zsh-completions
    
    # === Interactive Plugins ===
    echo "Loading interactive plugins..."
    # Auto suggestions - suggests commands as you type based on history
    antigen bundle zsh-users/zsh-autosuggestions
    
    # === Theme ===
    echo "Loading Powerlevel10k theme..."
    antigen theme romkatv/powerlevel10k
    
    # Note: We're removing zsh-autocomplete as it conflicts with other completion systems
    # and history-search-multi-word as it's redundant with history-substring-search
    
    # === Syntax Highlighting (Load Last) ===
    echo "Loading syntax highlighting..."
    # Fast syntax highlighting - syntax highlighting for ZSH
    antigen bundle z-shell/F-Sy-H --branch=main
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)
    
    # Apply all plugins
    echo "Applying all plugins..."
    antigen apply
    echo "Antigen plugins loaded successfully" >> "$HOME/.antigen/antigen.log"
  } 2>>"$HOME/.antigen/antigen.log"
  
  # Set up history-substring-search keybindings after plugins are loaded
  echo "Setting up keybindings..."
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
  
  echo "ZSH configuration complete!"
fi