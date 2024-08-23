{ config, lib, ... }: {
  options.vt.wallpapers = lib.mkEnableOption "vt.wallpapers";

  config.home.file.".vt/wallpapers" =
    lib.mkIf config.vt.wallpapers { source = ./wallpapers; };
}
