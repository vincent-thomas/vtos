{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      terminal.shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = [
          "new"
          "-Asroot"
          "-f"
          "~/.config/tmux/tmux.conf"
        ];
      };
      font = {
        size = 12;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
        bold = {
          style = "Heavy";
          family = "JetbrainsMono Nerd Font";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Heavy Italic";
        };
      };
    };
  };
}
