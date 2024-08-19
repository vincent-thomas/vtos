# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ inputs, pkgs, outputs, ... }:
let
  
  coreModule = import ../common/core { hostname = "vt-skol-laptop"; };
  homeManagerModule = import ../common/optional/home-manager-setup.nix {
    inherit inputs outputs;
  };
   
in {
  imports = [
    coreModule
    
    ../common/users/vt

    (homeManagerModule { user = "vt"; homePath = ./home.nix; })
  ];

  wsl.enable = true;
  wsl.defaultUser = "vt";
  
  system.stateVersion = "24.05"; # Don't change

  users.users.vt.packages = with pkgs; [
    vt-nvim
  ];
}
