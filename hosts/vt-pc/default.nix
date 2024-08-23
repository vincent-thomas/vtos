{ inputs, pkgs, outputs, ... }:
let
  coreModule = import ../common/nixos/core { hostname = "vt-pc"; };

  homeManagerModule =
    import ../common/home/setup.nix { inherit inputs outputs; };

  _1passwordModule =
    import ../common/nixos/optional/1password.nix { user = "vt"; };
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
    ../common/nixos/optional/services/audio.nix
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

  security.rtkit.enable = true;

  vt.xserver = {
    enable = true;
    gdm = true;
    plasma = true;
    nvidiaDrivers = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.vt.packages = with pkgs; [
    localsend
    todoist-electron
    discord
    spotify
    vt-nvim

    pcmanfm
    networkmanagerapplet
    davinci-resolve
  ];
}
