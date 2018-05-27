# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update Git
brew install git

# Install Homeshick
brew install homeshick

# Download dotfiles
homeshick clone fuJiin/dotfiles

# Install Homebrew bundle
homeshick cd dotfiles && brew bundle install

# Configure apps
sh ./configure.sh
