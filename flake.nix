{
  description = "vtOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, nixos-generators, ... }@inputs:
    let
      allowed-unfree-packages = [ "obsidian" ];

      mkSystem = import ./lib/mksystem.nix {
        inherit nixpkgs inputs allowed-unfree-packages;
      };

      user = "vt";
    in {
      nixosConfigurations."${user}-pc" = mkSystem "${user}-pc" {
        system = "x86_64-linux";
        user = user;
      };

      packages = {
        "x86_64-linux" = {
          iso = nixos-generators.nixosGenerate {
            system = "x86_64-linux";
            specialArgs = { inherit user inputs allowed-unfree-packages; };
            modules = [
              ({ ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
              ./hosts/vt-pc
            ];
            format = "iso";
          };
        };
      };
    };
}
