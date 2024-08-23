{ pkgs, ... }:
let coreModule = import ../../hosts/common/nixos/core { hostname = "vt-iso"; };
in {
  environment.systemPackages = with pkgs; [ vt-nvim ];
  system.stateVersion = "24.05";

  imports = [ coreModule ];

  users.users.vt = {
    home = "/home/vt";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    initialPassword = "vt";
  };
}
