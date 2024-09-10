{ pkgs, ... }: {
  home.stateVersion = "24.05"; # Did you read the comment?

  imports = [ ../common/home/git.nix ../common/home/cursor.nix ../common/home/fuzzel-theme.nix ];

  # General
  vt = {
    wm.hyprland = {
      enable = true;
      enableMediaKeys = true;
      extraConfig = ''
        monitor=eDP-1,1920x1080@60.03,0x0,1
        monitor=HDMI-A-2,2560x1440@59.95,0x-1440,1
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

  home.packages = with pkgs; [ cargo gcc vlc obsidian ];

  programs.btop.enable = true;
  services.blueman-applet.enable = true;

  programs.imv.enable = true;

  xdg.userDirs.desktop = null;
}
