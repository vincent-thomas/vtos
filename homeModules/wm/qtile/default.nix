{ config, lib, pkgs, ... }: {
  options = {
    vt.qtile.config.enable = lib.mkEnableOption "Enables Qtile configuration";
  };
  config = {
    home.file.".config/qtile".source =
      lib.mkIf config.vt.qtile.config.enable ./config;

    programs.rofi.enable = config.vt.qtile.config.enable;

    home.packages = lib.mkIf config.vt.qtile.config.enable [ pkgs.nitrogen ];
  };
}
