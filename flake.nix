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
      vtLib = builtins.listToAttrs (map (folder: {
        name = lib.strings.removeSuffix ".nix" folder;
        value = import ./lib/${folder} {
          inherit lib inputs outputs;
          self = vtLib;
        };
      }) (import ./lib/listFiles.nix { } ./lib));

    in vtLib.mkFlake {
      vtLibSrc = vtLib;

      pkgsDir = ./pkgs;

      extraOverlays = [ inputs.nur.overlay ];

      nixosModules.default = import ./modules/nixos;
      homeManagerModules.default = import ./modules/home;
      nixosConfigurations = overlays:
        import ./hosts { inherit inputs vtLib overlays; };

      devShell = { pkgs, system }:
        import ./devShells.nix { inherit inputs system pkgs; };
    };
}
