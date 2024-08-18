{ inputs, ... }:

user: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit user; };
    users.${user} = {
      imports = [
        ../users/${user}
        ../homeModules

        inputs.catppuccin.homeManagerModules.catppuccin
      ];

      catppuccin = {
        enable = true;
        flavor = "frappe";
        accent = "blue";
      };

      programs.home-manager.enable = true;

      home.username = user;
      home.homeDirectory = "/home/${user}";
      home.sessionPath = [
        "$HOME/.nix-profile/bin" # binaries
        "$HOME/.nix-profile/share/applications" # .desktop files
      ];
    };
  };
}

