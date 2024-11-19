{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    vt.wm.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland wm";
      enableMediaKeys = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      extraConfig = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };
  config =
    let
      extraConfig = import ./extra-config.nix { inherit pkgs; };
    in
    {
      wayland.windowManager.hyprland = {
        inherit (config.vt.wm.hyprland) enable;
        xwayland.enable = true;
        extraConfig = ''

          ${config.vt.wm.hyprland.extraConfig}

          ${extraConfig.waylandFix}

          $menu = ${pkgs.fuzzel}/bin/fuzzel
          ${builtins.readFile ./hyprland.conf}

          bind = $mainMod, P, exec, ${pkgs.powertools}/bin/powertools
          ${extraConfig.brightnessConfig}
          ${if config.vt.wm.hyprland.enableMediaKeys then extraConfig.mediaKeysConfig else ""}
        '';
      };

      programs.fuzzel.catppuccin.enable = true;

      home = lib.mkIf config.vt.wm.hyprland.enable {
        packages = [
          pkgs.wpaperd
          pkgs.waybar
          pkgs.pavucontrol
          pkgs.wl-clipboard
        ];
        file = {
          ".config/wpaperd/config.toml".text = ''
            [any]
            path = "${inputs.vt-wallpapers}"
          '';
          ".config/waybar".source = ./waybar;
        };
      };
    };
}
