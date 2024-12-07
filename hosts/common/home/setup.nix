{
  inputs,
  outputs,
  lib,
  ...
}:

{ user, homePath }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit user inputs;
    };
    users.${user} = {
      imports = [
        homePath
        inputs.catppuccin.homeManagerModules.catppuccin
        outputs.homeManagerModules.default

        ./core
      ];

      catppuccin = {
        enable = true;
        flavor = "macchiato";
        accent = "blue";
      };

      programs.home-manager.enable = true;

      home = {
        username = user;
        homeDirectory = lib.mkForce "/home/${user}";
        sessionPath = [
          "$HOME/.nix-profile/bin" # binaries
          "$HOME/.nix-profile/share/applications" # .desktop files
        ];
      };
    };
  };
}
