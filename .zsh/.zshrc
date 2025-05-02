# Main zsh configuration file
# Sources all modular configuration files

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Check for first run and install required utilities if needed
if [[ ! -f ~/.zsh/.setup_complete ]]; then
  echo "First run detected. Installing required utilities..."
  
  # Detect operating system
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - use Homebrew if available
    if command -v brew &>/dev/null; then
      echo "Installing utilities with Homebrew..."
      brew install dust lsd neovim bat fd duf
      
      # Source macOS-specific setup
      source ~/.zsh/macos_setup.zsh
    else
      echo "Homebrew not found. Please install manually: dust, lsd, neovim, bat, fd, duf"
    fi
  elif [[ -f /etc/debian_version ]]; then
    # Debian/Ubuntu
    if command -v apt &>/dev/null && sudo -n true 2>/dev/null; then
      echo "Installing utilities with apt..."
      sudo apt update
      sudo apt install -y dust lsd neovim bat fd-find duf
    else
      echo "Cannot install with apt. Please install manually: dust, lsd, neovim, bat, fd-find, duf"
    fi
  elif [[ -f /etc/fedora-release ]]; then
    # Fedora
    if command -v dnf &>/dev/null && sudo -n true 2>/dev/null; then
      echo "Installing utilities with dnf..."
      sudo dnf install -y dust lsd neovim bat fd duf
    else
      echo "Cannot install with dnf. Please install manually: dust, lsd, neovim, bat, fd, duf"
    fi
  elif [[ -f /etc/arch-release ]]; then
    # Arch Linux
    if command -v pacman &>/dev/null && sudo -n true 2>/dev/null; then
      echo "Installing utilities with pacman..."
      sudo pacman -S --noconfirm dust lsd neovim bat fd duf
    else
      echo "Cannot install with pacman. Please install manually: dust, lsd, neovim, bat, fd, duf"
    fi
  else
    echo "Unknown OS. Please install manually: dust, lsd, neovim, bat, fd, duf"
  fi
  
  # Create marker file to indicate setup is complete
  touch ~/.zsh/.setup_complete
  
  echo "First-run setup complete."
fi

# Source performance optimizations first
source ~/.zsh/performance.zsh

# Source all other configuration files
for config_file (~/.zsh/*.zsh); do
  if [[ "$config_file" != "$HOME/.zsh/macos_setup.zsh" && "$config_file" != "$HOME/.zsh/performance.zsh" ]]; then
    source $config_file
  fi
done

# Source local configuration if it exists (not in version control)
if [[ -f ~/.zsh/local.zsh ]]; then
  source ~/.zsh/local.zsh
fi