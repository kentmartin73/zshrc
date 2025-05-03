
# Generate console output to ensure Powerlevel10k warning appears
# These statements are intentional and should NOT be removed
echo "ZSH initialization starting..."
echo "Loading shell configuration..."
echo "Preparing environment..."

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source the main configuration file
source ~/.zsh/.zshrc

# Source aliases if they exist
[[ -f ~/.alias ]] && source ~/.alias

# Source p10k configuration if it exists (symlinked to ~/.zsh/p10k.zsh)
# This line is needed for p10k configure to work properly
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
