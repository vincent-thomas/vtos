{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    vt.tmux.enable = lib.mkEnableOption "Enables tmux";
  };
  config = {
    programs.tmux = lib.mkIf config.vt.tmux.enable {
      enable = true;
      keyMode = "vi";
      baseIndex = 1;
      mouse = true;
      terminal = "xterm-256color";
      extraConfig = ''
        set-option -ga terminal-overrides ",xterm-256color:Tc"
        set -g automatic-rename on   # rename window to reflect current program
        set -g renumber-windows on    # renumber windows when a window is closed

        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R

        bind-key -r f run-shell "tmux neww ${pkgs.tmux-tools}/bin/tmux-sessionizer"
        bind-key -r F run-shell "tmux neww ${pkgs.tmux-tools}/bin/tmux-list-sessions"

        bind r source-file ~/.config/tmux/tmux.conf
        bind D detach
        bind d switch-client -t root
      '';
    };
  };
}
