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
  # Antigen plugins
  antigen bundle command-not-found
  antigen bundle z-shell/F-Sy-H --branch=main
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-completions
  antigen bundle colored-man-pages
  antigen bundle colorize
  antigen bundle dirpersist
  antigen bundle history-substring-search
  
  # Replace zsh-z with zoxide
  antigen bundle ajeetdsouza/zoxide
  
  # Add urltools plugin
  antigen bundle ohmyzsh/ohmyzsh plugins/urltools
  
  antigen bundle trystan2k/zsh-tab-title
  antigen theme romkatv/powerlevel10k
  antigen bundle marlonrichert/zsh-autocomplete@22.02.21
  antigen bundle zdharma-continuum/history-search-multi-word
  
  # Apply all plugins
  antigen apply
fi