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
  vt-mbp = mkDarwinSystem "vt-mbp" {
    inherit overlays self;
    system = "x86_64-darwin";
    extraModules = vtModules ++ [ ];
  };
}
