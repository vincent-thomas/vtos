_: {
  # home.file.".config/starship.toml".source = ./starship.toml;
  programs.starship = {
    enable = true;
    catppuccin.enable = false;
    settings = {
      add_newline = false;
      format = "$time $hostname [::](black) $directory $character";

      character = {
        error_symbol = "[µ](red)";
        success_symbol = "[λ](yellow)";
      };

      directory = {
        disabled = false;
        format = "[$path](blue bold)";
      };

      time = {
        disabled = false;
        format = "[$time](overlay2 bold)";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname](mauve)";
        disabled = false;
      };

      palettes.catppuccin_macchiato = {
        base = "#24273a";
        blue = "#8aadf4";
        crust = "#181926";
        flamingo = "#f0c6c6";
        green = "#a6da95";
        lavender = "#b7bdf8";
        mantle = "#1e2030";
        maroon = "#ee99a0";
        mauve = "#c6a0f6";
        overlay0 = "#6e738d";
        overlay1 = "#8087a2";
        overlay2 = "#939ab7";
        peach = "#f5a97f";
        pink = "#f5bde6";
        red = "#ed8796";
        rosewater = "#f4dbd6";
        sapphire = "#7dc4e4";
        sky = "#91d7e3";
        subtext0 = "#a5adcb";
        subtext1 = "#b8c0e0";
        surface0 = "#363a4f";
        surface1 = "#494d64";
        surface2 = "#5b6078";
        teal = "#8bd5ca";
        text = "#cad3f5";
        yellow = "#eed49f";
      };
    };

  };
}
