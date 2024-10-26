{
  pkgs,
  config,
  lib,
  ...
}:
{

  options = {
    vt.cliTools = {
      enable = lib.mkEnableOption "yazi";
      zshIntegration = lib.mkEnableOption "Zsh integration";
    };
  };

  config = {
    home.packages = lib.mkIf config.vt.cliTools.enable (
      with pkgs;
      [
        ripgrep
        gh
        jq
        fd
      ]
    );

    programs = {
      fzf = lib.mkIf config.vt.cliTools.enable {
        enable = true;
        enableZshIntegration = config.vt.cliTools.zshIntegration;
      };
      yazi.enable = config.vt.cliTools.enable;
      eza = lib.mkIf config.vt.cliTools.enable {
        enable = true;
        icons = "auto";
        enableZshIntegration = config.vt.cliTools.zshIntegration;
        git = true;
      };

    };
  };
}
