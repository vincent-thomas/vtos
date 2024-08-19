{ config, lib, ... }: {

  options = {
    vt = {
      dot = {
        wallpapers = lib.mkEnableOption "vt.dot.wallpapers";
        scripts = lib.mkEnableOption "vt.dot.scripts";
        zshIntegration = lib.mkEnableOption "Zsh integration";
      };
    };
  };

  config = {
    home.file = {
      ".vt/scripts" = lib.mkIf config.vt.dot.scripts {
        source = ./scripts;
      };
      ".vt/wallpapers" = lib.mkIf config.vt.dot.scripts {
        source = ./wallpapers;
      };
    };

    programs.zsh.initExtra = lib.mkIf config.vt.dot.zshIntegration ''
      export PATH=$HOME/.vt/scripts:$PATH
    '';
  };

}
