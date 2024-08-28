{ config, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    package = import ./nvidia/pkg.nix { inherit config; };
  };
}
