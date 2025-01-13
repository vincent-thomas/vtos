{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "powertools";
  runtimeInputs = with pkgs; [
    fuzzel
  ];

  text = ''
    chosen=$(printf "Hibernate\nPower Off\nRestart\nLock" | fuzzel --dmenu -i)

    case "$chosen" in
      "Hibernate") systemctl hibernate ;;
      "Power Off") poweroff ;;
      "Restart") reboot ;;
      "Lock") hyprctl dispatch exit 1 ;;
      *) exit 1 ;;
    esac
  '';
}
