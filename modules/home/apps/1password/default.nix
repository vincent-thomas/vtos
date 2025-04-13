{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    vt.config.onepassword = {
      sshIntegration = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Ssh";
      };

      disableWslIntegration = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "install socket";
      };

      zshOpPlugins = {
        gh = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable 1Password plugin for gh";
        };

        cargo = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Cargo plugin for cargo";
        };
        flyctl = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Flyctl plugin for fly.io";
        };
        stripe = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Stripe plugin for stripe";
        };
      };
    };
  };

  config = {
    home.file = lib.mkIf config.vt.config.onepassword.sshIntegration {
      ".ssh/config".text = ''
        Host *
            IdentityAgent "~/.1password/agent.sock"
      '';
    };

    programs.git.extraConfig = lib.mkIf config.vt.config.onepassword.sshIntegration {
      commit.gpgsign = true;
      "gpg \"ssh\"" = lib.mkIf (config.vt.config.onepassword.sshIntegration) {
        program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
      };
    };

    programs.zsh.shellAliases = {
      gh = lib.mkIf config.vt.config.onepassword.zshOpPlugins.gh "op plugin run -- gh";
      cargo = lib.mkIf config.vt.config.onepassword.zshOpPlugins.cargo "op plugin run -- cargo";
      flyctl = lib.mkIf config.vt.config.onepassword.zshOpPlugins.flyctl "op plugin run -- flyctl";
      stripe = lib.mkIf config.vt.config.onepassword.zshOpPlugins.stripe "op plugin run -- stripe";
    };

  };
}
