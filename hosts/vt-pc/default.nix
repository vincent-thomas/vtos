{ allowed-unfree-packages, lib, ... }: {

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  networking = {
    networkmanager.enable = true;
    nameservers = [ "9.9.9.9" ];
  };

  programs.zsh.enable = true;

  system.stateVersion = "24.05";

  hardware.bluetooth.enable = true;

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };
  services.blueman.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.rtkit.enable = true;

  vt.services.polkit.enable = true;
  vt.xserver = {
    enable = true;
    gdm = true;
    qtile = true;
    nvidiaDrivers = true;
  };

  programs.hyprland.enable = true;

  imports = [ ./hardware.nix ./audio.nix ./graphics.nix ];

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  #  services.printing.enable = true;
}
