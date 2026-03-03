#!/bin/bash
set -euo pipefail

DEV_USER="dev"
DEV_HOME="/home/$DEV_USER"

# ── System packages (personal toolkit) ────────────────────────────

echo "Installing toolkit packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get install -y \
    fish \
    jq \
    ripgrep \
    fd-find \
    build-essential

# fd-find installs as fdfind on Ubuntu; symlink to fd
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi

# Set fish as default shell for dev user
chsh -s "$(command -v fish)" "$DEV_USER"

# Update cloud-init to use fish
cat > /etc/cloud/cloud.cfg.d/99-imir.cfg <<CLOUD
system_info:
  default_user:
    name: $DEV_USER
    shell: $(command -v fish)
    groups: [sudo]
    sudo: ALL=(ALL) NOPASSWD:ALL
CLOUD

# ── chezmoi ───────────────────────────────────────────────────────

if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
fi

if [ ! -d "$DEV_HOME/.local/share/chezmoi" ]; then
    echo "Applying chezmoi dotfiles..."
    sudo -Hu "$DEV_USER" chezmoi init --apply fuJiin/dotfiles
fi

# ── CLI tools ─────────────────────────────────────────────────────

# lazygit
if ! command -v lazygit &> /dev/null; then
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | tar xz -C /usr/local/bin lazygit
fi

# worktrunk
if ! command -v wt &> /dev/null; then
    echo "Installing worktrunk..."
    sudo -Hu "$DEV_USER" bash -c 'curl -fsSL https://github.com/max-sixty/worktrunk/releases/latest/download/worktrunk-installer.sh | sh'
fi

# uv (Python package manager)
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    sudo -Hu "$DEV_USER" bash -c 'curl -fsSL https://astral.sh/uv/install.sh | sh'
fi

# fnm (Node version manager)
if ! command -v fnm &> /dev/null; then
    echo "Installing fnm..."
    sudo -Hu "$DEV_USER" bash -c 'curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell'
fi
