#!/bin/bash
set -euo pipefail

DEV_USER="dev"
DEV_HOME="/home/$DEV_USER"

# Install chezmoi and apply dotfiles
if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
fi

if [ ! -d "$DEV_HOME/.local/share/chezmoi" ]; then
    echo "Applying chezmoi dotfiles..."
    sudo -u "$DEV_USER" chezmoi init --apply fuJiin/dotfiles
fi

# Install CLI tools
# lazygit
if ! command -v lazygit &> /dev/null; then
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | sudo tar xz -C /usr/local/bin lazygit
fi

# gh (GitHub CLI)
if ! command -v gh &> /dev/null; then
    echo "Installing gh..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update && sudo apt-get install -y gh
fi

# worktrunk
if ! command -v wt &> /dev/null; then
    echo "Installing worktrunk..."
    sudo -u "$DEV_USER" bash -c 'curl -fsSL https://github.com/max-sixty/worktrunk/releases/latest/download/worktrunk-installer.sh | sh'
fi

# uv (Python package manager)
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    sudo -u "$DEV_USER" sh -c "$(curl -fsSL https://astral.sh/uv/install.sh)"
fi

# fnm (Node version manager)
if ! command -v fnm &> /dev/null; then
    echo "Installing fnm..."
    sudo -u "$DEV_USER" bash -c 'curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell'
fi
