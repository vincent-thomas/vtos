{ pkgs, ... }:
let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
in
{
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

  waylandFix = ''
    # XDG
    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland

    # QT
    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_QPA_PLATFORM=wayland;xcb    # Not yet working for onlyoffice-editor
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
    env = QT_QPA_PLATFORMTHEME,qt6ct

    # Toolkit
    env = SDL_VIDEODRIVER,wayland
    env = _JAVA_AWT_WM_NONEREPARENTING,1
    env = CLUTTER_BACKEND,wayland
    env = GDK_BACKEND,wayland,x11

    exec-once = ${pkgs.waybar}/bin/waybar &
  '';
}
