{ ... }:
{
  programs.starship = {
    enable = true;
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
    };
  };
}
