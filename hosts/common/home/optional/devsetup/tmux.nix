{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    mouse = true;
    terminal = "xterm-256color";
    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc" # Color issue fix.

      set -g automatic-rename on # rename window to reflect current program
      set -g renumber-windows on # renumber windows when a window is closed

      bind f run-shell "tmux neww ${pkgs.tmux-tools}/bin/tmux-sessionizer"
      bind F run-shell "tmux neww ${pkgs.tmux-tools}/bin/tmux-list-sessions"

      bind r source-file ~/.config/tmux/tmux.conf
      bind D detach
      bind d switch-client -t root

      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # Use Alt-vim keys without prefix key to switch panes
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D 
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
    '';
  };
}
