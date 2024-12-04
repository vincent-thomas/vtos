{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
let
  coreModule = import ../common/nixos/core { hostname = "vt-laptop"; };

  _1passwordModule = import ../common/nixos/optional/1password.nix { user = "vt"; };

  homeManagerModule = import ../common/home/setup.nix { inherit inputs outputs lib; };
in
{
  system.stateVersion = "24.05";
  imports = [
    coreModule
    # User
    ../common/nixos/users/vt

    # Optional
    # ../common/nixos/optional/hyprland.nix
    ../common/nixos/optional/fonts.nix
    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })

    # Services (background)
    # ../common/nixos/optional/services/polkit.nix
    # ../common/nixos/optional/services/bluetooth.nix
    ../common/nixos/optional/services/pipewire.nix
    ../common/nixos/optional/services/dropbox.nix
    _1passwordModule

    # Hardware related config (real hardware/drivers)
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  vt.xserver = {
    enable = true;
    gdm = true;
    gnome = true;
    nvidiaDrivers = false;
  };

  environment.etc."resolv.conf".text = ''
    nameserver 45.90.28.165
    nameserver 45.90.30.165
  '';

  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    # Apps
    localsend
    spotify
    pcmanfm

    # Own apps
    vt-nvim

    networkmanagerapplet
  ];
}
