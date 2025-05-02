# Plugin management with Antigen

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
  # Load history-substring-search first
  antigen bundle history-substring-search
  
  # Antigen plugins
  antigen bundle command-not-found
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-completions
  antigen bundle colored-man-pages
  antigen bundle colorize
  antigen bundle dirpersist
  
  # Replace zsh-z with zoxide
  antigen bundle ajeetdsouza/zoxide
  
  # Add urltools plugin
  antigen bundle ohmyzsh/ohmyzsh plugins/urltools
  
  # Specify main branch for zsh-tab-title
  antigen bundle trystan2k/zsh-tab-title --branch=main
  
  # Theme
  antigen theme romkatv/powerlevel10k
  
  # Other plugins
  antigen bundle marlonrichert/zsh-autocomplete@22.02.21
  antigen bundle zdharma-continuum/history-search-multi-word
  
  # Load syntax highlighting last
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