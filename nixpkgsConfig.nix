{ lib, ... }: {
  allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "onepassword-password-manager"
      "nvidia-x11"
      "todoist-electron"
      "discord"
      "spotify"
      "davinci-resolve"
      "obsidian"
    ];
}

