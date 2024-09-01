{ inputs, ... }:
let inherit (inputs) deploy-rs;
in { self }: {
  nodes = builtins.mapAttrs (_: machine: {
    hostname = machine.config.networking.hostName;
    remoteBuild = false;
    profiles.system = {
      user = "root";
      sshUser = "root";
      path = deploy-rs.lib.${machine.pkgs.system}.activate.nixos machine;
    };
  }) (self.nixosConfigurations or { });
}
