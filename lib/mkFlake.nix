{ inputs, lib, outputs, ... }:

{ vtLibSrc, pkgsDir,
# Extra overlays to apply
extraOverlays ? [ ], nixosModules ? { }, homeManagerModules ? { }
, nixosConfigurations, devShells ? { ... }: { } }:
let

  vtLib = vtLibSrc;
  generatedOverlayFromPackages = final: _prev:
    vtLib.mergeObjects (lib.lists.forEach (vtLib.listFiles pkgsDir) (package:
      # What the name of the pkgs name is, if file "nvim.nix" package is "pkgs.nvim".
      let pkgName = lib.strings.removeSuffix ".nix" package;
      in { ${pkgName} = packages.${final.system}.${pkgName}; }));

  overlays = extraOverlays ++ [ generatedOverlayFromPackages ];

  forAllSystemsWithPkgs = vtLib.forAllPkgs { inherit overlays; };

  packages = forAllSystemsWithPkgs ({ pkgs, system }:
    builtins.listToAttrs (map (folder: {
      # What the name of the pkgs name is, if file "nvim.nix" package name is "nvim".
      name = lib.strings.removeSuffix ".nix" folder;
      value = pkgs.callPackage (lib.path.append pkgsDir folder) {
        inherit inputs system outputs pkgs;
      };
    }) (vtLib.listFiles pkgsDir)));

in {
  inherit packages;
  inherit nixosModules;
  inherit homeManagerModules;
  nixosConfigurations = nixosConfigurations overlays;

  devShells = forAllSystemsWithPkgs
    ({ pkgs, system }: devShells { inherit pkgs system; });
}
