# Custom shell functions

# Function to create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Function to extract various archive formats
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Function to find files by name
ff() {
  if command -v fd &>/dev/null; then
    fd "$@"
  else
    find . -name "*$@*" 2>/dev/null
  fi
}

# Function to search file contents
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a search term"
    return 1
  fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Function to set KUBECONFIG to include all YAML files in ~/.kube
setup_kubeconfig() {
  if [ -d "$HOME/.kube" ]; then
    # Find all YAML files in ~/.kube
    local kube_configs=()
    for config in "$HOME/.kube"/*.y{a,}ml; do
      # Check if file exists and is readable
      if [ -f "$config" ] && [ -r "$config" ]; then
        kube_configs+=("$config")
      fi
    done
    
    # If we found any config files, set KUBECONFIG
    if [ ${#kube_configs[@]} -gt 0 ]; then
      export KUBECONFIG=$(IFS=:; echo "${kube_configs[*]}")
      echo "KUBECONFIG set to include ${#kube_configs[@]} files from ~/.kube"
    else
      echo "No Kubernetes config files found in ~/.kube"
    fi
  else
    echo "~/.kube directory not found"
  fi
}

# Automatically set up KUBECONFIG on shell startup
setup_kubeconfig