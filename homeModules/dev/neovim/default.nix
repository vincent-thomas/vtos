{ pkgs, config, lib, ... }: {
  options = {
    vt.nvim = {
      enable = lib.mkEnableOption "Enable neovim";
      defaultEditor = lib.mkEnableOption "Sets as default editor";
    };
  };

  config = lib.mkIf config.vt.nvim.enable {
    home.file.".config/nvim".source = ./nvim;
    programs.neovim = {
      enable = true;
      inherit (config.vt.nvim) defaultEditor;

      # package = pkgs.neovim;
      extraPackages = with pkgs; [

        # Rust
        rust-analyzer
        rustfmt
        clippy

        # Lua
        lua-language-server
        stylua

        # Nix
        nixd
        nixfmt
        statix

        # Python
        pyright

        # TS/JS 
        nodePackages.typescript-language-server

        # Markdown
        marksman

        # For copilot
        nodejs_22
      ];
    };
  };
}
