{
  inputs,
  outputs,
  lib,
  ...
}:

{
  userPath,
  user,
  homePath,
  isDarwin ? false,
}:
let
  # homeManagerModule =
  #   if (isDarwin == true) then
  #     inputs.home-manager.darwinModules.home-manager
  #   else
  #     inputs.home-manager.nixosModules.home-manager;
in
{
  # imports = [
  #   homeManagerModule
  # ];
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
        flavor = "mocha";
        accent = "blue";
      };

      programs.home-manager.enable = true;

      home = {
        username = user;
        homeDirectory = lib.mkForce userPath;
        sessionPath = [
          "$HOME/.nix-profile/bin" # binaries
          "$HOME/.nix-profile/share/applications" # .desktop files
        ];
      };
    };
  };
}
