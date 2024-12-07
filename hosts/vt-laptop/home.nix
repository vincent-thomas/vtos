{ pkgs, ... }:
{
  home.stateVersion = "24.05"; # Did you read the comment?

  imports = [
    ../common/home/optional/devsetup
  ];

  # General
  vt = {
    config.onepassword = {
      sshIntegration = true;
      zshOpPlugins.gh = true;
      zshOpPlugins.cargo = true;
      zshOpPlugins.flyctl = true;
      zshOpPlugins.stripe = true;
    };
    firefox.enable = true;
  };

  home.packages = with pkgs; [
    cargo
    gcc
    vlc
    obsidian
    hoppscotch
  ];

  programs.btop.enable = true;
  xdg.userDirs.desktop = null;
}
