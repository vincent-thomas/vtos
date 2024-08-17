{ nixpkgs, inputs, allowed-unfree-packages }:

hostname:
{ system, user, }:

let
  homeManagerModule = inputs.home-manager.nixosModules.home-manager;
  catppuccin = {
    nixos = inputs.catppuccin.nixosModules.catppuccin;
    home-manager = inputs.catppuccin.homeManagerModules.catppuccin;
  };

in nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = { inherit inputs user allowed-unfree-packages; };
  modules = [
    ../hosts/${hostname}
    ../hosts/base.nix
    ../nixosModules
    catppuccin.nixos
    homeManagerModule
    ({ pkgs, ... }:
      let createUser = import ./createuser.nix { inherit pkgs; };
      in createUser {
        username = user;
        shell = "zsh";
        userGroups = [ "wheel" "networkmanager" "libvirtd" ];
        isRoot = false;
      })
    {
      networking.hostName = hostname;

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = {
        imports = [
          ../users/${user}
          ../homeModules

          catppuccin.home-manager
        ];

        catppuccin = {
          enable = true;
          flavor = "frappe";
          accent = "blue";
        };

        programs.home-manager.enable = true;
        nixpkgs.config.allowUnfree = true;

        home.username = user;
        home.homeDirectory = "/home/${user}";
        home.sessionPath = [
          "$HOME/.nix-profile/bin" # binaries
          "$HOME/.nix-profile/share/applications" # .desktop files
        ];
      };
      home-manager.extraSpecialArgs = {
        inherit inputs user allowed-unfree-packages;
      };
    }
  ];
}
