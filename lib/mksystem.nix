{ inputs, outputs }:
let inherit (inputs.nixpkgs) lib;
in hostname:
{ system, pkgs, extraModules }:

lib.nixosSystem {
  inherit system pkgs;
  specialArgs = { inherit inputs outputs; };
  modules = extraModules
    ++ [ ../hosts/${hostname} outputs.nixosModules.default ];
}
