{
  inputs,
  pkgs,
  outputs,
  lib,
  ...
}:
let
  _1passwordModule = import ../../common/nixos/optional/apps/1password.nix { user = "vt"; };

  nixosModule = import ../../common/nixos/setup.nix { hostname = "vt-pc"; };
  homeManagerModule = import ../../common/home/setup.nix { inherit inputs outputs lib; };
in
{
  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    nixosModule
    # User
    ../../common/nixos/users/vt

    # Optional
    ../../common/nixos/optional/fonts.nix
    ../../common/nixos/optional/apps/localsend.nix

    (homeManagerModule {
      user = "vt";
      userPath = "/home/vt";
      homePath = ./home.nix;
    })
    ../../common/home/optional/steam.nix

    # Services (background)
    ../../common/nixos/optional/services/pipewire.nix
    ../../common/nixos/optional/services/dropbox.nix
    _1passwordModule
    ../../common/nixos/optional/services/hyprland.nix

    # Hardware related config (real hardware/drivers)
    ../../common/nixos/hardware/nvidia
    ../../common/nixos/hardware/opengl.nix
    ./hardware.nix
  ];
}
