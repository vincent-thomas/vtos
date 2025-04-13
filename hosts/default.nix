{
  inputs,
  overlays,
  vtLib,
  ...
}:
let
  inherit (vtLib) mkNixSystem mkWslSystem;

  vtModules = [
    inputs.home-manager.nixosModules.home-manager
  ];
in
{
  vt-pc = mkNixSystem "vt-pc" {
    inherit overlays;
    system = "x86_64-linux";
    extraModules = vtModules ++ [ inputs.catppuccin.nixosModules.catppuccin ];
  };

  vt-laptop = mkNixSystem "vt-laptop" {
    inherit overlays;
    system = "x86_64-linux";
    extraModules = vtModules ++ [ inputs.catppuccin.nixosModules.catppuccin ];
  };

  vt-skol-laptop = mkWslSystem "vt-skol-laptop" {
    inherit overlays;
    system = "x86_64-linux";
    extraModules = vtModules;
  };

  vt-pc-wsl = mkWslSystem "vt-pc-wsl" {
    inherit overlays;
    system = "x86_64-linux";
    extraModules = vtModules;
  };
}
