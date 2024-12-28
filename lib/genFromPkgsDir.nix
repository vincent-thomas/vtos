{
  self,
  lib,
  inputs,
  outputs,
}:
{ dir, extraOverlays }:
# final: _prev:
let
  generatedOverlayFromPackages =
    final: _prev:
    self.mergeObjects (
      lib.lists.forEach (self.listFiles dir) (
        package:
        # What the name of the pkgs name is, if file "nvim.nix" package is "pkgs.nvim".
        let
          pkgName = lib.strings.removeSuffix ".nix" package;
        in
        {
          ${pkgName} = packages.${final.system}.${pkgName};
        }
      )
    );
  overlays = extraOverlays ++ [ generatedOverlayFromPackages ];

  forAllPkgs = self.forAllPkgs { inherit overlays; };
  packages = forAllPkgs (
    pkgs:
    builtins.listToAttrs (
      map (folder: {
        # What the name of the pkgs name is, if file "nvim.nix" package name is "nvim".
        name = lib.strings.removeSuffix ".nix" folder;
        value = pkgs.callPackage (lib.path.append dir folder) {
          inherit (pkgs) system;
          inherit
            inputs
            outputs
            pkgs
            ;
        };
      }) (self.listFiles dir)
    )
  );
in
{
  inherit overlays packages;
}
