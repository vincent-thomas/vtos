{ lib, ... }:
{
  allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "onepassword-password-manager"
      "nvidia-x11"
      "spotify"
      "obsidian"
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "tradingview"
      "dropbox"
      "twingate"
    ];
}
