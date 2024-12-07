{ pkgs, lib, ... }:
{
  services.polybar = {
    catppuccin.enable = false;
    enable = false;
    script = "polybar";
    extraConfig = ''
      ${builtins.readFile ./config/colors.ini}
      ${builtins.readFile ./config/modules.ini}
      ${builtins.readFile ./config/config.ini}
    '';
    package = pkgs.polybar.override { alsaSupport = true; };
  };
}
