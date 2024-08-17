{ lib, config, ... }: {
  options = {
    vt.config.onepassword = {
      sshIntegration = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Ssh";
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
          description = "Enable 1Password plugin for cargo";
        };
      };
    };
  };

  config = {
    home.file.".ssh/config".text =
      lib.mkIf config.vt.config.onepassword.sshIntegration ''
        Host *
            IdentityAgent "~/.1password/agent.sock"
      '';

    programs.zsh.shellAliases = {
      gh = lib.mkIf config.vt.config.onepassword.zshOpPlugins.gh
        "op plugin run -- gh";
      cargo = lib.mkIf config.vt.config.onepassword.zshOpPlugins.cargo
        "op plugin run -- cargo";
    };

  };
}

