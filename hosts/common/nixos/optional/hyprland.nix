{ pkgs-stable, ... }: {

  programs.hyprland = {
    enable = true;
    portalPackage = pkgs-stable.xdg-desktop-portal-hyprland;
    package = pkgs-stable.hyprland;
  };
}
