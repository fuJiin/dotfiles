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

# Install Doom Emacs
if [ ! -d "$DEV_HOME/.emacs.d" ]; then
    echo "Installing Doom Emacs..."
    sudo -u "$DEV_USER" git clone --depth 1 https://github.com/doomemacs/doomemacs "$DEV_HOME/.emacs.d"
    sudo -u "$DEV_USER" yes | "$DEV_HOME/.emacs.d/bin/doom" install
fi
