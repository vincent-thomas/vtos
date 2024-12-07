{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file = lib.mkIf config.vt.qtile.config.enable {
    ".config/qtile".source = ./config;
  };

  programs.rofi.enable = config.vt.qtile.config.enable;

  home.packages = lib.mkIf config.vt.qtile.config.enable [ pkgs.nitrogen ];
}
