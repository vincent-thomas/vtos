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

      playerctl = "${pkgs.playerctl}/bin/playerctl";

      brightnessConfig = ''
        # Increase Brightness
        bind = ,XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +10%

        # Decrease Brightness
        bind = ,XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%-
      '';

      mediaKeysConfig = ''
        # Volume Up
        bind = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0

        # Volume Down
        bind = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

        # Mute/Unmute
        bind = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

        # Microphone Mute/Unmute
        bind = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle

        # Play/Pause
        bind = ,XF86AudioPlay, exec, ${playerctl} play-pause

        # Next Track
        bind = ,XF86AudioNext, exec, ${playerctl} next

        # Previous Track
        bind = ,XF86AudioPrev, exec, ${playerctl} previous
      '';
    in
    {
      wayland.windowManager.hyprland = {
        inherit (config.vt.wm.hyprland) enable;
        xwayland.enable = true;
        extraConfig = ''

          ${config.vt.wm.hyprland.extraConfig}

          exec-once = ${pkgs.waybar}/bin/waybar &

          $menu = ${pkgs.fuzzel}/bin/fuzzel
          ${builtins.readFile ./hyprland.conf}

          bind = $mainMod, P, exec, ${pkgs.powertools}/bin/powertools
          ${brightnessConfig}
          ${if config.vt.wm.hyprland.enableMediaKeys then mediaKeysConfig else ""}
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
