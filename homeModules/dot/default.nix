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
      ".vt/scripts".source = lib.mkIf config.vt.dot.scripts ./scripts;
      ".vt/wallpapers".source = lib.mkIf config.vt.dot.wallpapers ./wallpapers;
    };

    programs.zsh.initExtra = lib.mkIf config.vt.dot.zshIntegration ''
      export PATH=$HOME/.vt/scripts:$PATH
    '';
  };

}
