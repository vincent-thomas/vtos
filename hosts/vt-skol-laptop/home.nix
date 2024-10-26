{ pkgs, ... }:
{
  home.stateVersion = "23.11";

  imports = [ ../common/home/git.nix ];

  home.packages = with pkgs; [
    cargo
    gcc
    nodejs_22
    nodePackages.pnpm
    wget
  ];

  programs.btop.enable = true;

  # General
  vt = {
    starship.enable = true;
    zsh = {
      enable = true;
      starshipIntegration = true;
      zoxideIntegration = true;
      nvimAlias = true;
      extraConfig = ''
        # eval $(ssh-agent) &> /dev/null
        # ssh-add ~/.ssh/gitlab &> /dev/null

        tmux new -Asroot
      '';
    };
    cliTools = {
      enable = true;
      zshIntegration = true;
    };

    tmux.enable = true;
  };
}
