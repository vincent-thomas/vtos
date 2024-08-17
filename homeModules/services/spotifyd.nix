{ lib, config, ... }: {

  options = {
    vt.spotifyd.enable = lib.mkEnableOption "Enables spotify daemon";
  };

  config = {
    services.spotifyd = {
      enable = config.vt.spotifyd.enable;
      settings = {
        global = {
          device_name = "VT";
          bitrate = 160;
          volume_normalization = true;
          device_type = "computer";
          backend = "alsa";
          username = "31jrspnkdqri7pgj4o66vejiq3kq";
          password_cmd =
            "op item get ec6pudwowfoicupymqkb364ziq --field password";
        };
      };
    };
  };
}
