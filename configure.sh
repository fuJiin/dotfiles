# Link Spacemacs
if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
# TODO: Update Alfred to look in /usr/local/Cellar

# Set up iTerm2
# http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.homesick/repos/dotfiles/configs/com.googlecode.iterm2.plist"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
