{ config, lib, pkgs, ... }: {
  options = {
    vt.wm.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland wm";
      extraConfig = lib.mkOption {
        type = lib.string;
        default = "";
      };
    };
  };
  config = {
    wayland.windowManager.hyprland = {
      inherit (config.vt.wm.hyprland) enable;
      xwayland.enable = true;
      extraConfig = ''
        ${config.vt.wm.hyprland.extraConfig}
        ${builtins.readFile ./hyprland.conf}
      '';
    };

    programs.fuzzel.enable = true;

    home = lib.mkIf config.vt.wm.hyprland.enable {
      packages =
        [ pkgs.wpaperd pkgs.waybar pkgs.pavucontrol pkgs.wl-clipboard ];
      file = {
        ".config/wpaperd/config.toml".text = ''
          [any]
          path = '~/.vt/wallpapers'
        '';
        ".config/waybar".source = ./waybar;
      };
    };
  };
}
