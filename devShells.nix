{ inputs, system }:
let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    packages =
      [ inputs.agenix.packages.${system}.default pkgs.age pkgs.statix ];
  };
}
