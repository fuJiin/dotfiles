My dotfiles. Install with [homeshick](https://github.com/andsens/homeshick). See instructions below.

### Installation

`bash <(curl -s https://raw.github.com/fuJiin/dotfiles/.install.sh)`

### Usage

Most of the packages should work out of the box if the relevant software is installed. i.e. Spacemacs will use .spacemacs and .spacemacs-layers, and [Leiningen](http://leiningen.org/) will use .lein.

The exception are the bash files, which are found inside `~/.bash`. The current setup leaves `~/.bash_profile` (or `~/.bashrc`) alone, and defers to the user to source the bash dotfiles they want. Link to these directly by calling `source ~/.bash/xyz`.
