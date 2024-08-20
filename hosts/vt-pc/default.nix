{ inputs, pkgs, outputs, ... }:
let
  coreModule = import ../common/core { hostname = "vt-pc"; };

  homeManagerModule = import ../common/optional/home-manager-setup.nix {
    inherit inputs outputs;
  };

  _1passwordModule = import ../common/optional/1password.nix { user = "vt"; };
in {
  imports = [
    coreModule

    ../common/optional/hyprland.nix
    ../common/optional/fonts.nix
    ../common/optional/virt-manager.nix

    ../common/optional/services/printing.nix
    ../common/optional/services/polkit.nix
    ../common/optional/services/bluetooth.nix
    ../common/optional/services/audio.nix

    ../common/users/vt

    ./hardware.nix
    ../common/hardware/nvidia.nix

    (homeManagerModule { user = "vt"; homePath = ../../users/vt; })
    _1passwordModule
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
    # spotify-tray

    pcmanfm
    networkmanagerapplet
    davinci-resolve
  ];
}
