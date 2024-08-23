{ config, lib, ... }: {
  options = { vt.starship = { enable = lib.mkEnableOption "Enables zsh"; }; };
  config = lib.mkIf config.vt.starship.enable {
    home.file.".config/starship.toml".source = ./starship.toml;
    programs.starship = {
      enable = true;
      catppuccin.enable = false;
    };
  };
}
