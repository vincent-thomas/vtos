{ inputs, outputs, self, ... }:
hostname:
{ system, overlays ? [ ], extraModules ? [ ] }:
let inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit system;

  # pkgs = import inputs.nixpkgs {
  #   inherit system overlays;
  #   config = import ../nixpkgsConfig.nix { inherit lib; };
  # };

  pkgs = self.mkPkgs { inherit system overlays; };
  specialArgs = { inherit inputs outputs; };
  modules = extraModules ++ [
    ../hosts/${hostname}
    outputs.nixosModules.default
    { nixpkgs.hostPlatform = lib.mkDefault system; }
  ];
}
