{ pkgs, config, ... }:
{
  imports = [
    ../.
  ];

  # sops.secrets."ssh_keys/vt".path = "/home/vt/.ssh/id_ed25519";

  users.users.vt = {
    home = "/home/vt";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.password.path;
    openssh.authorizedKeys.keyFiles = [ ./key.pub ];
  };
}
