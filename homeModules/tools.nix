{ pkgs, config, lib, ... }: {

  options = {
    vt.cliTools = {
      enable = lib.mkEnableOption "yazi";
      zshIntegration = lib.mkEnableOption "Zsh integration";
    };
  };

  config = {
    home.packages =
      lib.mkIf config.vt.cliTools.enable (with pkgs; [ ripgrep gh jq fd ]);

    programs.fzf = lib.mkIf config.vt.cliTools.enable {
      enable = true;
      enableZshIntegration = config.vt.cliTools.zshIntegration;
    };

    programs.yazi.enable = config.vt.cliTools.enable;

    programs.eza = lib.mkIf config.vt.cliTools.enable {
      enable = true;
      icons = true;
      enableZshIntegration = config.vt.cliTools.zshIntegration;
      git = true;
    };

  };
}
