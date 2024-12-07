{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
let

  _1passwordModule = import ../common/nixos/optional/1password.nix { user = "vt"; };

  coreModule = import ../common/nixos/setup.nix { hostname = "vt-laptop"; };
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

    # Services (background)
    ../common/nixos/optional/services/pipewire.nix
    ../common/nixos/optional/services/dropbox.nix
    _1passwordModule

    # Hardware related config (real hardware/drivers)
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
  ];

  vt.xserver = {
    enable = true;
    gdm = true;
    gnome = true;
    nvidiaDrivers = false;
  };

  users.users.vt.packages = with pkgs; [
    # Apps
    spotify
    wl-clipboard
  ];

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

}
