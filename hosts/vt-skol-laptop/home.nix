{ pkgs, ... }:
{
  home.stateVersion = "23.11";

  imports = [ ../common/home/optional/devsetup ];

  home.packages = with pkgs; [
    cargo
    gcc
    nodejs_22
    nodePackages.pnpm
    wget
  ];

  programs.btop.enable = true;
}
