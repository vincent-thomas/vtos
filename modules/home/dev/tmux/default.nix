{ lib, config, ... }: {
  options = { vt.tmux.enable = lib.mkEnableOption "Enables zellij"; };
  config = {
    programs.tmux = lib.mkIf config.vt.tmux.enable {
      enable = true;
      # settings = {
      #   simplified_ui = true;
      #   pane_frames = false;
      #   default_layout = "compact";
      #
      #   copy_on_select = false;
      # };
    };
  };
}
