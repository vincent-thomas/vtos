{ nixpkgs-unstable, lib }:
final: _prev: {
  unstable = import nixpkgs-unstable {
    inherit (final) system;
    config = import ../nixpkgsConfig.nix { inherit lib; };
  };
}

