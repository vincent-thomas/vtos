{ lib, config, ... }: {
  options = { vt.tmux.enable = lib.mkEnableOption "Enables zellij"; };
  config = {
    programs.tmux = lib.mkIf config.vt.tmux.enable {
      enable = true;
      extraConfig = ''
        set -g mouse on
        set -g default-terminal "xterm-256color"
        set-option -ga terminal-overrides ",xterm-256color:Tc"
        set -g base-index 1           # start windows numbering at 1
        setw -g automatic-rename on   # rename window to reflect current program
        set -g renumber-windows on    # renumber windows when a window is closed

        bind-key -r f run-shell "tmux neww tmux-sessionizer"
        bind r source-file ~/.config/tmux/tmux.conf
        bind D detach
        bind d switch-client -t root
        bind U run "cut -c3- '#{TMUX_CONF}' | sh -s _urlview '#{pane_id}'"
      '';
    };
  };
}
