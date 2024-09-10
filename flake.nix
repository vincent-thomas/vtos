{
  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://vtos.cachix.org"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "vtos.cachix.org-1:ixP7qoCKWViIMMGj+RDMnTuqoi3N9+D9u7Z+Ty9SYcQ="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";

    # NUR
    nur.url = "github:nix-community/NUR";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs = {
      nixpkgs.follows = "nixpkgs";
      darwin.follows = "";
    };

    # Nixvim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # ISO Generations
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    vt-wallpapers.url = "gitlab:vincent_thomas1/wallpapers";
    vt-wallpapers.flake = false;

    vt-nvim.url = "github:vincent-thomas/nvim";
    vt-nvim.inputs.nixpkgs.follows = "nixpkgs";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      inherit (inputs.self) outputs;

      # Automatically include all under the ./lib directory
      vtLib = builtins.listToAttrs (
        map (folder: {
          name = lib.strings.removeSuffix ".nix" folder;
          value = import ./lib/${folder} {
            inherit lib inputs outputs;
            self = vtLib;
          };
        }) (import ./lib/listFiles.nix { } ./lib)
      );

    in
    vtLib.mkFlake {
      vtLibSrc = vtLib;

      # Automatically import packages using their filename as the package name,
      # Then including them into the pkgs namespace using an overlay which it
      # automatically hands to nixosConfigurations and devShells.
      pkgsDir = ./pkgs;

      # Extra overlays to and into nixosConfigurations
      extraOverlays = [
        inputs.nur.overlay
        inputs.deploy-rs.overlay
        inputs.vt-nvim.overlays.default
      ];

      nixosConfigurations = overlays: import ./hosts { inherit inputs vtLib overlays; };

      devShells =
        { pkgs, system }:
        {
          default = import ./devShell.nix { inherit inputs system pkgs; };
        };
    }
    // {
      nixosModules.default = import ./modules/nixos { inherit vtLib; };
      homeManagerModules.default = import ./modules/home { inherit vtLib; };

      deploy = vtLib.mkDeploy { inherit (inputs) self; };
      checks = builtins.mapAttrs (
        system: deployLib: deployLib.deployChecks inputs.self.deploy
      ) inputs.deploy-rs.lib;
    };
}
