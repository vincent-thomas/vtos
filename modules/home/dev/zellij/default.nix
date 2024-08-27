{ lib, config, ... }: {
  options = { vt.zellij.enable = lib.mkEnableOption "Enables zellij"; };
  config = {
    home.file.".config/zellij/config.kdl" = {
      text = lib.mkIf config.vt.zellij.enable
        (lib.mkForce (builtins.readFile ./config.kdl));
    };
    programs.zellij = lib.mkIf config.vt.zellij.enable {
      enable = true;
      catppuccin.enable = false;
    };
  };
}
