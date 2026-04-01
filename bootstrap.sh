#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

info() { printf "\n\033[1;34m==> %s\033[0m\n" "$1"; }
success() { printf "\033[1;32m    %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m    %s\033[0m\n" "$1"; }

# --- Homebrew ---
info "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  success "Homebrew already installed"
fi

# --- Brew bundle ---
info "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock

# --- Oh My Zsh ---
info "Checking Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  success "Oh My Zsh already installed"
fi

# --- Shell configs ---
info "Copying shell configs..."
cp "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
cp "$DOTFILES_DIR/shell/zprofile" "$HOME/.zprofile"
success "Copied .zshrc and .zprofile"

# --- Git configs ---
info "Copying git configs..."
cp "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config/git"
cp "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"
success "Copied .gitconfig and global gitignore"

# --- asdf plugins ---
info "Setting up asdf plugins..."
if command -v asdf &>/dev/null; then
  asdf plugin add ruby 2>/dev/null || success "ruby plugin already installed"
  asdf plugin add nodejs 2>/dev/null || success "nodejs plugin already installed"
else
  warn "asdf not found — run 'source ~/.zprofile' then re-run this script, or install asdf plugins manually"
fi

# --- Claude settings ---
info "Copying Claude settings..."
mkdir -p "$HOME/.claude"
cp "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
cp "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
success "Copied Claude settings"

# --- Cursor settings ---
info "Copying Cursor settings..."
mkdir -p "$HOME/.cursor"
cp "$DOTFILES_DIR/cursor/argv.json" "$HOME/.cursor/argv.json"
cp "$DOTFILES_DIR/cursor/cli-config.json" "$HOME/.cursor/cli-config.json"
success "Copied Cursor settings"

# --- Done ---
info "Bootstrap complete!"
echo ""
echo "  Manual steps remaining:"
echo "    - Set up SSH keys via 1Password"
echo "    - Configure AWS credentials (aws configure)"
echo "    - Install apps from apps.md"
echo "    - Run: sudo puma-dev -setup && puma-dev -install"
echo "    - Sign into 1Password CLI: op signin"
echo "    - Install asdf runtimes: asdf install ruby <version> && asdf install nodejs <version>"
echo ""
echo "  Verify with:"
echo "    brew doctor"
echo "    git config user.email"
echo "    ssh -T git@github.com"
echo ""
