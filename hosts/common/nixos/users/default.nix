{ config, ... }:
{
  users.mutableUsers = false;
  sops.secrets.password.neededForUsers = true;

  users.users.root.hashedPasswordFile = config.sops.secrets.password.path;
}
