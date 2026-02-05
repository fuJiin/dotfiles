My dotfiles. Managed with [chezmoi](https://www.chezmoi.io/).

### Installation

```bash
# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply fuJiin/dotfiles
```

Or if chezmoi is already installed:

```bash
chezmoi init --apply fuJiin/dotfiles
```

### Post-install

Set fish as the default shell (requires password):

```bash
# Add fish to allowed shells (if not already present)
grep -q /usr/local/bin/fish /etc/shells || echo /usr/local/bin/fish | sudo tee -a /etc/shells

# Set as default shell
chsh -s /usr/local/bin/fish
```

### Common Commands

```bash
chezmoi cd                  # Go to source directory
chezmoi edit <file>         # Edit a managed file
chezmoi diff                # Preview changes
chezmoi apply               # Apply changes
chezmoi update              # Pull latest and apply
```
