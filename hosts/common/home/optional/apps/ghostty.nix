{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.ghostty.packages.${pkgs.system}.default
  ];

  home.file.".config/ghostty/config".text = ''
    theme = catppuccin-macchiato
    command = ${pkgs.tmux}/bin/tmux new -Asroot
  '';
}
