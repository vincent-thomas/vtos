{ lib, config, ... }: {
  options = { vt.tmux.enable = lib.mkEnableOption "Enables zellij"; };
  config = {
    programs.tmux = lib.mkIf config.vt.tmux.enable {
      enable = true;
      extraConfig = ''
        bind-key -r s run-shell "tmux neww"
      '';
    };
  };
}
