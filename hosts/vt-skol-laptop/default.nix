{ inputs, pkgs, outputs, ... }:
let

  username = "vt";

  coreModule = import ../common/nixos/core { hostname = "vt-skol-laptop"; };
  homeManagerModule =
    import ../common/home/setup.nix { inherit inputs outputs; };

  wslModule = import ../common/nixos/hardware/wsl.nix { inherit username; };

in {
  imports = [
    coreModule
    wslModule

    ../common/nixos/users/${username}

    (homeManagerModule {
      user = username;
      homePath = ./home.nix;
    })
  ];

  system.stateVersion = "24.05"; # Don't change

  users.users.vt.packages = with pkgs; [ vt-nvim ];
}
