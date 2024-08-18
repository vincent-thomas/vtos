{ lib, ... }: {
  allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "nvidia-x11"
      "todoist-electron"
      "discord"
      "davinci-resolve"
    ];
}

