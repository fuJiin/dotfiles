# Install Homebrew
if [ ! -f /usr/local/bin/brew ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Git
brew install git

# Install Homeshick
brew install homeshick

# Download dotfiles
homeshick clone fuJiin/dotfiles
homeshick cd dotfiles

# Install Homebrew bundle
brew bundle install --file ./Brewfile --describe || true

# Configure apps
sh ./configure.sh
