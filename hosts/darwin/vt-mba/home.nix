{ pkgs, inputs, ... }:
{
  home.stateVersion = "25.05";

  imports = [
    (import ../../common/home/optional/devsetup { isDarwin = true; })

    # ../../common/home/optional/devsetup
  ];

  programs.zsh.shellAliases = {
    gh = "op plugin run -- gh";
    cargo = "op plugin run -- cargo";
    flyctl = "op plugin run -- flyctl";
    stripe = "op plugin run -- stripe";
    aws = "op plugin run -- aws";
  };

  home.packages = with pkgs; [ _1password-cli ];

  # vt = {
  #   config.onepassword = {
  #     sshIntegration = false;
  #     zshOpPlugins.gh = true;
  #     zshOpPlugins.cargo = true;
  #     zshOpPlugins.stripe = true;
  #     zshOpPlugins.flyctl = true;
  #   };
  # };

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
