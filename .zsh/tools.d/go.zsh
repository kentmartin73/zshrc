# Go version manager initialization
# This file is sourced by .zshrc to initialize Go version manager if it's installed

# Initialize goenv if it's installed
if command -v goenv &>/dev/null; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi