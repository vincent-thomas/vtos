{
  inputs,
  outputs,
  lib,
  ...
}:
let

  username = "vt";

  coreModule = import ../../common/nixos/setup.nix { hostname = "vt-pc-wsl"; };
  homeManagerModule = import ../../common/home/setup.nix { inherit inputs outputs lib; };

  wslModule = import ../../common/nixos/hardware/wsl.nix { inherit username; };
in
{
  system.stateVersion = "24.05"; # Don't change

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  imports = [
    coreModule
    wslModule
    inputs.vscode-server.nixosModules.default

    ../../common/nixos/users/${username}

    (homeManagerModule {
      user = username;
      userPath = "/home/${username}";
      homePath = ./home.nix;
    })
  ];

  services.vscode-server = {
    enable = true;
  };

}
