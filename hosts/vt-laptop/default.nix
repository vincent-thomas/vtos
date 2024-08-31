{ pkgs, inputs, outputs, ... }:
let
  coreModule = import ../common/nixos/core { hostname = "vt-laptop"; };

  _1passwordModule =
    import ../common/nixos/optional/1password.nix { user = "vt"; };

  homeManagerModule =
    import ../common/home/setup.nix { inherit inputs outputs; };
in {
  imports = [
    coreModule

    ../common/nixos/users/vt

    # Optional
    ../common/nixos/optional/fonts.nix
    ../common/nixos/optional/hyprland.nix
    _1passwordModule

    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })

    ../common/nixos/optional/services/pipewire.nix
    ../common/nixos/optional/services/pull-config-update.nix

    ./hardware.nix
  ];

  vt.xserver = {
    enable = true;
    gdm = true;
    gnome = true;
    nvidiaDrivers = false;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  console.keyMap = "sv-latin1";

  # Enable touchpad support.
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [ vt-nvim powertools ];

  system.stateVersion = "24.05"; # Did you read the comment?

}
