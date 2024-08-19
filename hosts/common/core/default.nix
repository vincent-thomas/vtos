{ hostname }: {
  imports = [
    ./age.nix
    ./zsh.nix
    ./locales.nix
    ./nix-settings.nix
    ./services/ssh.nix
    (import ./services/networking.nix { inherit hostname; })
  ];
}
