{ config, lib, ... }: {

  options = {
    vt.networking.hostname = lib.mkOption { type = lib.types.str; };
  };

  config = {
    # services.tailscale = {
    #   enable = true;
    #   authKeyFile = config.age.secrets."tailscale-auth-key".path;
    #   useRoutingFeatures = "client";
    #   extraUpFlags = [ "--accept-dns=false" ];
    # };
    networking = {
      networkmanager.enable = true;
      # nameservers = [ "127.0.0.1" ];
      hostName = config.vt.networking.hostname;
    };
  };
}
