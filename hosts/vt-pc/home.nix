{ pkgs, ... }:
{
  home.stateVersion = "23.11";

  imports = [
    ../common/home/optional/devsetup
    ../common/home/optional/virt-manager.nix
  ];

  # General
  vt = {
    config.onepassword = {
      sshIntegration = true;
      zshOpPlugins.gh = true;
      zshOpPlugins.cargo = true;
      zshOpPlugins.stripe = true;
      zshOpPlugins.flyctl = true;
    };

    firefox.enable = true;
  };

  home.packages = with pkgs; [
    cargo
    rustc

    pnpm_9
    nodejs_22

    gcc
    vlc
    obsidian
    vesktop

    awscli2

    tradingview
  ];

  programs.btop.enable = true;
  services.blueman-applet.enable = true;

  programs.imv.enable = true;

  xdg.userDirs.desktop = null;
}
