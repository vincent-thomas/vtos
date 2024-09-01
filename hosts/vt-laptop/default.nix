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
    ../common/nixos/optional/services/bluetooth.nix

    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s

    # Fingerprint sensor
    inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
    inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
  ];

  services.open-fprintd.enable = true;
  services.python-validity.enable = true;

  vt.xserver = {
    enable = true;
    gdm = true;
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

  environment.systemPackages = with pkgs; [
    vt-nvim
    powertools
    networkmanagerapplet
  ];

  system.stateVersion = "24.05";

}
