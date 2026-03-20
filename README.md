# dotfiles

Config files for bootstrapping a new Mac development environment.

## File Map

| Repo path | Destination | Description |
|---|---|---|
| `shell/zshrc` | `~/.zshrc` | Oh My Zsh config (robbyrussell theme, asdf + git plugins, SSH agent) |
| `shell/zprofile` | `~/.zprofile` | Homebrew shell environment |
| `git/gitconfig` | `~/.gitconfig` | Git user info, default branch |
| `git/ignore` | `~/.config/git/ignore` | Global gitignore |
| `claude/settings.json` | `~/.claude/settings.json` | Claude Code settings |
| `cursor/argv.json` | `~/.cursor/argv.json` | Cursor launch arguments |
| `cursor/cli-config.json` | `~/.cursor/cli-config.json` | Cursor CLI config |
| `Brewfile` | _(used in place)_ | Homebrew formulae, casks, and Cursor extensions |
| `apps.md` | _(reference)_ | Manually installed apps not in Homebrew |

## Setup

See [BOOTSTRAP.md](BOOTSTRAP.md) for the full setup guide.

## What's excluded

- `~/.ssh/` — secrets, managed via 1Password
- `.env` files — project-specific secrets
- `~/.aws/` — credentials
- Oh My Zsh itself — installed via its own script
- Cursor extensions — managed via Brewfile `vscode` entries
