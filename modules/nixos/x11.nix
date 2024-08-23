{ lib, config, ... }: {
  options = {
    vt.xserver = {
      enable = lib.mkEnableOption "XServer";
      gdm = lib.mkEnableOption "GDM";
      plasma = lib.mkEnableOption "Plasma";
      qtile = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enables qtile as window manager";
      };
      nvidiaDrivers = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables nvidia drivers for xServer";
      };
    };
  };
  config = {
    services.xserver = {
      enable = config.vt.xserver.enable;
      videoDrivers = lib.mkIf config.vt.xserver.nvidiaDrivers [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };

      windowManager.qtile.enable = config.vt.xserver.qtile;
      displayManager.gdm.enable = config.vt.xserver.gdm;
      desktopManager.plasma6.enable = config.vt.xserver.plasma;
    };
  };
}