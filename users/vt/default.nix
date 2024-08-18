{ inputs, ... }: {
  home.stateVersion = "23.11";

  imports = [
    ./modules/desktop
    ./monitor-setup.nix
    ./git.nix
    ./misc.nix
    # inputs.ags.homeManagerModules.default
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  services.blueman-applet.enable = true;

  # General
  vt.dot.wallpapers = true;
  vt.dot.scripts = true;
  vt.dot.zshIntegration = true;

  vt.wm.hyprland.enable = true;

  # Terminal / Shell
  vt.kitty.enable = true;

  vt.starship.enable = true;
  vt.zsh = {
    enable = true;
    starshipIntegration = true;
    zoxideIntegration = true;
    nvimAlias = true;
  };

  vt.config.onepassword = {
    sshIntegration = true;
    zshOpPlugins.gh = true;
    zshOpPlugins.cargo = true;
  };

  vt.cliTools.enable = true;
  vt.cliTools.zshIntegration = true;

  # Dev Setup
  vt.nvim = {
    enable = true;
    defaultEditor = true;
  };
  vt.zellij.enable = true;

  # Setup
  vt.picom.enable = true;
  vt.qtile.config.enable = true;
  vt.firefox.enable = true;

  programs.imv.enable = true;

  xdg.userDirs.desktop = null;
}
