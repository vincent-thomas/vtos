{ hostname, ... }:
{
  imports = [
    ./age.nix
    ./zsh.nix
    ./locales.nix
    ./no-docs.nix
    ./nix-settings.nix
    ./services/ssh.nix
    ./services/nix-gc.nix
  ];

  vt.services.networking.hostname = hostname;
}
