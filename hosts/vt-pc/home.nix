{ pkgs, ... }: {
  home.stateVersion = "23.11";

  imports = [
    ../common/home/desktop
    ../common/home/git.nix
    ../common/home/virt-manager.nix
  ];

  # General
  vt = {
    wallpapers = true;

    wm.hyprland.enable = true;

    # Terminal / Shell
    alacritty.enable = true;

    starship.enable = true;
    zsh = {
      enable = true;
      starshipIntegration = true;
      zoxideIntegration = true;
      nvimAlias = true;
    };

    config.onepassword = {
      sshIntegration = true;
      zshOpPlugins.gh = true;
      zshOpPlugins.cargo = true;
    };

    cliTools = {
      enable = true;
      zshIntegration = true;
    };

    zellij.enable = true;
    tmux.enable = true;

    firefox.enable = true;
  };

  home.packages = with pkgs; [ cargo gcc vlc ];

  programs.btop.enable = true;

  services.blueman-applet.enable = true;

  programs.imv.enable = true;

  xdg.userDirs.desktop = null;
}
