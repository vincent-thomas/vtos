{ lib, config, ... }: {
  options = { vt.zellij.enable = lib.mkEnableOption "Enables zellij"; };
  config = {
    programs.zellij = lib.mkIf config.vt.zellij.enable {
      enable = true;
      settings = {
        simplified_ui = true;
        pane_frames = false;
        default_layout = "compact";

        copy_on_select = false;
      };
    };
  };
}
