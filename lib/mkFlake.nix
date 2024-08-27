{ inputs, lib, outputs, ... }:

{ vtLibSrc, pkgsDir, extraOverlays, nixosModules, homeManagerModules
, nixosConfigurations ? _: { }, devShell ? false }:
let

  vtLib = vtLibSrc;
  generatedOverlayFromPackages = final: _prev:
    vtLib.mergeObjects (lib.lists.forEach (vtLib.listFiles pkgsDir) (package:
      let pkgName = lib.strings.removeSuffix ".nix" package;
      in { ${pkgName} = packages.${final.system}.${pkgName}; }));

  overlays = extraOverlays ++ [ generatedOverlayFromPackages ];

  forAllSystemsWithPkgs = vtLib.forAllPkgs { inherit overlays; };

  packages = forAllSystemsWithPkgs ({ pkgs, system }:
    builtins.listToAttrs (map (folder: {
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

  devShells = if devShell != false then
    forAllSystemsWithPkgs ({ pkgs, system }: devShell { inherit pkgs system; })
  else
    null;
}

