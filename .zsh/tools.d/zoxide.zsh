# Zoxide - A smarter cd command
# https://github.com/ajeetdsouza/zoxide

# Initialize zoxide if it's installed
if command -v zoxide &> /dev/null; then
  # Initialize zoxide with zsh integration
  eval "$(zoxide init zsh)"
  
  # Optional: Add any custom zoxide configuration here
  # For example, you can customize the key bindings or aliases
  
  # Uncomment to use 'z' as the command (default)
  # alias z='zoxide query'
  
  # Uncomment to use 'zi' for interactive selection
  # alias zi='zoxide query -i'
fi