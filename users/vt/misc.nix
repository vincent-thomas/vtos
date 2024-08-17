{ pkgs, ... }: {
  # TODO:

  home.packages = with pkgs; [
    nix-output-monitor
    nerdfetch
    obsidian
    cargo
    gcc
    wl-clipboard
  ];

  programs.btop.enable = true;
}
