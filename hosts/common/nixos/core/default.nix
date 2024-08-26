{ hostname, ... }: {
  imports = [
    ./age.nix
    ./zsh.nix
    ./locales.nix
    ./no-docs.nix
    ./nix-settings.nix
    ./services/ssh.nix
    (import ./services/networking.nix { inherit hostname; })
  ];
}
