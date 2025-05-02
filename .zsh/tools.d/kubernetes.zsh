# Kubernetes tools initialization
# This file is sourced by .zshrc to initialize kubectl and related tools if they're installed

# Initialize kubectl completion if it's installed
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  alias k=kubectl
  complete -F __start_kubectl k
fi

# Initialize helm completion if it's installed
if command -v helm &>/dev/null; then
  source <(helm completion zsh)
fi

# Initialize kubectx and kubens completion if they're installed
if command -v kubectx &>/dev/null; then
  alias kctx=kubectx
  alias kns=kubens
fi

# Initialize kustomize completion if it's installed
if command -v kustomize &>/dev/null; then
  source <(kustomize completion zsh)
fi