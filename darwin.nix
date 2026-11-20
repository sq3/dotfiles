{ inputs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.primaryUser = "ms";
  users.users.ms.home = "/Users/ms";

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "@admin" "ms" ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 3; Minute = 0; };
      options = "--delete-older-than 14d";
    };
  };
  ids.gids.nixbld = 350;

  # oh-my-zsh runs compinit itself
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  # Apps and CLI tools stay in Homebrew; Brewfile is the source of truth
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
    extraConfig = builtins.readFile ./Brewfile;
  };

  # Values mirror this Mac's settings as of 2026-11-20
  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 41;
      magnification = false;
      show-recents = false;
      minimize-to-application = true;
      expose-group-apps = true; # recommended for AeroSpace
      mineffect = "scale";
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 14; # Quick Note
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 30;
      NSWindowShouldDragOnGesture = true; # ctrl+cmd drag moves windows
      "com.apple.swipescrolldirection" = false;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleTemperatureUnit = "Celsius";
      _HIHideMenuBar = false;
    };

    trackpad = {
      Clicking = false;
      TrackpadThreeFingerDrag = false;
      TrackpadRightClick = true;
    };

    screencapture.location = "~/OpenCloud/Personal/Screenshots";
    spaces.spans-displays = true;
    menuExtraClock.ShowSeconds = true;

    WindowManager = {
      GloballyEnabled = false; # Stage Manager off
      EnableStandardClickToShowDesktop = true;
      EnableTiledWindowMargins = false;
    };
  };
}
