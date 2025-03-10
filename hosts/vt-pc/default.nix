{
  inputs,
  pkgs,
  outputs,
  lib,
  ...
}:
let

  _1passwordModule = import ../common/nixos/optional/1password.nix { user = "vt"; };

  nixosModule = import ../common/nixos/setup.nix { hostname = "vt-pc"; };
  homeManagerModule = import ../common/home/setup.nix { inherit inputs outputs lib; };
in
{
  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    nixosModule
    # User
    ../common/nixos/users/vt

    # Optional
    ../common/nixos/optional/fonts.nix
    ../common/nixos/optional/localsend.nix

    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })
    ../common/home/optional/steam.nix

    # Services (background)
    ../common/nixos/optional/services/pipewire.nix
    ../common/nixos/optional/services/dropbox.nix
    _1passwordModule
    ../common/nixos/optional/hyprland.nix

    # Hardware related config (real hardware/drivers)
    ../common/nixos/hardware/nvidia
    ../common/nixos/hardware/opengl.nix
    ./hardware.nix
  ];

  vt.xserver = {
    enable = true;
    gdm = true;
    gnome = true;
    nvidiaDrivers = true;
  };
  # services.twingate.enable = true;

  users.users.vt = {
    extraGroups = [ "docker" ];
    packages = with pkgs; [
      # Apps
      spotify
      vesktop
    ];
  };

  services.flatpak.enable = true;

  virtualisation.docker = {
    enable = true;
  };
}
