{ config, ... }:
{
  hardware.graphics = {
    enable = true;
    # driSupport = true;
    package = import ./nvidia/pkg.nix { inherit config; };
  };
}
