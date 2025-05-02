# pyenv initialization
# This file is sourced by .zshrc to initialize pyenv if it's installed

# Check if pyenv is installed
if command -v pyenv &>/dev/null; then
  # Set up pyenv environment variables
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  
  # Initialize pyenv
  eval "$(pyenv init -)"
  
  # Initialize pyenv-virtualenv if it's installed
  if [[ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi