{ pkgs, lib, config, user, ... }: {
  options = { vt.services.polkit.enable = lib.mkEnableOption "Polkit"; };
  config = {
    users.users.${user}.packages =
      lib.mkIf config.vt.services.polkit.enable [ pkgs.polkit_gnome ];

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 =
        lib.mkIf config.vt.services.polkit.enable {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart =
              "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };
    };
  };
}
