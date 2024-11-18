{ pkgs, ... }:
{
  systemd.user.services.dropbox = {
    description = "Dropbox service";
    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
      Environment = [
        "DISPLAY="
      ];
      ProtectSystem = "full";
    };
  };
}
