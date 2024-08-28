{ inputs, outputs, self, ... }:
hostname:
{ system, overlays ? [ ], extraModules ? [ ] }:
let inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit system;

  pkgs = self.mkPkgs { inherit system overlays; };
  specialArgs = { inherit inputs outputs; };
  modules = extraModules ++ [
    ../hosts/${hostname}
    outputs.nixosModules.default
    inputs.comin.nixosModules.comin
    { nixpkgs.hostPlatform = lib.mkDefault system; }
  ];
}
