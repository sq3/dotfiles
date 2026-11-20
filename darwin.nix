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
      showAppExposeGestureEnabled = true;
      persistent-apps = [
        "/Applications/Brave Browser.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/Things3.app"
        "/Applications/Obsidian.app"
        "/Applications/Claude.app"
        "/Applications/WezTerm.app"
        "/Applications/T3 Code (Beta).app"
        "/Applications/Visual Studio Code.app"
        "/Applications/Fork.app"
        "/Applications/Slack.app"
        "/Applications/1Password.app"
        "/Applications/Spotify.app"
      ];
      persistent-others = [ "/Users/ms/Downloads" ];
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      ShowPathbar = true;
      ShowStatusBar = true;
      NewWindowTarget = "Recents";
      FXRemoveOldTrashItems = true; # empty trash after 30 days
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
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
      AppleShowScrollBars = "WhenScrolling";
      AppleWindowTabbingMode = "always";
      AppleEnableSwipeNavigateWithScrolls = true;
      NSAutomaticWindowAnimationsEnabled = false;
      NSWindowResizeTime = 0.001;
      "com.apple.springing.enabled" = true;
      "com.apple.springing.delay" = 0.5;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.trackpad.scaling" = 2.0;
    };

    ".GlobalPreferences"."com.apple.mouse.scaling" = 3.0;

    trackpad = {
      Clicking = false;
      Dragging = false;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0;
      TrackpadRightClick = true;
      FirstClickThreshold = 2; # firm click
      SecondClickThreshold = 2;
      ActuateDetents = true;
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
    };

    screencapture = {
      location = "~/OpenCloud/Personal/Screenshots";
      target = "file";
    };
    spaces.spans-displays = true;

    menuExtraClock = {
      Show24Hour = true;
      ShowSeconds = true;
      ShowDate = 2; # never
      ShowDayOfWeek = false;
      ShowDayOfMonth = false;
      IsAnalog = false;
    };

    WindowManager = {
      GloballyEnabled = false; # Stage Manager off
      EnableStandardClickToShowDesktop = true;
      EnableTiledWindowMargins = false;
      # macOS edge tiling off; AeroSpace does the tiling
      EnableTilingByEdgeDrag = false;
      EnableTopTilingByEdgeDrag = false;
      HideDesktop = true;
      AppWindowGroupingBehavior = true;
      AutoHide = false;
      StandardHideWidgets = false;
      StageManagerHideWidgets = false;
    };

    hitoolbox.AppleFnUsageType = "Do Nothing";
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    loginwindow.GuestEnabled = false;
  };
}
