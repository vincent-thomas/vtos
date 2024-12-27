{ lib
, ...
}:
let
  coreModule = import ../common/nixos/setup.nix { hostname = "homelab-k3s-master-01"; };
in
{
  system.stateVersion = "24.05";
  imports = [
    coreModule
    ./hardware.nix

    ../common/nixos/users

    ../common/server/optional/qemu.nix
  ];

  users.users.root.hashedPasswordFile = lib.mkForce null;
}
