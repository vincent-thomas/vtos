{ pkgs, ... }:
pkgs.writeShellScriptBin "powertools" ''
  chosen=$(printf "Hibernate\nPower Off\nRestart\nLock" | ${pkgs.fuzzel}/bin/fuzzel --dmenu -i)

  case "$chosen" in
    "Hibernate") systemctl hibernate ;;
    "Power Off") poweroff ;;
    "Restart") reboot ;;
    "Lock") hyprctl dispatch exit 1 ;;
    *) exit 1 ;;
  esac
''
