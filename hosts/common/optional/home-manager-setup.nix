{ inputs, outputs, ... }:

{ user }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit user inputs; };
    users.${user} = {
      imports = [
        ../../../users/${user}
        inputs.catppuccin.homeManagerModules.catppuccin
        outputs.homeManagerModules.default
      ];

      catppuccin = {
        enable = true;
        flavor = "frappe";
        accent = "blue";
      };

      programs.home-manager.enable = true;

      home = {
        username = user;
        homeDirectory = "/home/${user}";
        sessionPath = [
          "$HOME/.nix-profile/bin" # binaries
          "$HOME/.nix-profile/share/applications" # .desktop files
        ];
      };
    };
  };
}

