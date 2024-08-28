{ hostname, ... }: {
  imports = [
    ./age.nix
    ./zsh.nix
    ./locales.nix
    ./no-docs.nix
    ./nix-settings.nix
    ./services/ssh.nix
  ];

  vt.services.networking.hostname = hostname;
}
