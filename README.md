# Zsh Modular Configuration

A comprehensive modular Zsh setup for improved performance and maintainability.

## Features

- Modular configuration with separate files for different aspects of Zsh
- Performance optimizations for faster shell startup
- Plugin management with Antigen
- Powerlevel10k theme
- Automatic tool installation
- And more!

## Installation

```bash
# Clone the repository
git clone https://github.com/kentmartin73/zshrc.git

# Run the installation script
cd zshrc
./install.sh
```

**Note:** Do not run the installation script from within iTerm2. The script will modify iTerm2 settings, so it should be run from another terminal like the built-in Terminal app.

## GitHub Actions Workflow

This repository includes a GitHub Actions workflow that automatically updates the version information in `.zsh/.zshrc` whenever changes are pushed to the main branch. The workflow:

1. Gets the committer's name from the latest commit
2. Uses the tag if available, otherwise uses the commit SHA
3. Updates the version information in `.zsh/.zshrc`
4. Commits and pushes the changes back to the repository

### Setup Requirements

For the GitHub Actions workflow to work properly:

1. Make sure GitHub Actions is enabled for your repository (Settings > Actions > General)
2. The workflow requires write permissions to the repository contents, which is configured in the workflow file
3. If you have branch protection rules, you may need to:
   - Add an exception for the GitHub Actions bot
   - Or use a Personal Access Token with appropriate permissions

### Creating Releases

To create a release with a tag:

```bash
# Create and push a tag
git tag v1.0.0
git push origin v1.0.0

# Or create a release through the GitHub web interface
# GitHub > Your Repository > Releases > Create a new release
```

When you create a release with a tag, the workflow will use that tag in the version information instead of the commit SHA.