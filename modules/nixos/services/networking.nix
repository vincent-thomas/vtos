{ config, lib, ... }: {

  options = {
    vt.services.networking.hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };
  };

  config = {
    networking = {
      networkmanager.enable = true;
      hostName = config.vt.services.networking.hostname;
    };
  };
}
