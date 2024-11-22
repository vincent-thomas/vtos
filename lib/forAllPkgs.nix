{ self, ... }:

{
  overlays ? [ ],
}:
f:
self.forAllSystems (
  system:
  let
    pkgs = self.mkPkgs { inherit system overlays; };
  in
  f { inherit system pkgs; }
)
