{
  overlays,
  vtLib,
  inputs,
  self,
  ...
}:
let
  inherit (vtLib) mkDarwinSystem;
  vtModules = [
    inputs.home-manager.darwinModules.home-manager
  ];
in
{
  vt-mba = mkDarwinSystem "vt-mba" {
    inherit overlays self;
    system = "aarch64-darwin";
    extraModules = vtModules ++ [ ];
  };
}
