{ inputs, lib, ... }:
{
  system,
  overlays ? [ ],
}:
import inputs.nixpkgs {
  inherit system overlays;
  config = import ../nixpkgsConfig.nix { inherit lib; };
}
