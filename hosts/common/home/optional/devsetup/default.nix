{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./starship.nix
    ./git.nix
    ./alacritty.nix
    ./devshell.nix
  ];

  home.packages = with pkgs; [ vt-nvim ];
}
