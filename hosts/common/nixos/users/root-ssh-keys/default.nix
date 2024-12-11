{ config, ... }:
{
  users.users.root = {
    hashedPasswordFile = config.age.secrets.vt-password.path;
  };

  # Hack
  systemd.tmpfiles.rules = [
    "f /root/.ssh/authorized_keys 0600 root root - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIabDDV+gsXjqT653qeoHkTDcRsXcwv1hu4S//3II3Fh"
  ];

}
