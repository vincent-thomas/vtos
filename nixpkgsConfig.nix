{ lib, ... }:
{
  allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "aldente"
      "dropbox"
      "onepassword-password-manager"
      "obsidian"
      "nvidia-x11"
      "spotify"
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "tradingview"
      "twingate"
    ];
}
