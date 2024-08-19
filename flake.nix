{
  description = "vtOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
      };
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (self) outputs;

      mkSystem = import ./lib/mksystem.nix { inherit inputs outputs; };

      overlays = import ./overlays { inherit inputs outputs; };

    in {
      nixosModules.default = import ./nixosModules;
      homeManagerModules.default = import ./homeModules;

      inherit overlays;

      devShells = import ./devShells.nix { inherit inputs lib; };
      nixosConfigurations = {
        vt-pc = mkSystem "vt-pc" {
          system = "x86_64-linux";
          overlays = builtins.attrValues overlays;
          extraModules = [
            inputs.agenix.nixosModules.default
            inputs.catppuccin.nixosModules.catppuccin
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        vt-skol-laptop = mkSystem "vt-skol-laptop" {
          system = "x86_64-linux";
          overlays = builtins.attrValues overlays;
          extraModules = [
            inputs.agenix.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-wsl.nixosModules.default
          ];
        };
      };
    };
}
