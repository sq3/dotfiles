{
  description = "MS Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # Minimal system packages for nix dev environments
      environment.systemPackages = with pkgs; [
        # Only essential dev environment tools
        direnv
        nix-direnv
      ];

      # System configuration and settings
      system = {
        defaults = {
          # Dock settings
          dock = {
            autohide = true;
            mru-spaces = false;
            minimize-to-application = true;
          };
          
          # Finder settings
          finder = {
            AppleShowAllExtensions = true;
            FXPreferredViewStyle = "clmv"; # Column view
            ShowPathbar = true;
            ShowStatusBar = true;
          };
          
          # Trackpad settings
          trackpad = {
            Clicking = true; # Tap to click
            TrackpadThreeFingerDrag = true;
          };
          
          # Keyboard settings
          NSGlobalDomain = {
            KeyRepeat = 2;
            InitialKeyRepeat = 15;
            ApplePressAndHoldEnabled = false;
          };
        };
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 4;
      };

      # Direnv integration for dev environments
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      # Basic zsh integration (keep your existing .zshrc)
      programs.zsh = {
        enable = true;
        # Don't override existing config, just ensure nix integration
        enableCompletion = false; # Let oh-my-zsh handle this
      };

      # Nix configuration
      nix = {
        settings = {
          experimental-features = "nix-command flakes";
          trusted-users = [ "@admin" "ms" ];
          # Optimize store
          auto-optimise-store = true;
        };
        # Garbage collection
        gc = {
          automatic = true;
          interval.Day = 7;
          options = "--delete-older-than 14d";
        };
      };

      # Fix GID mismatch
      ids.gids.nixbld = 350;

      # The platform the configuration will be used on
      nixpkgs.hostPlatform = "aarch64-darwin";
      
      # Allow unfree packages for dev environments
      nixpkgs.config.allowUnfree = true;
    };
  in
  {
    darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
