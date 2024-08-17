{ config, lib, pkgs, ... }: {
  options = {
    vt.wm.hyprland.enable = lib.mkEnableOption "Enable hyprland wm";
  };
  config = {
    wayland.windowManager.hyprland = {
      enable = config.vt.wm.hyprland.enable;
      xwayland.enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    home.packages = lib.mkIf config.vt.wm.hyprland.enable [
      pkgs.wpaperd
      pkgs.waybar
      pkgs.pavucontrol
    ];

    programs.fuzzel.enable = true;

    # programs.ags = {
    #   enable = true;
    #   configDir = ./ags;
    # };

    home.file.".config/wpaperd/config.toml".text = ''
      [any]
      path = '~/.vt/wallpapers'
    '';
    home.file.".config/waybar".source = ./waybar;
  };
}
