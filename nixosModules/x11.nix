{ lib, config, ... }: {
  options = {
    vt.xserver = {
      enable = lib.mkEnableOption "XServer";
      gdm = lib.mkEnableOption "GDM";
      qtile = lib.mkEnableOption "qTile";
      nvidiaDrivers = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables nvidia drivers for xServer";
      };
    };
  };
  config = {
    services.xserver = lib.mkIf config.vt.xserver.enable {
      enable = true;
      videoDrivers = lib.mkIf config.vt.xserver.nvidiaDrivers [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };

      windowManager.qtile.enable = config.vt.xserver.qtile;
      displayManager.gdm.enable = config.vt.xserver.gdm;
    };
  };
}
