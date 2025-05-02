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

# Note: History substring search keybindings are now set in plugins.zsh
# after the plugins are loaded with antigen apply