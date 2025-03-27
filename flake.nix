{
  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://vt-nvim.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "vt-nvim.cachix.org-1:wphAxtBWVTY7PNTNwT1HzvQwsIBLl9RY/em+HeFjBgc="
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

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # Additional applications
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

      treefmtEval = forAllPkgs (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      inherit (myStuff) packages;

      nixosConfigurations = import ./hosts {
        inherit inputs vtLib;
        inherit (myStuff) overlays;
      };

      nixosModules.default = import ./modules/nixos { inherit vtLib; };
      homeManagerModules.default = import ./modules/home { inherit vtLib; };

      formatter = forAllPkgs (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      checks = vtLib.forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks.treefmt = {
            enable = true;
            package = outputs.formatter.${system};
          };
        };
      });

      devShells = forAllPkgs (pkgs: {
        default = pkgs.mkShell {
          NIX_CONFIG = "extra-experimental-features = nix-command flakes";
          inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${pkgs.system}.pre-commit-check.enabledPackages;
          packages = with pkgs; [
            just
            sops
            age
          ];
        };
      });
    };
}
