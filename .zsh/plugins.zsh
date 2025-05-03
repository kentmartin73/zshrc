# Plugin management with Antigen

# Disable Antigen debug logging to prevent errors
export ANTIGEN_DEBUG_LOG=0

# Load Antigen (OS-specific path)
if [[ -f ~/.zsh/antigen_path.zsh ]]; then
  source ~/.zsh/antigen_path.zsh
else
  # Default macOS Homebrew path
  source /opt/homebrew/share/antigen/antigen.zsh 2>/dev/null || \
  # Alternative Homebrew path
  source /usr/local/share/antigen/antigen.zsh 2>/dev/null || \
  # Fallback to home directory
  source $HOME/antigen.zsh 2>/dev/null || \
  echo "Warning: Antigen not found. Plugin management disabled."
fi

# Only load plugins if Antigen is available
if type antigen > /dev/null 2>&1; then
  # === Core Plugins (Load First) ===
  # History substring search - provides better history navigation
  antigen bundle history-substring-search
  
  # === Utility Plugins ===
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
  # ZSH completions - additional completion definitions
  antigen bundle zsh-users/zsh-completions
  
  # === Interactive Plugins ===
  # Auto suggestions - suggests commands as you type based on history
  antigen bundle zsh-users/zsh-autosuggestions
  
  # === Theme ===
  antigen theme romkatv/powerlevel10k
  
  # Note: We're removing zsh-autocomplete as it conflicts with other completion systems
  # and history-search-multi-word as it's redundant with history-substring-search
  
  # === Syntax Highlighting (Load Last) ===
  # Fast syntax highlighting - syntax highlighting for ZSH
  antigen bundle z-shell/F-Sy-H --branch=main
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)
  
  # Apply all plugins
  antigen apply
  
  # Set up history-substring-search keybindings after plugins are loaded
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