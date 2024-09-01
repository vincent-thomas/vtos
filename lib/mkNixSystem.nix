{ inputs, outputs, self, ... }:
hostname:
{ system, overlays ? [ ], extraModules ? [ ] }:
let inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit system;

  pkgs = self.mkPkgs { inherit system overlays; };
  specialArgs = {
    inherit inputs outputs;

    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system overlays;
      config = import ../nixpkgsConfig.nix { inherit lib; };
    };
  };

  modules = extraModules ++ [
    ../hosts/${hostname}
    outputs.nixosModules.default
    inputs.comin.nixosModules.comin
    { nixpkgs.hostPlatform = lib.mkDefault system; }
  ];
}
