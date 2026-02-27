#!/bin/bash
set -euo pipefail

DEV_USER="dev"
DEV_HOME="/home/$DEV_USER"

# Install Doom Emacs
if [ ! -d "$DEV_HOME/.emacs.d" ]; then
    echo "Installing Doom Emacs..."
    sudo -u "$DEV_USER" git clone --depth 1 https://github.com/doomemacs/doomemacs "$DEV_HOME/.emacs.d"
    sudo -u "$DEV_USER" yes | "$DEV_HOME/.emacs.d/bin/doom" install
fi
