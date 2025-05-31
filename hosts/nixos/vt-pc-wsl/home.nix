{ pkgs, ... }:
{
  home.stateVersion = "23.11";

  imports = [ ../../common/home/optional/devsetup ];

  home.packages = with pkgs; [
    cargo
    gcc
    nodejs_22
    nodePackages.pnpm
    wget
    docker
    _1password-cli
  ];

  home.file.".ssh/config".text = ''
    Host github.com
      IdentityFile /home/vt/.ssh/github
  '';

  vt = {
    config.onepassword = {
      disableWslIntegration = true;
      sshIntegration = false;
      # zshOpPlugins.gh = true;
      # zshOpPlugins.cargo = true;
      # zshOpPlugins.stripe = true;
      # zshOpPlugins.flyctl = true;
    };
  };

  programs.btop.enable = true;

}
