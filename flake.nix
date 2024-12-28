{
  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # Additional applications
    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs-unstable.follows = "nixpkgs";

    vt-nvim.url = "github:vincent-thomas/nvim";
    vt-nvim.inputs.nixpkgs.follows = "nixpkgs";

    # Other stuff
    vt-wallpapers.url = "github:vincent-thomas/wallpapers";
    vt-wallpapers.flake = false;
  };

  outputs =
    inputs@{ self, ... }:
    let
      inherit (inputs.nixpkgs) lib;
      inherit (self) outputs;

      utils = import ./utils.nix { inherit lib inputs outputs; };

      vtLib = utils.genVTLib ./lib;

      myStuff = vtLib.genFromPkgsDir {
        dir = ./pkgs;
        extraOverlays = [
          inputs.nur.overlays.default
          inputs.vt-nvim.overlays.default
        ];
      };

      forAllPkgs = vtLib.forAllPkgs { inherit (myStuff) overlays; };
    in
    {
      inherit (myStuff) packages;

      nixosConfigurations = import ./hosts {
        inherit inputs vtLib;
        inherit (myStuff) overlays;
      };

      nixosModules.default = import ./modules/nixos { inherit vtLib; };
      homeManagerModules.default = import ./modules/home { inherit vtLib; };

      formatter = vtLib.forAllPkgs { inherit (myStuff) overlays; } ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      checks = vtLib.forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks.nixpkgs-fmt.enable = true;
        };
      });

      devShells = forAllPkgs (
        { pkgs, system }:
        {
          default = pkgs.mkShell {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes";
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
            packages = with pkgs; [
              just
              sops
            ];
          };
        }
      );

    };
}
