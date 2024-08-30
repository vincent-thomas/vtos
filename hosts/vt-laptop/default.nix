{ pkgs, inputs, outputs, ... }:
let
  coreModule = import ../common/nixos/core { hostname = "vt-laptop"; };

  _1passwordModule =
    import ../common/nixos/optional/1password.nix { user = "vt"; };

  homeManagerModule =
    import ../common/home/setup.nix { inherit inputs outputs; };
in {
  imports = [
    coreModule

    ../common/nixos/users/vt

    # Optional
    ../common/nixos/optional/fonts.nix
    _1passwordModule

    (homeManagerModule {
      user = "vt";
      homePath = ./home.nix;
    })

    ../common/nixos/optional/services/pipewire.nix

    ./hardware.nix
  ];

  vt.xserver = {
    enable = true;
    gdm = true;
    gnome = true;
    nvidiaDrivers = false;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable touchpad support.
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.vt = {
  #   isNormalUser = true;
  #   description = "Vincent";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [ ];
  # };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ vt-nvim ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
