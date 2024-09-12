{
  ...
}:
let
  coreModule = import ../common/nixos/core { hostname = "homelab-k3s-master-01"; };
in
{
  system.stateVersion = "24.05";
  imports = [
    coreModule
    ./hardware.nix

    ../common/nixos/users/root-ssh-keys
    ../common/server/optional/qemu.nix
  ];
}
