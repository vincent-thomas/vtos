{ inputs, ... }:
let inherit (inputs.nixpkgs) lib;
in {
  unstable-packages = import ./unstable-packages-mount.nix {
    nixpkgs-unstable = inputs.nixpkgs-unstable;
    inherit lib;
  };
}
