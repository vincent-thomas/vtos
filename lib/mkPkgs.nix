{ inputs, overlays ? [ ], lib, ... }:

{ system }:
import inputs.nixpkgs {
  inherit system overlays;
  config = import ../nixpkgsConfig.nix { inherit lib; };
}
