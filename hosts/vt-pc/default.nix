{
  inputs,
  pkgs,
  outputs,
  lib,
  ...
}:
let
  coreModule = import ../common/nixos/core { hostname = "vt-pc"; };

  _1passwordModule = import ../common/nixos/optional/1password.nix { user = "vt"; };

  homeManagerModule = import ../common/home/setup.nix { inherit inputs outputs lib; };
in
{
  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    coreModule
    # User
    ../common/nixos/users/vt

    # Optional
    ../common/nixos/optional/fonts.nix
    ../common/nixos/optional/localsend.nix

    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })
    ../common/home/steam.nix

    # Services (background)
    ../common/nixos/optional/services/pipewire.nix
    ../common/nixos/optional/services/dropbox.nix
    _1passwordModule

    # Hardware related config (real hardware/drivers)
    ./hardware.nix
    ../common/nixos/hardware/nvidia
    ../common/nixos/hardware/opengl.nix
  ];

  vt.xserver = {
    enable = true;
    gdm = true;
    gnome = true;
    nvidiaDrivers = true;
  };
  services.twingate.enable = true;

  users.users.vt = {
    extraGroups = [ "docker" ];
    packages = with pkgs; [
      # Apps
      spotify

      # Own packages
      vt-nvim
      vesktop
    ];
  };

  virtualisation.docker = {
    enable = true;
  };
}
