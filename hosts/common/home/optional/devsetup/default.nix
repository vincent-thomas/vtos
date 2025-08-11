{
  isDarwin ? false,
}:
{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./starship.nix
    (import ./git.nix { inherit isDarwin; })
    ./alacritty.nix
    ./devshell.nix
  ];

  home.packages = with pkgs; [
    vt-nvim
    cargo
    pnpm
    nodejs_22
  ];
}
