# Chezmoi
alias cz "chezmoi"

# Git
alias lg "lazygit"
alias gl "git log --pretty=oneline --abbrev-commit --graph"
alias gcp "git cherry-pick"
alias gpp "git checkout main && git pull && git fetch -p && gbp"

# Docker
alias dx "docker exec"

# tmux
alias tmx "tmux -CC attach || tmux -CC"

# Ghostty
alias gt "ghostty"

# Python
alias python "python3"
alias pip "pip3"
alias ipn "ipython notebook"
alias pa "source env/bin/activate.fish"

# XCode
alias xc "open ./*.xcworkspace"

# Clojure
alias lrx "test -f ./.nrepl-port; and lein repl :connect; or lein repl"
alias lx "lein exec"
alias ljs "lein cljsbuild"
alias sdw "shadow-cljs"

# Claude
alias cc "claude"
alias ccd "claude --dangerously-skip-permissions"

# Search
if command -q rg
    alias grep "rg --hidden"
end

if command -q fd
    alias find "fd"
end

# Misc
alias flushdns "dscacheutil -flushcache"

# GitHub API token
if test -f ~/.github/api_token.txt
    set -x HOMEBREW_GITHUB_API_TOKEN (cat ~/.github/api_token.txt)
end

# Delete branches that are gone from remote AND merged branches
function gbp
    # Delete branches that are gone from remote (force delete)
    git branch -vv | awk '/: gone]/ {print $1}' | xargs git branch -D 2>/dev/null
    # Delete merged branches (safe delete, excluding current, main, and develop)
    git branch --merged | grep -Ev '(\*|main|develop)' | xargs -n 1 git branch -d 2>/dev/null
end

# SSH with tmux attach
function cch
    ssh $argv -t 'tmux -CC attach || tmux -CC'
end

# Find PID taking up a port
function port
    lsof -n -i:$argv[1] | grep LISTEN
end
