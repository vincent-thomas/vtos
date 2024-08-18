{ inputs, pkgs, ... }:
let
  networkingModule =
    import ../common/core/services/networking.nix { hostname = "vt-pc"; };

  homeManagerSetup =
    import ../common/optional/home-manager-setup.nix { inherit inputs; };

  homeManagerModule = homeManagerSetup { user = "vt"; };
in networkingModule // homeManagerModule // {
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.rtkit.enable = true;
  # hardware.graphics.enable = true;

  vt.xserver = {
    enable = true;
    gdm = true;
    qtile = true;
    nvidiaDrivers = true;
  };

  imports = [
    ../common/core/locales.nix
    ../common/core/nix-settings.nix
    ../common/core/zsh.nix
    ../common/core/services/ssh.nix
    ../common/core/services/polkit.nix
    ../common/core/age.nix

    ../common/optional/hyprland.nix
    ../common/optional/1password.nix
    ../common/optional/fonts.nix

    ../common/optional/services/printing.nix
    ../common/optional/services/bluetooth.nix
    ../common/optional/services/audio.nix

    ../common/users/vt

    ./hardware.nix
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.vt.packages = with pkgs; [
    localsend
    todoist-electron
    discord

    pcmanfm
    networkmanagerapplet
    davinci-resolve
  ];
}
