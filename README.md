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

### Usage

Most of the packages should work out of the box if the relevant software is installed. i.e. Spacemacs will use .spacemacs and [Leiningen](http://leiningen.org/) will use .lein.

The exception are the bash files, which are found inside `~/.bash`. The current setup leaves `~/.bash_profile` (or `~/.bashrc`) alone, and defers to the user to source the bash dotfiles they want. Link to these directly by calling `source ~/.bash/xyz`.

### Common Commands

```bash
chezmoi cd                  # Go to source directory
chezmoi edit ~/.bashrc      # Edit a managed file
chezmoi diff                # Preview changes
chezmoi apply               # Apply changes
chezmoi update              # Pull latest and apply
```
