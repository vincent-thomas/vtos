{ lib, config, pkgs, ... }: {
  options = {
    vt.zsh = {
      enable = lib.mkEnableOption "Enables zsh";
      nvimAlias = lib.mkEnableOption "Should enable 'v' alias";
      starshipIntegration =
        lib.mkEnableOption "Enables starship integration with zsh";
      zoxideIntegration = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables zoxide";
      };

      envVars = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      extraConfig = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Any extra config";
      };

    };
  };

  config = lib.mkIf config.vt.zsh.enable {

    programs = {
      zoxide = {
        enable = config.vt.zsh.zoxideIntegration;
        enableZshIntegration = true;
      };

      starship.enableZshIntegration = config.vt.zsh.starshipIntegration;
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh = {
        enable = true;
        envExtra = config.vt.zsh.envVars;
        dotDir = ".config/zsh";

        shellAliases = { v = lib.mkIf config.vt.zsh.nvimAlias "nvim"; };

        # More .zshrc
        initExtra = ''
          # Yazi can change directory when exists
          function yy() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }

          ${config.vt.zsh.extraConfig}

          ${pkgs.nerdfetch}/bin/nerdfetch
        '';
      };

    };
  };
}
