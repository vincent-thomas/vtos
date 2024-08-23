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
    ../common/nixos/optional/virt-manager.nix
    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })

    # Services (background)
    ../common/nixos/optional/services/printing.nix
    ../common/nixos/optional/services/polkit.nix
    ../common/nixos/optional/services/bluetooth.nix
    ../common/nixos/optional/services/pipewire.nix
    _1passwordModule

    # Chosen user
    ../common/nixos/users/vt

    # Hardware related config (real hardware/drivers)
    ./hardware.nix
    ../common/nixos/hardware/nvidia.nix

  ];

  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  vt.xserver = {
    enable = true;
    gdm = true;
    plasma = true;
    nvidiaDrivers = true;
  };

  users.users.vt.packages = with pkgs; [
    # Apps
    localsend
    todoist-electron
    discord
    spotify
    davinci-resolve
    pcmanfm

    # Own packages
    vt-nvim
    tmux-sessionizer
    powertools

    networkmanagerapplet
  ];
}
