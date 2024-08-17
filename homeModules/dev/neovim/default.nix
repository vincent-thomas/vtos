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
      defaultEditor = config.vt.nvim.defaultEditor;
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

        # Python
        pyright

        # TS/JS 
        typescript-language-server

        # Markdown
        marksman

        # For copilot
        nodejs_22
      ];
    };
  };
}
