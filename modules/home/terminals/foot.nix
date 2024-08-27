{ pkgs, lib, config, ... }: {

  options.vt.foot.enable = lib.mkEnableOption "Foot terminal";

  config.programs.foot = {
    enable = config.vt.foot.enable;
    server.enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        term = "xterm-256color";
        font = "Jetbrains Mono Nerd Font:size=12";
      };
    };
  };
}
