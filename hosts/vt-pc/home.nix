{ pkgs, inputs, ... }:
{
  home.stateVersion = "23.11";

  imports = [
    ../common/home/optional/devsetup
    ../common/home/optional/virt-manager.nix

    (import ../common/home/optional/wm/hyprland { inherit inputs pkgs; } { extraConfig = ""; })
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
  };

  home.packages = with pkgs; [
    angryipscanner

    cargo
    rustc

    pnpm_9
    nodejs_22

    gcc
    vlc
    obsidian

    awscli2

    kustomize
    kubernetes-helm

    # For school
    ungoogled-chromium
    brave

    go
  ];

  programs.btop.enable = true;
  services.blueman-applet.enable = true;

  # programs.imv.enable = true;

  xdg.userDirs.desktop = null;
}
