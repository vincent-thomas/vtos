{ lib, inputs, ... }:

hostname:
{ system, extraModules }:

lib.nixosSystem {
  inherit system;

  specialArgs = inputs;
  modules = extraModules ++ [
    ../hosts/${hostname}
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.catppuccin
    #
    # ({ lib, config, ... }: {
    #
    #   home-manager = {
    #     useGlobalPkgs = true;
    #     useUserPackages = true;
    #     extraSpecialArgs = { inherit inputs user; };
    #     users.${user} = {
    #       imports = [
    #         ../users/${user}
    #         ../homeModules
    #
    #         catppuccin.home-manager
    #       ];
    #
    #       catppuccin = {
    #         enable = true;
    #         flavor = "frappe";
    #         accent = "blue";
    #       };
    #
    #       programs.home-manager.enable = true;
    #
    #       # nixpkgs.config = {
    #       #   allowUnsafeNativeCodeDuringEvaluation = true;
    #       #   allowUnfreePredicate = pkg:
    #       #     builtins.elem (lib.getName pkg) allowed-unfree-packages;
    #       # };
    #
    #       home.username = user;
    #       home.homeDirectory = "/home/${user}";
    #       home.sessionPath = [
    #         "$HOME/.nix-profile/bin" # binaries
    #         "$HOME/.nix-profile/share/applications" # .desktop files
    #       ];
    #     };
    #   };
    # })
    # #
    # #   home-manager.useGlobalPkgs = true;
    # #   home-manager.useUserPackages = true;
    # #   home-manager.users.${user} = {
    # #     imports = [
    # #       ../users/${user}
    # #       ../homeModules
    # #
    # #       catppuccin.home-manager
    # #     ];
    # #
    # #   programs.home-manager.enable = true;
    # #
    # #   nixpkgs.config = {
    # #     allowUnsafeNativeCodeDuringEvaluation = true;
    # #     allowUnfreePredicate = pkg:
    # #       builtins.elem (lib.getName pkg) allowed-unfree-packages;
    # #   };
    # #
    # #   home.username = user;
    # #   home.homeDirectory = "/home/${user}";
    # #   home.sessionPath = [
    # #     "$HOME/.nix-profile/bin" # binaries
    # #     "$HOME/.nix-profile/share/applications" # .desktop files
    # #   ];
    # # };
    # # home-manager.extraSpecialArgs = { inherit inputs user; };
    # #   };
    # # })
  ];
}
