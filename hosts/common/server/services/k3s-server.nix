{ config, ... }:
{
  sops.secrets.k3s-secret = { };
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.sops.secrets.k3s-secret.path;
  };
}
