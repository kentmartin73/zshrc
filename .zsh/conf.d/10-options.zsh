# Zsh options and settings

# Directory navigation
setopt auto_cd              # If a command is not found, and is a directory, cd to it
setopt auto_pushd           # Make cd push the old directory onto the directory stack
setopt pushd_ignore_dups    # Don't push multiple copies of the same directory onto the stack
setopt pushd_minus          # Exchanges the meanings of '+' and '-' when used with a number to specify a directory in the stack

# Input/output
setopt interactive_comments # Allow comments even in interactive shells
setopt no_clobber          # Don't overwrite existing files with > operator
setopt correct             # Try to correct the spelling of commands
setopt no_flow_control     # Disable flow control (^S/^Q)
setopt path_dirs           # Perform path search even on command names with slashes
setopt rc_quotes           # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'

# Job control
setopt auto_resume         # Attempt to resume existing job before creating a new process
setopt notify              # Report status of background jobs immediately
setopt long_list_jobs      # List jobs in the long format by default

# Completion
setopt always_to_end       # Move cursor to the end of a completed word
setopt auto_menu           # Show completion menu on a successive tab press
setopt complete_in_word    # Complete from both ends of a word
setopt no_menu_complete    # Do not autoselect the first completion entry

# Expansion and globbing
setopt extended_glob       # Treat #, ~, and ^ as part of patterns for filename generation
setopt glob_dots           # Do not require a leading '.' in a filename to be matched explicitly
setopt no_case_glob        # Case insensitive globbing
setopt numeric_glob_sort   # Sort filenames numerically when it makes sense

# Environment variables
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-R'

# Set locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set default permissions
umask 022

# Add local bin to PATH
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Add Homebrew to PATH if it exists
if [[ -d "/opt/homebrew/bin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
elif [[ -d "/usr/local/bin" ]]; then
  export PATH="/usr/local/bin:$PATH"
fi