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

### Per-machine configuration

**No email addresses or machine-specific values live in this repo.** `chezmoi
init` prompts for them and writes the answers to `~/.config/chezmoi/chezmoi.toml`,
which is local to each machine and never committed.

| Prompt | Key | Used by |
| --- | --- | --- |
| Git author name | `git.name` | `~/.gitconfig`, `~/.doom.d/config.el` |
| Git email (default identity) | `git.email` | `~/.gitconfig`; SSH key comment when no work email |
| Work repo directory | `git.workDir` | blank for none; e.g. `~/Code/` |
| Work git email | `git.workEmail` | repos under `git.workDir` |
| Emacs/Doom user-mail-address | `doom.email` | `~/.doom.d/config.el` (defaults to `git.email`) |
| Personal machine? | `personal` | `true` also installs consumer apps (see Brewfile) |

The prompts only fire for keys that are not already set, so re-running
`chezmoi init` is safe and will not re-ask.

To change a value later, edit the file and re-apply:

```bash
$EDITOR ~/.config/chezmoi/chezmoi.toml
chezmoi apply
```

#### GitHub email privacy

If the GitHub account has **Keep my email addresses private** enabled, pushing
commits authored with a real address fails on every push:

```
remote: error: GH007: Your push would publish a private email address.
```

Set `git.email` to the account's noreply alias, which is
`<user-id>+<username>@users.noreply.github.com`:

```bash
gh api user --jq '"\(.id)+\(.login)@users.noreply.github.com"'
```

Commits already made with the wrong address have to be rewritten, not just
reconfigured — git records the author at commit time:

Use `if`/`fi` rather than `[ ... ] && export` here: the `&&` form exits
non-zero whenever an address does *not* match, which aborts the filter.

```bash
OLD="old@example.com"
NEW="$(gh api user --jq '"\(.id)+\(.login)@users.noreply.github.com"')"

FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch -f --env-filter "
    if [ \"\$GIT_AUTHOR_EMAIL\" = \"$OLD\" ]; then
        export GIT_AUTHOR_EMAIL=\"$NEW\"
    fi
    if [ \"\$GIT_COMMITTER_EMAIL\" = \"$OLD\" ]; then
        export GIT_COMMITTER_EMAIL=\"$NEW\"
    fi
" origin/main..main
```

This rewrites history, so it needs a force-push if the commits were already
pushed. Rewriting only `origin/main..main` — the unpushed range — avoids that.

#### Two git identities

When `git.workDir` and `git.workEmail` are both set, `~/.gitconfig` gets an
`includeIf` pointing at `~/.gitconfig-work`, so repos under that directory
commit with the work address and everything else uses the default one.

Note that git has no way to *unset* an identity, so there is no configuration
that makes git refuse to commit in an unconfigured directory while still having
a global default — whatever is in `[user]` always applies as a fallback. Verify
with `git -C <repo> config user.email` if in doubt.

#### Work vs. personal machines

`personal = false` (the default) keeps consumer apps — Spotify, Alfred,
1Password, Rectangle, MacDown, and Amphetamine via the Mac App Store — out of
the Brewfile entirely. Set it to `true` on a personal machine. The package list
lives in `.chezmoitemplates/Brewfile` and is rendered into
`run_onchange_brew-bundle.sh`, so changing either the list or the flag
re-triggers `brew bundle` on the next apply.

### Post-install

#### Emacs

`emacs-plus` comes from a third-party tap, which recent Homebrew will not load
until it is explicitly trusted. `run_onchange_after_02-brew-bundle.sh` now runs
`brew trust` for every tap the Brewfile declares, so this needs no manual step.

**If the Emacs source download times out**, the formula pulls from
`ftpmirror.gnu.org`, which some corporate networks block outright (the symptom
is `curl: (28) SSL connection timeout`, with the connection never establishing).
Seed Homebrew's cache from a reachable GNU mirror instead — the checksum is
verified against the formula, so a mirror is safe:

```bash
VER=31.1
SHA=$(brew info --json=v2 d12frosted/emacs-plus/emacs-plus \
      | python3 -c "import json,sys;print(json.load(sys.stdin)['formulae'][0]['urls']['stable']['checksum'])")
DEST=$(brew --cache --formula d12frosted/emacs-plus/emacs-plus)

curl -fsSL -o "$DEST" "https://mirrors.kernel.org/gnu/emacs/emacs-$VER.tar.xz"
echo "$SHA  $DEST" | shasum -a 256 -c - && brew install d12frosted/emacs-plus/emacs-plus
```

#### A cask that installed but is not recorded

`brew bundle` can leave a cask half-installed: the app is copied into
`/Applications`, but a later step fails, so nothing is written to
`$(brew --prefix)/Caskroom` and Homebrew still reports it as missing. Every
later `brew bundle` then fails on it. This happens most easily in a
non-interactive session, because some casks run a `chgrp` under `sudo` and
there is no one to type a password.

Do **not** delete the app and reinstall. If the installed version matches the
cask version, adopt it — Homebrew writes the missing record, re-uses the app in
place, and leaves its preferences alone:

```bash
brew install --cask --adopt rectangle
```

`--adopt` refuses to combine with `--force`, and only adopts artifacts that are
identical to what it would install, so it is the safe option rather than the
shortcut. Compare versions first if unsure:

```bash
/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' \
    /Applications/Rectangle.app/Contents/Info.plist
brew info --json=v2 --cask rectangle | jq -r '.casks[0].version'
```

#### SSH key

`run_once_01-install.sh` creates `~/.ssh/id_ed25519` if it does not already
exist, commented with the work email when the machine has one and the default
email otherwise. It is generated **without a passphrase** because the script is non-interactive.
Whether to add one is a judgement call rather than an automatic yes:

```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
```

With FileVault on, a powered-off machine will not give up the key, and
`UseKeychain yes` (set in `~/.ssh/config`) means the passphrase lives in the
login keychain anyway — so it adds little against anything already running as
you. What it does protect is the key file *leaving* the machine readable: an
unencrypted Time Machine target, a synced folder, a copied `~/.ssh`. Worth it
for a key that reaches hosts which are painful to re-key; skippable for one
that only reaches a box where you can edit `authorized_keys` in a minute.

Register the public key with any hosts you reach over SSH. GitHub does not need
it if you authenticate with `gh auth login` over HTTPS, which stores a token in
the keychain and leaves the remote URLs alone.

#### Set fish as the default shell

`brew --prefix` is used here because Homebrew lives at `/opt/homebrew` on Apple
Silicon and `/usr/local` on Intel:

```bash
FISH="$(brew --prefix)/bin/fish"
grep -qx "$FISH" /etc/shells || echo "$FISH" | sudo tee -a /etc/shells
chsh -s "$FISH"
```

Ghostty is configured to launch fish directly, so it picks the right binary for
the architecture without needing `chsh`.

### Auditing the Brewfile

`brewfile-audit` (installed to `~/.local/bin`) checks the package list against
Homebrew and against what the configs in this repo actually depend on:

```bash
brewfile-audit           # full report
brewfile-audit --quiet   # only problems; exits non-zero on failure, for CI
```

It runs three independent checks, reported separately so a failure tells you
which kind of drift you are looking at:

| Check | What it catches | Fails the run? |
| --- | --- | --- |
| `RESOLVE` | Brewfile entries that no longer exist in Homebrew — renamed, deprecated or dropped upstream | yes |
| `DEPENDS` | A tool a managed config hard-requires that the Brewfile never installs | yes |
| `ADVISE` | Newer alternatives worth knowing about | no, informational |

`RESOLVE` renders the Brewfile through `chezmoi execute-template` rather than
reading it off disk, so the `personal` gate is applied the same way `brew
bundle` sees it. A formula from a declared tap that is not added yet reports as
`skip`, not a failure — otherwise the check would always fail on a machine that
has not run `brew bundle`.

`DEPENDS` exists because of a bug class this repo is specifically prone to: on
Linux, `run_once_before_01-install.sh` apt-installs a handful of tools, and it
is easy to add a config that depends on one of them without noticing that the
macOS path never installs it. `jq` and `tmux` both went missing on macOS that
way — `jq` being the worse case, since `modify_dot_claude/settings.json.tmpl`
pipes through it *during `chezmoi apply` itself*.

When a config starts shelling out to something new, add a row to the `REQUIRED`
table in the script. Tools the configs already guard with `command -q` (docker,
lein, shadow-cljs, bun, foundry) are deliberately excluded and listed as such
in a comment.

### Script ordering

The scripts are numbered and carry explicit `before_`/`after_` attributes,
because the default ordering is alphabetical across *all* targets — which put
`.claude/**` (and its jq-dependent `modify_` script) ahead of the script that
installs jq, and put the Doom install ahead of the Emacs it needs.

| Script | When | Does |
| --- | --- | --- |
| `run_once_before_01-install.sh` | before any file is applied | Homebrew, git, **jq**, SSH key |
| `run_onchange_after_02-brew-bundle.sh` | after files | trusts taps, `brew bundle` |
| `run_once_after_03-configure.sh` | after packages exist | clones Doom, `doom install` |
| `run_onchange_after_04-install-codex.sh` | last | `install-codex --upgrade` |

If you renumber or rename one of these, chezmoi treats it as a new script and
`run_once_` entries will execute again. All of them are idempotent, so that is
safe, but it is why the numbers are padded.

### Common Commands

```bash
chezmoi cd                  # Go to source directory
chezmoi edit <file>         # Edit a managed file
chezmoi diff                # Preview changes
chezmoi apply               # Apply changes
chezmoi update              # Pull latest and apply
chezmoi apply --exclude=scripts   # Apply files without running scripts
brewfile-audit                    # Check the package list for drift
```
