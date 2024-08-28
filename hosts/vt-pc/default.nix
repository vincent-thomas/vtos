{ inputs, pkgs, outputs, ... }:
let
  coreModule = import ../common/nixos/core { hostname = "vt-pc"; };

  _1passwordModule =
    import ../common/nixos/optional/1password.nix { user = "vt"; };

  homeManagerModule =
    import ../common/home/setup.nix { inherit inputs outputs; };
in {
  imports = [
    coreModule
    # Optional
    ../common/nixos/optional/hyprland.nix
    ../common/nixos/optional/fonts.nix
    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })

    # Services (background)
    ../common/nixos/optional/services/polkit.nix
    ../common/nixos/optional/services/bluetooth.nix
    ../common/nixos/optional/services/pipewire.nix
    _1passwordModule
    # dockerModule

    # Chosen user
    ../common/nixos/users/vt

    # Hardware related config (real hardware/drivers)
    ./hardware.nix
    ../common/nixos/hardware/nvidia
    ../common/nixos/hardware/opengl.nix

    # Test
    ../common/server/services/k3s.nix

  ];

  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  vt.xserver = {
    enable = true;
    gdm = true;
    nvidiaDrivers = true;
  };

  environment.etc."resolv.conf".text = ''
    nameserver 45.90.28.165
    nameserver 45.90.30.165
  '';

  users.users.vt.packages = with pkgs; [
    # Apps
    localsend
    discord
    spotify
    pcmanfm

    # Own packages
    vt-nvim
    powertools

    networkmanagerapplet

    kubernetes-helm
  ];
}
