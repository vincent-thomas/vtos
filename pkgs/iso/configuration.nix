{ pkgs, lib, ... }:
let
  coreModule =
    import ../../hosts/common/nixos/core { hostname = "vt-nixos-iso"; };
in {
  environment.systemPackages = with pkgs; [ vt-nvim ];
  system.stateVersion = "24.05";

  imports = [ coreModule ../../hosts/common/nixos/users/vt ];

  users.users.vt = {
    initialPassword = "vt";
    hashedPasswordFile = lib.mkForce null;
  };
}
