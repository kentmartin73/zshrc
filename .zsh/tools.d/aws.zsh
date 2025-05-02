# AWS CLI initialization
# This file is sourced by .zshrc to initialize AWS CLI if it's installed

# Initialize AWS CLI completion if it's installed
if command -v aws &>/dev/null; then
  complete -C aws_completer aws
  
  # Add some useful AWS aliases
  alias awslocal="aws --endpoint-url=http://localhost:4566"
  alias awswhoami="aws sts get-caller-identity"
  
  # Function to switch AWS profiles
  aws-profile() {
    if [ -z "$1" ]; then
      echo "Current AWS profile: $AWS_PROFILE"
      return
    fi
    export AWS_PROFILE="$1"
    echo "Switched to AWS profile: $AWS_PROFILE"
  }
  
  # Function to list available AWS profiles
  aws-profiles() {
    grep '\[profile' ~/.aws/config | sed -e 's/\[profile \(.*\)\]/\1/g'
  }
fi