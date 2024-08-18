{
  description = "vtOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

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

      overlays = import ./overlays { inherit inputs outputs; };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = builtins.attrValues overlays;

        config = {
          allowUnfreePredicate = pkg:
            builtins.elem (lib.getName pkg) [
              "1password"
              "1password-cli"
              "nvidia-x11"
              "todoist-electron"
              "discord"
              "davinci-resolve"
            ];
        };
      };

    in {
      nixosModules.default = import ./nixosModules;
      homeManagerModules.default = import ./homeModules;
      overlays = overlays;

      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes";
            packages = [ inputs.agenix.packages.${system}.default pkgs.age ];
          };
        });

      nixosConfigurations = {
        vt-pc = lib.nixosSystem {
          system = "x86_64-linux";

          pkgs = pkgs;

          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/vt-pc
            inputs.agenix.nixosModules.default
            inputs.catppuccin.nixosModules.catppuccin
            inputs.home-manager.nixosModules.home-manager
            outputs.nixosModules.default
          ];
        };
      };
    };
}
