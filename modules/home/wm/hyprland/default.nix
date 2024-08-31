{ config, lib, pkgs, ... }: {
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
  config = let

    playerctl = "${pkgs.playerctl}/bin/playerctl";

    mediaKeysConfig = ''
      # Volume Up
      bind = XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+

      # Volume Down
      bind = XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

      # Mute/Unmute
      bind = XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      # Microphone Mute/Unmute
      bind = XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle

      # Play/Pause
      bind = XF86AudioPlay, exec, ${playerctl} play-pause

      # Next Track
      bind = XF86AudioNext, exec, ${playerctl} next

      # Previous Track
      bind = XF86AudioPrev, exec, ${playerctl} previous

    '';
  in {
    wayland.windowManager.hyprland = {
      inherit (config.vt.wm.hyprland) enable;
      xwayland.enable = true;
      extraConfig = ''
        ${config.vt.wm.hyprland.extraConfig}
        ${builtins.readFile ./hyprland.conf}
        ${if config.vt.wm.hyprland.enableMediaKeys then mediaKeysConfig else ""}
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
