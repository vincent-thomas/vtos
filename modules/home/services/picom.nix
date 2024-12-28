{ config, lib, ... }:
{
  options = {
    vt.picom.enable = lib.mkEnableOption "Enable picom";
  };

  config = lib.mkIf config.vt.picom.enable {
    services.picom = {
      enable = true;

      shadow = true;
      shadowExclude = [ "class_g = 'Polybar'" ];

      vSync = true;
      backend = "glx";

      fade = true;
      fadeDelta = 3;

      inactiveOpacity = 0.8;
      activeOpacity = 0.9;

      settings = {
        blur = {
          method = "dual_kawase";
          deviation = 5;
        };
      };
    };
  };
}
