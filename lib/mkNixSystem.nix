{
  inputs,
  outputs,
  self,
  ...
}:
hostname:
{
  system,
  overlays ? [ ],
  extraModules ? [ ],
}:
let
  # See issue: https://github.com/lilyinstarlight/nixos-cosmic/issues/226
  inherit (inputs.nixpkgs) lib;
in
lib.nixosSystem {
  inherit system;

  pkgs = self.mkPkgs { inherit system overlays; };
  specialArgs = {
    inherit inputs outputs;
  };

  modules = extraModules ++ [
    ../hosts/${hostname}
    outputs.nixosModules.default
    { nixpkgs.hostPlatform = system; }
  ];
}
