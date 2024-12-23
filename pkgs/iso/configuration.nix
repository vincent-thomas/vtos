{ pkgs, lib, ... }:
let
  coreModule = import ../../hosts/common/nixos/setup.nix { hostname = "vt-nixos-iso"; };
in
{
  environment.systemPackages = with pkgs; [ vt-nvim ];
  system.stateVersion = "24.05";

  imports = [
    coreModule
    ../../hosts/common/nixos/users/vt
  ];
}
