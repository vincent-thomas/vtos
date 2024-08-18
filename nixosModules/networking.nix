{ config, lib, ... }: {

  options = {
    vt.networking.hostname = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = {
    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets."tailscale-auth-key".path;
    };
    networking = {
      enable = true;
      hostName = config.vt.networking.hostname;
    };
  };
}
