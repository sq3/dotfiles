# Menu bar: macOS Control Center items and Bartender layout/behavior.
# Bartender keys are an allowlist: its prefs also hold the license key,
# an auth token and cached location, which must never land in this repo.
{ ... }:
{
  system.defaults.controlcenter = {
    FocusModes = true;
    NowPlaying = false;
  };

  system.defaults.CustomUserPreferences."com.surteesstudios.Bartender" = {
    # Layout
    GoldenGateHiddenItemOrderKeys = [
      "slot:com.prakashjoshipax.VoiceInk:com.prakashjoshipax.VoiceInk:1"
      "plist:status:com.haystacksoftware.ArqMonitor::Item-0"
      "plist:status:io.tailscale.ipn.macsys::Item-0"
      "plist:status:fyi.lunar.Lunar::Item-0"
      "plist:status:eu.opencloud.desktop::Item-0"
      "plist:status:com.raycast.macos::c:n:1e915fb4-4a40-4555-8fad-99319ca35f19::-::show-today-in-menu-bar"
      "plist:status:com.raycast.macos::c:n:425e07db-3cd5-417b-82e6-d668921951ec::-::battery_optimizer_menu_bar"
      "plist:status:com.raycast.macos::c:n:0a3cf1ce-7de6-415c-9e37-91a892d1747e::-::lightsmenu"
      "plist:status:ru.keepcoder.Telegram::Item-0"
    ];
    GoldenGateAlwaysHiddenItemOrderKeys = [
      "plist:status:com.tinyspeck.slackmacgap::84f9d31e-237f-41db-a0ca-9ee4bacbff83"
      "plist:status:com.raycast.macos::c:n:6090553e-ee96-4c89-af5c-e6c60fa551ba::-::obsidianMenuBar"
      "slot:com.apple.systemuiserver:com.apple.systemuiserver:1"
      "plist:module:Sound"
      "plist:status:com.1password.1password::bb3cc23c-6950-4e96-8b40-850e09f46934"
      "plist:module:WiFi"
      "plist:status:com.jamf.connect::Item-0"
      "plist:status:us.zoom.xos::Item-0"
      "plist:status:org.languagetool.desktop::Item-0"
      "plist:status:com.anthropic.claudefordesktop::Item-0"
    ];
    GoldenGateAllowsSystemItemHiding = true;

    # Behavior
    GoldenGateBartenderBarEnabled = true;
    BartenderBarOnlyOnNotchScreens = true;
    GoldenGateBartenderBarAutoEnablesForOverflow = true;
    GoldenGateAutomaticOverflowEnabledForBartenderBar = false;
    GoldenGateAutomaticallyHidesOverflowingItems = false;
    GoldenGateBarItemImageMode = "onlyShown";
    GoldenGateHideBartenderMenuBarItem = false;
    GoldenGateHideShownItemsWhenRevealingHidden = false;
    HideShownItemsWhen = 2;
    MouseExitDelay = 0.4;
    ShowAllItemsWhenDragging = true;
    SimpleLayoutModeEnabled = true;
    UseBartenderBar = false;
    DisableAllTriggers = true;
    hotkey = { keyCode = 1; characters = "S"; modifierFlags = 1179648; }; # ctrl+cmd+S
    "launchAtLogin.isEnabled" = true;
    SUAutomaticallyUpdate = false;
    SUEnableAutomaticChecks = false;

    # Style
    MenuBarShape = "capsule";
    MenuBarStyle = builtins.toJSON {
      colors = [ ];
      shape = "capsule";
      baseStyle.material = { };
      materialAppearance = "dark";
      roundBottomOfScreen = false;
      shadow = false;
      material = "regular";
      roundBottomofBar = false;
      seperatePills = true;
    };
    SeperatePills = true;
    ReduceMenuItemSpacing = 1;
    ShowDivider = false;
    statusBarImageNamed = "Arrow";

    # Notch bar
    topShelfEnabled = true;
    "notchbar.autoHideDelay" = 0.5;
    "notchbar.backgroundStyle" = "standard";
    "notchbar.nonNotchBackgroundStyle" = "material";
    "notchbar.nonNotchBackgroundMaterial" = "regular";
    "notchbar.displayTargetMode" = "followFocused";
    "notchbar.trayEnabled" = true;
    "notchbar.trayLeadingWidget" = "music";
    "notchbar.trayTrailingWidget" = "calendar";
    "notchbar.calendarEnabled" = true;
    "notchbar.musicProvider" = "spotify";
    "notchbar.musicHideWhenPaused" = true;
    "notchbar.musicShowBannerOnChange" = true;
    "notchbar.clipboardMonitoringEnabled" = false;
    "notchbar.airPodsActivityEnabled.v2" = true;
    "notchbar.airPodsLowBatteryAlertEnabled.v2" = true;
    "notchbar.weatherIceEnabled" = false;
    "notchbar.weatherRainEnabled" = false;
    "notchbar.weatherSnowEnabled" = false;
  };
}
