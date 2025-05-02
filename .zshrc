
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ensure Antigen is installed via Homebrew
if ! brew list antigen &>/dev/null; then
  echo "Installing Antigen with Homebrew..."
  brew install antigen
fi

# Load Antigen
source /opt/homebrew/share/antigen/antigen.zsh

# Antigen plugins
antigen bundle command-not-found
antigen bundle z-shell/F-Sy-H --branch=main
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle dirpersist
antigen bundle history-substring-search
antigen bundle agkozak/zsh-z
antigen bundle trystan2k/zsh-tab-title
antigen theme romkatv/powerlevel10k
antigen bundle marlonrichert/zsh-autocomplete@22.02.21
antigen bundle zdharma-continuum/history-search-multi-word
antigen apply

# Prompt helpers
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.alias
