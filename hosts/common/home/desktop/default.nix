{ pkgs, ... }: {
  imports = [ ./polybar ./flameshot.nix ];

  home.packages = with pkgs; [ gdu feh ];



}
