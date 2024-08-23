{
  description = "vtOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (self) outputs;

      overlays = import ./overlays { inherit inputs outputs; };

      mkSystem = import ./lib/mksystem.nix { inherit inputs outputs; };
      forAllSystems = import ./lib/forAllSystems.nix { inherit lib; };
      mkPkgs = import ./lib/mkPkgs.nix {
        inherit inputs lib;
        overlays = builtins.attrValues overlays;
      };

      sharedModules = [
        inputs.agenix.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
      ];

    in {
      nixosModules.default = import ./modules/nixos;
      homeManagerModules.default = import ./modules/home;

      inherit overlays;

      packages = forAllSystems (system:
        import ./pkgs {
          inherit inputs system outputs;
          pkgs = mkPkgs { inherit system; };
        });

      devShells = forAllSystems
        (system: import ./devShells.nix { inherit inputs system; });

      nixosConfigurations = {
        vt-pc = mkSystem "vt-pc" {
          system = "x86_64-linux";
          overlays = builtins.attrValues overlays;
          extraModules = sharedModules
            ++ [ inputs.catppuccin.nixosModules.catppuccin ];
        };
        vt-skol-laptop = mkSystem "vt-skol-laptop" {
          system = "x86_64-linux";
          overlays = builtins.attrValues overlays;
          extraModules = sharedModules
            ++ [ inputs.nixos-wsl.nixosModules.default ];
        };
      };
    };
}
