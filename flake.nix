{
  description = "vtOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      mkSystem = import ./lib/mksystem.nix { inherit lib inputs; };
    in {
      nixosModules = import ./nixosModules;
      homeManagerModules = import ./homeModules;

      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes";
            packages = [ inputs.agenix.packages.${system}.default pkgs.age ];
          };
        });

      nixosConfigurations = {
        "vt-pc" = mkSystem "vt-pc" {
          system = "x86_64-linux";
          extraModules = [ ];
        };
      };

      # nixosConfigurations."vt-pc" = lib.nixosSystem {
      #   inherit system;
      #   specialArgs = inputs;
      #   modules = [
      #     ./hosts/vt-pc
      #     inputs.home-manager.nixosModules.home-manager
      #     {
      #       home-manager = {
      #         useGlobalPkgs = true;
      #         useUserPackages = true;
      #         users."vt" = import ./users/vt;
      #       };
      #     }
      #   ];
      # };
      # nixosConfigurations."vt-pc" = mkSystem "vt-pc" {
      #   system = "x86_64-linux";
      #   user = "vt";
      # };
      #
      # packages = {
      #   "x86_64-linux" = {
      #     iso = nixos-generators.nixosGenerate {
      #       system = "x86_64-linux";
      #       specialArgs = { inherit user inputs allowed-unfree-packages; };
      #       modules = [
      #         ({ ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
      #         ./hosts/vt-pc
      #       ];
      #       format = "iso";
      #     };
      #   };
      # };
    };
}

#
#   genSpecialArgs = system:
#     inputs // {
#       pkgs-unstable = import nixpkgs-unstable {
#         inherit system;
#         config.allowUnfree = true;
#       };
#       pkgs-stable = import nixpkgs {
#         inherit system;
#         config.allowUnfree = true;
#       };
#     };
#
#     args = {inherit inputs lib genSpecialArgs};
# allowed-unfree-packages = [ "obsidian" ];
#
# mkSystem = import ./lib/mksystem.nix {
#   inherit nixpkgs inputs allowed-unfree-packages nixpkgs-unstable;
# };
#
