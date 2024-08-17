{ pkgs, ... }: {
  # TODO:

  home.packages = with pkgs; [
    nix-output-monitor
    nerdfetch
    obsidian
    cargo
    gcc
    wl-clipboard

    spotify-unwrapped
  ];

  programs.btop.enable = true;
}
