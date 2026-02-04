#!/bin/bash
# Link Spacemacs
if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
# TODO: Update Alfred to look in /usr/local/Cellar

# Set up iTerm2
# http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
# Note: chezmoi source dir is typically ~/.local/share/chezmoi
CHEZMOI_SOURCE="$(chezmoi source-path 2>/dev/null || echo "${HOME}/.local/share/chezmoi")"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${CHEZMOI_SOURCE}/configs"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Basic bash_profile setup
if [ ! -f ~/.bash_profile ]; then

    # Colors, aliases
    touch ~/.bash_profile
    echo "source ~/.bash/colors" >> ~/.bash_profile
    echo "source ~/.bash/alias" >> ~/.bash_profile

    # pyenv
    echo -e "\n# pyenv" >> ~/.bash_profile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    echo -e '\nif command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

    # NVM
    echo -e "\n# NVM" >> ~/.bash_profile
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bash_profile
    echo '. "/usr/local/opt/nvm/nvm.sh"' >> ~/.bash_profile
fi

# Python
pyenv install 3.6.4
pip install isort autoflake ipdb

# Javascript
mkdir -p ~/.nvm
yarn global add tern
