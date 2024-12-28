{ self, inputs, ... }:

hostname:
{
  system,
  overlays ? [ ],
  extraModules ? [ ],
}:
self.mkNixSystem hostname {
  inherit system overlays;
  extraModules = extraModules ++ [ inputs.nixos-wsl.nixosModules.default ];
}
