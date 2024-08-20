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
        sessionVariables = { HOME_MNGR_DIR = "$HOME/nix"; };
        dotDir = ".config/zsh";

        shellAliases = { v = lib.mkIf config.vt.zsh.nvimAlias "nvim"; };

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

          nerdfetch
        '';
      };

    };

    home.packages = with pkgs; [ nerdfetch ];
  };
}
