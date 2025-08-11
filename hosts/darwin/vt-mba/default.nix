{
  pkgs,
  config,
  self,
  inputs,
  outputs,
  lib,
  ...
}:
let
  homeManagerModule = import ../../common/home/setup.nix {
    inherit inputs outputs lib;
    isDarwin = true;
  };
in
{
  programs.zsh.enable = true;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.primaryUser = "vt";
  system.stateVersion = 5;

  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../common/optional/aerospace.nix
    ../common/core
    (homeManagerModule {
      userPath = "/Users/vt";
      user = "vt";
      homePath = ./home.nix;
    })
  ];

  environment.pathsToLink = [ "/Applications" ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.startup.chime = false;
  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      # Add a context menu item for showing the Web Inspector in web views
      WebKitDeveloperExtras = true;
    };
    "com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirst = true;
      # When performing a search, search the current folder by default
      FXDefaultSearchScope = "SCcf";
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.screensaver" = {
      # Require password immediately after sleep or screen saver begins
      askForPassword = 1;
      askForPasswordDelay = 0;
    };
    "com.apple.screencapture" = {
      location = "~/Desktop";
      type = "png";
    };
    "com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
    };
    "com.apple.print.PrintingPrefs" = {
      # Automatically quit printer app once the print jobs complete
      "Quit When Finished" = true;
    };
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      CriticalUpdateInstall = 1;
    };
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    # Prevent Photos from opening automatically when devices are plugged in
    "com.apple.ImageCapture".disableHotPlug = true;
    # Turn on app auto-update
    "com.apple.commerce".AutoUpdate = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  homebrew = {
    enable = true;

    casks = [
      "1password"
      "twingate"
      "angry-ip-scanner"
      "ollama"
      "cursor"
    ];
    onActivation.cleanup = "zap";
  };

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # User owning the Homebrew prefix
    user = "vt";

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    mutableTaps = false;
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        show-recents = false;
        showhidden = true;
        show-process-indicators = true;
        orientation = "bottom";
        mru-spaces = false;
        persistent-apps = [
          "/Users/${config.system.primaryUser}/Applications/Brave Browser Apps.localized/Proton Calendar.app"
          "/Users/${config.system.primaryUser}/Applications/Brave Browser Apps.localized/Proton Mail.app"
          "${pkgs.brave}/Applications/Brave Browser.app"
          "/System/Applications/Notes.app"
          "/System/Applications/Reminders.app"
          "${pkgs.spotify}/Applications/Spotify.app"
          "/Applications/1Password.app"
          "${pkgs.alacritty}/Applications/Alacritty.app"
        ];
      };
    };
  };
}
