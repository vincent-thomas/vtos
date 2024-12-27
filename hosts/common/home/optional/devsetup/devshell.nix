{ pkgs, ... }:

{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    starship.enableZshIntegration = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      shellAliases = {
        v = "nvim";
        k = "kubectl";
        kga = "kubectl get all";
        kl = "kubectl logs";
        j = "just --choose";
      };

      localVariables = {
        EDITOR = "nvim";
      };

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

        ${pkgs.nerdfetch}/bin/nerdfetch
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    yazi.enable = true;
    eza = {
      enable = true;
      icons = "auto";
      git = true;
      enableZshIntegration = true;
    };

  };

  home.packages = with pkgs; [
    ripgrep
    gh
    jq
    fd
  ];

}
