_: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      terminal.shell = {
        program = "tmux";
        args = [
          "new"
          "-Asroot"
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
