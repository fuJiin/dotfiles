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
until it is explicitly trusted. Run this once before the first `brew bundle`:

```bash
brew trust d12frosted/emacs-plus
```

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

#### SSH key

`run_once_01-install.sh` creates `~/.ssh/id_ed25519` if it does not already
exist, commented with the work email when the machine has one and the default
email otherwise. It is generated **without a passphrase** because the script is
non-interactive; add one immediately:

```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
```

With `UseKeychain yes` (set in `~/.ssh/config`) macOS stores the passphrase in
the keychain, so this costs nothing at use time. Remember to register the public
key with GitHub and any hosts you reach over SSH.

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

### Common Commands

```bash
chezmoi cd                  # Go to source directory
chezmoi edit <file>         # Edit a managed file
chezmoi diff                # Preview changes
chezmoi apply               # Apply changes
chezmoi update              # Pull latest and apply
chezmoi apply --exclude=scripts   # Apply files without running scripts
```
