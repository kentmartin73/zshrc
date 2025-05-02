# macOS specific configuration

# Set macOS specific environment variables
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Add macOS specific paths
if [[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Add Homebrew sbin to PATH
if [[ -d "/opt/homebrew/sbin" ]]; then
  export PATH="/opt/homebrew/sbin:$PATH"
fi

# macOS specific aliases
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Use GNU versions of tools if installed via Homebrew
if [[ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]]; then
  export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Enable iTerm2 shell integration if available
if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi