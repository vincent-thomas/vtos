{ pkgs, ... }: {
  home.stateVersion = "24.05"; # Did you read the comment?

  imports = [ ../common/home/git.nix ];

  # General
  vt = {
    wallpapers = true;
    wm.hyprland = {
      enable = true;
      enableMediaKeys = true;
      extraConfig = ''
        monitor=,1920x1080@60.03,auto,auto
      '';
    };

    # Terminal / Shell
    alacritty.enable = true;

    starship.enable = true;
    zsh = {
      enable = true;
      starshipIntegration = true;
      zoxideIntegration = true;
      nvimAlias = true;
      envVars = ''
        export EDITOR="nvim"
      '';
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

    tmux.enable = true;

    firefox.enable = true;
  };

  home.packages = with pkgs; [
    cargo
    gcc
    vlc
    obsidian
    spotify

    localsend
  ];

  programs.btop.enable = true;
  services.blueman-applet.enable = true;

  xdg.userDirs.desktop = null;
}
