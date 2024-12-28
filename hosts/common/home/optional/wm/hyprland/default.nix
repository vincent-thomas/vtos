{ pkgs
, inputs
, ...
}:
{ extraConfig }:
let
  moreConfig = import ./extra-config.nix { inherit pkgs; };
in
{
  catppuccin.fuzzel.enable = true;
  home = {
    packages = [
      pkgs.wpaperd
      pkgs.waybar
      pkgs.pavucontrol
      pkgs.wl-clipboard
    ];
    file = {
      ".config/wpaperd/config.toml".text = ''
        [any]
        path = "${inputs.vt-wallpapers}"
      '';
      ".config/waybar".source = ./waybar;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      ${extraConfig}

      $menu = ${pkgs.fuzzel}/bin/fuzzel
      ${builtins.readFile ./hyprland.conf}
      bind = $mainMod, P, exec, ${pkgs.powertools}/bin/powertools

      ${moreConfig.waylandFix}
      ${moreConfig.brightnessConfig}
      ${moreConfig.mediaKeysConfig}
    '';
  };

}
