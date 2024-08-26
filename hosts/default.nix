{ inputs, overlays, myLib, ... }:
let
  inherit (myLib) mkNixSystem mkWslSystem;
  sharedModules = [
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];
in {
  vt-pc = mkNixSystem "vt-pc" {
    system = "x86_64-linux";
    overlays = builtins.attrValues overlays;
    extraModules = sharedModules
      ++ [ inputs.catppuccin.nixosModules.catppuccin ];
  };
  vt-skol-laptop = mkWslSystem "vt-skol-laptop" {
    system = "x86_64-linux";
    overlays = builtins.attrValues overlays;
    extraModules = sharedModules;
  };
}
