{ pkgs, ... }: {
  home.stateVersion = "23.11";

  imports = [ ../../users/common/optional/git.nix ];

  home.packages = with pkgs; [ nerdfetch cargo gcc ];

  programs.btop.enable = true;

  programs.git.extraConfig.safe.directory = [ "/home/vt/vtos" ];

  # General
  vt = {
    starship.enable = true;
    zsh = {
      enable = true;
      starshipIntegration = true;
      zoxideIntegration = true;
      nvimAlias = true;
    };
    cliTools = {
      enable = true;
      zshIntegration = true;
    };

    zellij.enable = true;
  };
}
