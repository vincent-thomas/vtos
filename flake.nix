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

    vt-wallpapers.url = "github:vincent-thomas/wallpapers";
    vt-wallpapers.flake = false;

    vt-nvim.url = "github:vincent-thomas/nvim";
    vt-nvim.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    inputs@{ self, ... }:
    let
      inherit (inputs.nixpkgs) lib;
      inherit (self) outputs;

      # Automatically include all under the ./lib directory
      vtLib = builtins.listToAttrs (
        map
          (folder: {
            name = lib.strings.removeSuffix ".nix" folder;
            value = import ./lib/${folder} {
              inherit lib inputs outputs;
              self = vtLib;
            };
          })
          (import ./lib/listFiles.nix { } ./lib)
      );

      extraOverlays = [
        inputs.nur.overlays.default
        inputs.vt-nvim.overlays.default
      ];

    in
    vtLib.mkFlake
      {
        vtLibSrc = vtLib;

        # Automatically import packages using their filename as the package name,
        # Then including them into the pkgs namespace using an overlay which it
        # automatically hands to nixosConfigurations and devShells.
        pkgsDir = ./pkgs;

        # Extra overlays to and into nixosConfigurations
        inherit extraOverlays;

        nixosConfigurations = overlays: import ./hosts { inherit inputs vtLib overlays; };

        devShells =
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
          };

      }
    // {
      nixosModules.default = import ./modules/nixos { inherit vtLib; };
      homeManagerModules.default = import ./modules/home { inherit vtLib; };
      checks = vtLib.forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      });
      formatter = (
        vtLib.forAllPkgs { overlays = extraOverlays; } ({ system, pkgs }: pkgs.nixfmt-rfc-style)
      );
    };
}
