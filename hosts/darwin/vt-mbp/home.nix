{ pkgs, inputs, ... }:
{
  home.stateVersion = "25.05";

  imports = [
    ../../common/home/optional/devsetup/git.nix
    ../../common/home/optional/devsetup/devshell.nix
    ../../common/home/optional/devsetup/starship.nix
    ../../common/home/optional/devsetup/tmux.nix
    ../../common/home/optional/devsetup/alacritty.nix

    # ../../common/home/optional/devsetup
  ];

  # home.packages = with pkgs; [
  #   angryipscanner
  #
  #   cargo
  #   rustc
  #
  #   pnpm_9
  #   nodejs_22
  #
  #   gcc
  #   vlc
  #   obsidian
  #
  #   awscli2
  #
  #   kustomize
  #   kubernetes-helm
  #
  #   # For school
  #   ungoogled-chromium
  #   brave
  #
  #   go
  # ];
  #
  # programs.btop.enable = true;
  # services.blueman-applet.enable = true;
  #
  # # programs.imv.enable = true;
  #
  # xdg.userDirs.desktop = null;
}
