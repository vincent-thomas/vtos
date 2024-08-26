{
  description = "vtOS";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # NUR
    nur.url = "github:nix-community/NUR";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs = {
      nixpkgs.follows = "nixpkgs";
      darwin.follows = "";
    };

    # ISO Generations
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Nixvim
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (self) outputs;

      # Automatically include all under the ./lib directory
      myLib = builtins.listToAttrs (map (folder: {
        name = lib.strings.removeSuffix ".nix" folder;
        value = import ./lib/${folder} {
          inherit lib inputs outputs;
          self = myLib;
        };
      }) (import ./lib/listFiles.nix { } ./lib));

      # Automatically include all under the ./overlays directory
      overlays = builtins.listToAttrs (map (folder: {
        name = lib.strings.removeSuffix ".nix" folder;
        value = import ./overlays/${folder} { inherit inputs outputs lib; };
      }) (myLib.listFiles ./overlays));

      overlaysList = builtins.attrValues overlays;

      forAllSystemsWithPkgs = myLib.forAllPkgs { overlays = overlaysList; };
    in {
      # Overlays
      inherit overlays;

      # Modules
      nixosModules.default = import ./modules/nixos;
      homeManagerModules.default = import ./modules/home;

      # NixOS configuration
      nixosConfigurations = import ./hosts {
        inherit inputs myLib;
        overlays = overlaysList;
      };

      # DevShell
      devShells = forAllSystemsWithPkgs ({ pkgs, system }:
        import ./devShells.nix { inherit inputs system pkgs; });

      # Packages, automatically include all under ./packages directory
      packages = forAllSystemsWithPkgs ({ pkgs, system }:
        builtins.listToAttrs (map (folder: {
          name = lib.strings.removeSuffix ".nix" folder;
          value = pkgs.callPackage ./pkgs/${folder} {
            inherit inputs system outputs pkgs;
          };
        }) (myLib.listFiles ./pkgs)));
    };
}
