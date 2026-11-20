# My Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). Third-party code (oh-my-zsh, powerlevel10k, tpm) is fetched via `.chezmoiexternal.toml`, not vendored.

## Setup

```sh
brew install chezmoi
chezmoi init sq3
chezmoi diff        # review
chezmoi apply
brew bundle --file="$(chezmoi source-path)/Brewfile"
```

## What's inside

| Area | Files |
| --- | --- |
| Shell | `~/.zshrc`, `~/.p10k.zsh` (oh-my-zsh + powerlevel10k) |
| Git | `~/.gitconfig` (SSH signing via 1Password), `~/.gitignore`, `~/.config/git/ignore`, `~/.config/gh/config.yml` |
| Window manager | `~/.config/aerospace` (AeroSpace + helper scripts), `~/.config/sketchybar` |
| Terminal | `~/.config/wezterm/wezterm.lua`, `~/.tmux.conf` |
| Editors | `~/.config/nvim` (LazyVim), `~/.vimrc` |
| macOS system | `~/.config/nix-darwin/flake.nix` |
| AI tooling | `~/.claude/statusline-command.sh`, `~/.claude/output-styles`, `~/.config/opencode`, `~/.config/herdr` |
| Packages | `Brewfile` |

Secrets are never committed; they come from 1Password (`op`) at runtime.

## Screenshot
![screenshot](Screenshot.png)
