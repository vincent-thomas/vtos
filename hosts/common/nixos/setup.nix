{ hostname, ... }:
{
  imports = [
    ./core.nix
  ];

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
  };
}
