{ lib, config, ... }: {
  options = {
    vt.apps.onepassword = {
      enable = lib.mkEnableOption "1Password";
      username = lib.mkOption {
        type = lib.types.str;
        description = "User logged in username";
      };
    };
  };

  config = {
    programs._1password.enable = config.vt.apps.onepassword.enable;

    programs._1password-gui = {
      inherit (config.vt.apps.onepassword) enable;
      polkitPolicyOwners = [ config.vt.apps.onepassword.username ];
    };
  };
}
