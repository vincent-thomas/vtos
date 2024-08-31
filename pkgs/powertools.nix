{ pkgs, ... }:
pkgs.writeShellScriptBin "powertools" ''
  chosen=$(printf "Sleep\nPower Off\nRestart\nLock" | fuzzel --dmenu -i)

  case "$chosen" in
    "Sleep") systemctl hibernate ;;
    "Power Off") poweroff ;;
    "Restart") reboot ;;
    "Lock") hyprctl dispatch exit 1 ;;
    *) exit 1 ;;
  esac
''
