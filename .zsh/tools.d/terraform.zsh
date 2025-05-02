# Terraform initialization
# This file is sourced by .zshrc to initialize Terraform if it's installed

# Initialize Terraform completion if it's installed
if command -v terraform &>/dev/null; then
  # Use zsh's built-in completion system instead of bash's complete command
  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit
  terraform -install-autocomplete
  
  # Add some useful Terraform aliases
  alias tf="terraform"
  alias tfi="terraform init"
  alias tfp="terraform plan"
  alias tfa="terraform apply"
  alias tfd="terraform destroy"
  alias tfo="terraform output"
  alias tfs="terraform state"
  alias tfsl="terraform state list"
  alias tfss="terraform state show"
  alias tfv="terraform validate"
  alias tfw="terraform workspace"
  
  # Function to select Terraform workspace
  tfws() {
    if [ -z "$1" ]; then
      terraform workspace show
      return
    fi
    terraform workspace select "$1"
  }
fi