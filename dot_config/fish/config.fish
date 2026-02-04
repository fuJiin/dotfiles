# Colors
set -x CLICOLOR 1
set -x LSCOLORS GxFxCxDxBxegedabagaced

# Secrets (API keys, tokens, etc.)
test -f ~/.secrets; and source ~/.secrets

# PATH
fish_add_path $HOME/.emacs.d/bin
fish_add_path $HOME/.local/bin

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
status is-interactive; and pyenv init --path | source

# Rust
test -f $HOME/.cargo/env.fish; and source $HOME/.cargo/env.fish

# fnm (replaces nvm)
fnm env | source

# bun
set -x BUN_INSTALL $HOME/.bun
fish_add_path $BUN_INSTALL/bin
