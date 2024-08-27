{ lib, config, ... }: {
  options = { vt.zellij.enable = lib.mkEnableOption "Enables zellij"; };
  config = {
    home.file = lib.mkIf config.vt.zellij.enable {
      ".config/zellij/config.kdl" = {
        text = (lib.mkForce (builtins.readFile ./config.kdl));
      };
    };
    programs.zellij = lib.mkIf config.vt.zellij.enable {
      enable = true;
      catppuccin.enable = false;
    };
  };
}
