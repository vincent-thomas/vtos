{ lib
, inputs
, outputs
, ...
}:
let
  genVTLib =
    dir:
    builtins.listToAttrs (
      map
        (folder: {
          name = lib.strings.removeSuffix ".nix" folder;
          value = import (lib.path.append dir folder) {
            inherit lib inputs outputs;
            self = genVTLib dir;
          };
        })
        (import ./lib/listFiles.nix { } dir)
    );
in
{
  inherit genVTLib;
}
