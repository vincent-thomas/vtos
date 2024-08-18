{ pkgs, ... }: {
  users.users.vt = {
    home = "/home/vt";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
}
