# History configuration

# History file configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

# History options
setopt extended_history       # Record timestamp of command in HISTFILE
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # Ignore duplicated commands history list
setopt hist_ignore_space      # Ignore commands that start with space
setopt hist_verify            # Show command with history expansion to user before running it
setopt inc_append_history     # Add commands to HISTFILE in order of execution
setopt share_history          # Share command history data

# History substring search configuration
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