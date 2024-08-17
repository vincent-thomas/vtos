{ pkgs, lib, ... }: {
  services.polybar = {
    catppuccin.enable = false;
    enable = false;
    script = "polybar";
    extraConfig = ''
      ${builtins.readFile ./config/colors.ini}
      ${builtins.readFile ./config/modules.ini}
      ${builtins.readFile ./config/config.ini}
    '';
    package = pkgs.polybar.override { alsaSupport = true; };
  };

  # systemd.user.services.polybar = lib.mkDefault {
  #   Unit = { Description = "Launch polybar"; };
  #   Install = { WantedBy = [ "multi-user.target" ]; };
  #   Service = {
  #     ExecStart = "${pkgs.polybar}/bin/polybar";
  #     Restart = "always";
  #     RestartSec = 5;
  #   };
  # };
}
