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
  pkgs = self.mkPkgs { inherit system overlays; };
in
lib.nixosSystem {
  inherit system pkgs;

  specialArgs = {
    inherit inputs outputs;
  };

  modules = extraModules ++ [
    ../hosts/nixos/${hostname}
    outputs.nixosModules.default
    {
      nixpkgs.hostPlatform = system;
      nix.package = pkgs.nix;
    }
  ];
}
