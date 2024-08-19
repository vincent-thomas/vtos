{ inputs, outputs, ... }:
let inherit (inputs.nixpkgs) lib;
in {
  unstable-packages = import ./unstable-packages-mount.nix {
    inherit (inputs) nixpkgs-unstable;
    inherit lib;
  };
  nur = import ./nur.nix { inherit inputs; };
  vt-nvim = import ./vt-nvim.nix { inherit outputs; };
}
