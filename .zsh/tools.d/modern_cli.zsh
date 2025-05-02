# Modern CLI tools initialization
# This file is sourced by .zshrc to initialize modern CLI tools if they're installed

# Initialize dust (du replacement) if it's installed
if command -v dust &>/dev/null; then
  alias du="dust"
fi

# Initialize lsd (ls replacement) if it's installed
if command -v lsd &>/dev/null; then
  alias ls="lsd"
  alias l="lsd -l"
  alias la="lsd -la"
  alias lt="lsd --tree"
fi

# Initialize bat (cat replacement) if it's installed
if command -v bat &>/dev/null; then
  alias cat="bat"
  export BAT_THEME="Dracula"
  export BAT_STYLE="numbers,changes,header"
fi

# Initialize fd (find replacement) if it's installed
if command -v fd &>/dev/null; then
  alias find="fd"
fi

# Initialize duf (df replacement) if it's installed
if command -v duf &>/dev/null; then
  alias df="duf"
fi

# Initialize ripgrep if it's installed
if command -v rg &>/dev/null; then
  alias grep="rg"
fi

# Initialize fzf if it's installed
if command -v fzf &>/dev/null; then
  # Set fzf options
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  
  # Set fzf default command
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  fi
  
  # Source fzf completion and key bindings
  if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
  elif [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
  elif [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/completion.zsh
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  fi
fi