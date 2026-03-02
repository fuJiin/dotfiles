# === CROSS-PLATFORM ===

# Shell
brew "fish"

# Search
brew "ripgrep"
brew "fd"

# Git
brew "lazygit"
brew "gh"

# Dev tools
brew "worktrunk"

# Cloud / Infra
brew "hcloud"

# Language runtimes
brew "pyenv"
brew "fnm"

# === macOS ONLY ===

if OS.mac?
  cask_args appdir: "/Applications"

  # Terminal
  cask "ghostty"

  # Editor
  tap "d12frosted/emacs-plus"
  brew "emacs-plus", args: ["with-native-comp"]

  # QoL Apps
  cask "alfred"
  cask "1password"
  cask "macdown-3000"
  cask "rectangle"
  cask "spotify"

  # Keep system awake
  brew "mas"
  mas "Amphetamine", id: 937984704
end
