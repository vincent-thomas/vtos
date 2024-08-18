{ lib, config, pkgs, ... }: {
  options = {
    vt.user = {
      enable = lib.mkEnableOption "Enable user module";
      userName = lib.mkOption { default = "vt"; };
    };
  };

  config = lib.mkIf config.vt.user.enable {
    users.users.${config.vt.user.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
}
