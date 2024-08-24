{ inputs, outputs, overlays, ... }:
let
  mkSystem = import ../lib/mksystem.nix { inherit inputs outputs; };
  sharedModules = [
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];
in {
  vt-pc = mkSystem "vt-pc" {
    system = "x86_64-linux";
    overlays = builtins.attrValues overlays;
    extraModules = sharedModules
      ++ [ inputs.catppuccin.nixosModules.catppuccin ];
  };
  vt-skol-laptop = mkSystem "vt-skol-laptop" {
    system = "x86_64-linux";
    overlays = builtins.attrValues overlays;
    extraModules = sharedModules ++ [ inputs.nixos-wsl.nixosModules.default ];
  };
}
