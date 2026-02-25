# Disable greeting
set -g fish_greeting

# Colors
set -x CLICOLOR 1
set -x LSCOLORS GxFxCxDxBxegedabagaced

# Secrets (API keys, tokens, etc.)
test -f ~/.secrets; and source ~/.secrets

# Editor (prefer emacsclient if server is running, fall back to emacs)
set -x EDITOR "emacsclient -t -a emacs"
set -x VISUAL "emacsclient -c -a emacs"

# PATH
fish_add_path $HOME/.emacs.d/bin
fish_add_path $HOME/.local/bin

# pyenv
if test -d $HOME/.pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    status is-interactive; and pyenv init --path | source
end

# Rust
test -f $HOME/.cargo/env.fish; and source $HOME/.cargo/env.fish

# fnm (replaces nvm)
if command -q fnm
    fnm env | source
end

# bun
if test -d $HOME/.bun
    set -x BUN_INSTALL $HOME/.bun
    fish_add_path $BUN_INSTALL/bin
end

# Foundry (Forge, Cast, Anvil)
if test -d $HOME/.foundry/bin
    fish_add_path $HOME/.foundry/bin
end
