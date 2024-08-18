{
  # imports = [
  #   ./services
  #   ./dev
  #   ./zsh
  #   ./starship
  #   ./dot
  #   ./terminals
  #   ./wm
  #   ./apps
  #   ./tools.nix
  # ];

  services = import ./services;
  dev = import ./dev;
  zsh = import ./zsh;
  starship = import ./starship;
  dot = import ./dot;
  terminals = import ./terminals;
  wm = import ./wm;
  apps = import ./apps;
  tools = import ./tools.nix;
}
