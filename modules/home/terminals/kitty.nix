{ lib, config, ... }:
{
  options = {
    vt.kitty.enable = lib.mkEnableOption "Kitty terminal";
    vt.kitty.zshDefault = lib.mkEnableOption "Default on zsh shell";
  };
  config = {
    programs.kitty = lib.mkIf config.vt.kitty.enable {
      enable = true;
      font = {
        name = "Jetbrains Mono Nerd Font";
        size = 12;
      };

      settings = {
        confirm_os_window_close = 0;
      };
    };
  };
}
