# AGENTS.md

macOS dotfiles for one machine (host `mbp`, user `ms`), managed with nix-darwin + home-manager. Apps come from Homebrew via the `Brewfile`. See `README.md` for the file layout.

## This repo is public

- Never commit secrets: tokens, private keys, passwords, internal hostnames, customer or employer names. Secrets come from 1Password (`op`) at runtime.
- gitleaks runs on every commit and push (`.pre-commit-config.yaml`) and in CI (`.github/workflows/gitleaks.yml`). Never bypass it with `--no-verify`. If it flags something, remove the value; only add to `.gitleaksignore` when it is verifiably fake, with a comment.
- Before copying an app's config into `home/`, check it for tokens or account data. Example: `gh/hosts.yml` holds the token and stays out; `gh/config.yml` is safe.

## How changes take effect

- Files in `home/` are out-of-store symlinks into `$HOME`. Edits are live immediately, and apps writing their config (nvim `lazy-lock.json`, gh) write back into the repo. Expect such diffs.
- Adding a new file under `home/` also needs an entry in `homeFiles` or `configFiles` in `home.nix`.
- Changes to `*.nix` or `Brewfile` need a rebuild:
  - Check without sudo: `darwin-rebuild build --flake ~/dotfiles#mbp`
  - Apply (needs sudo/Touch ID, leave to the user): `sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/dotfiles#mbp`
- Flakes only see files tracked by git: `git add` new files before building.

## Conventions

- `Brewfile` is the source of truth for apps and CLI tools; use Nix (`home.packages`) only for tools Homebrew dropped.
- macOS settings go into `darwin.nix` (or `menubar.nix` for menu bar), not into `defaults write` scripts.
- Agent skills are flake inputs mapped in `skills.nix`.
- Commit messages: short imperative subject, optionally prefixed with the area (`Brewfile: …`, `README: …`).
