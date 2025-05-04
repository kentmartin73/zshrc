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
# Recommendation: Install GNU coreutils for more consistent behavior with Linux
# brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
if [[ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]]; then
  export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
  # Add other GNU tools to PATH if installed
  for gnuutil in findutils gnu-tar gnu-sed gawk grep; do
    if [[ -d "/opt/homebrew/opt/$gnuutil/libexec/gnubin" ]]; then
      export PATH="/opt/homebrew/opt/$gnuutil/libexec/gnubin:$PATH"
    fi
  done
else
  # If GNU coreutils not found, suggest installing them
  if [[ ! -f "$HOME/.zsh/.gnu_notice_shown" && -x "$(command -v brew)" ]]; then
    echo "Tip: For better compatibility with Linux, consider installing GNU coreutils:"
    echo "brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep"
    touch "$HOME/.zsh/.gnu_notice_shown"
  fi
fi

# Enable iTerm2 shell integration if available
if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi