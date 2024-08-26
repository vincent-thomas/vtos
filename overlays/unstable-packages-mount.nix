{ inputs, lib, ... }:
final: _prev: {
  unstable = import inputs.nixpkgs-unstable {
    inherit (final) system;
    config = import ../nixpkgsConfig.nix { inherit lib; };
  };
}

