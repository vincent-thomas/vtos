{ pkgs, config, ... }: {
  imports = [ ../. ];
  users.users.vt = {
    home = "/home/vt";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.vt-password.path;
  };
}
