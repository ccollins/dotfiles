# Bootstrap a New Mac

Step-by-step guide to set up a fresh Mac from this dotfiles repo. Written so Claude (or a human) can follow it end-to-end.

## Quick Start

The `bootstrap.sh` script automates steps 1-9 below. On a fresh Mac:

```bash
git clone https://github.com/chuckcollins/dotfiles.git ~/dotfiles
~/dotfiles/bootstrap.sh
```

The script is idempotent — safe to re-run. After it finishes, complete the manual steps in step 10.

## Prerequisites

- macOS with admin access
- Internet connection
- Access to 1Password for SSH keys and secrets

## Manual Steps (Reference)

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Clone this repo

```bash
git clone git@github.com:chuckcollins/dotfiles.git ~/dotfiles
```

> If SSH isn't set up yet, use HTTPS first and switch later:
> `git clone https://github.com/chuckcollins/dotfiles.git ~/dotfiles`

### 3. Install Homebrew packages

```bash
brew bundle --file=~/dotfiles/Brewfile
```

This installs CLI tools, casks, and Cursor extensions.

### 4. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5. Copy shell configs

```bash
cp ~/dotfiles/shell/zshrc ~/.zshrc
cp ~/dotfiles/shell/zprofile ~/.zprofile
source ~/.zprofile
source ~/.zshrc
```

### 6. Copy git configs

```bash
cp ~/dotfiles/git/gitconfig ~/.gitconfig
mkdir -p ~/.config/git
cp ~/dotfiles/git/ignore ~/.config/git/ignore
```

### 7. Install asdf plugins and runtimes

asdf is installed via Homebrew. Add language plugins:

```bash
asdf plugin add ruby
asdf plugin add nodejs
```

Then install the versions needed for your projects (check each project's `.tool-versions`):

```bash
# Example:
asdf install ruby 3.3.6
asdf install nodejs 22.12.0
```

### 8. Copy Claude settings

```bash
mkdir -p ~/.claude
cp ~/dotfiles/claude/settings.json ~/.claude/settings.json
```

### 9. Copy Cursor settings

```bash
mkdir -p ~/.cursor
cp ~/dotfiles/cursor/argv.json ~/.cursor/argv.json
cp ~/dotfiles/cursor/cli-config.json ~/.cursor/cli-config.json
```

### 10. Manual steps

These can't be automated:

- **SSH keys**: Set up via 1Password SSH agent, or generate new keys and add to GitHub
- **AWS credentials**: Configure via `aws configure` or copy from 1Password
- **Apps**: Install apps listed in `apps.md` that aren't covered by the Brewfile
- **macOS preferences**: Dock, keyboard repeat rate, trackpad settings, etc.
- **puma-dev**: Run `sudo puma-dev -setup` and `puma-dev -install` for local HTTPS development
- **1Password CLI**: Sign in with `op signin` to enable secrets in `bin/setup`

## Verification

After setup, confirm:

- `brew doctor` reports no issues
- `git config user.email` returns `chuck.collins@gmail.com`
- `ruby --version` and `node --version` return expected versions
- `ssh -T git@github.com` authenticates successfully
