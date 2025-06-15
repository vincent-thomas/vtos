{
  inputs,
  outputs,
  self,
  ...
}:
let
  outerSelf = self;
in
hostname:
{
  system,
  overlays ? [ ],
  extraModules ? [ ],
  self,
}:
let
  inherit (inputs.nix-darwin) lib;
  pkgs = outerSelf.mkPkgs { inherit system overlays; };
in
lib.darwinSystem {
  inherit system pkgs;

  specialArgs = {
    inherit inputs outputs self;
  };

  modules = extraModules ++ [
    ../hosts/darwin/${hostname}
    {
      nixpkgs.hostPlatform = system;
      networking.hostName = hostname;
      nix.package = pkgs.nix;
    }
  ];
}
