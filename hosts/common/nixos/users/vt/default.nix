{ pkgs, config, ... }: {
  imports = [ ../. ../root-ssh-keys ];
  users.users.vt = {
    home = "/home/vt";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.vt-password.path;
  };
}
