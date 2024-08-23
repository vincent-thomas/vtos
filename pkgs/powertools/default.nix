{ pkgs }:
pkgs.writeShellScriptBin "powertools" ''
  chosen=$(printf "Power Off\nRestart\nLock" | fuzzel --dmenu -i)

  case "$chosen" in
    "Power Off") poweroff ;;
    "Restart") reboot ;;
    "Lock") hyprctl dispatch exit 1 ;;
    *) exit 1 ;;
  esac
''
