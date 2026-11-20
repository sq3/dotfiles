{ config, lib, pkgs, ... }:
let
  # Out-of-store links: edits in ~/dotfiles take effect immediately, and apps
  # that write their config (lazy-lock.json, gh) write back into the repo
  repo = "${config.home.homeDirectory}/dotfiles/home";
  link = path: { source = config.lib.file.mkOutOfStoreSymlink "${repo}/${path}"; };

  homeFiles = [
    ".zshrc"
    ".p10k.zsh"
    ".gitconfig"
    ".gitignore"
    ".tmux.conf"
    ".vimrc"
    ".vim"
    ".claude/statusline-command.sh"
    ".claude/output-styles"
  ];

  configFiles = [
    "aerospace"
    "wezterm"
    "nvim"
    "git/ignore"
    "gh/config.yml"
    "opencode/opencode.jsonc"
    "herdr/config.toml"
  ];

  # Cloned on first activation only; they update themselves afterwards
  clones = {
    ".oh-my-zsh" = "https://github.com/ohmyzsh/ohmyzsh.git";
    ".oh-my-zsh/custom/themes/powerlevel10k" = "https://github.com/romkatv/powerlevel10k.git";
    ".oh-my-zsh/custom/plugins/zsh-autosuggestions" = "https://github.com/zsh-users/zsh-autosuggestions.git";
    ".tmux/plugins/tpm" = "https://github.com/tmux-plugins/tpm.git";
  };
in
{
  imports = [ ./skills.nix ];

  home.username = "ms";
  home.homeDirectory = "/Users/ms";
  home.stateVersion = "25.11";

  # CLI tools no longer available in Homebrew
  home.packages = [ pkgs.tflint ];

  home.file = lib.genAttrs homeFiles link;
  xdg.configFile = lib.genAttrs configFiles (p: link ".config/${p}");

  home.activation.cloneShellPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    lib.concatStrings (lib.mapAttrsToList (dir: url: ''
      if [ ! -e "$HOME/${dir}" ]; then
        run ${pkgs.git}/bin/git clone --depth 1 ${url} "$HOME/${dir}"
      fi
    '') clones)
  );

  # The repo is public: keep the gitleaks hooks from .pre-commit-config.yaml installed
  home.activation.installDotfilesHooks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/dotfiles/.git" ] && [ -x /opt/homebrew/bin/pre-commit ]; then
      (cd "$HOME/dotfiles" && run /opt/homebrew/bin/pre-commit install)
    fi
  '';
}
