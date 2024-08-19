{ ... }: {
  imports = [
    ./core

    ./modules/lsp
    ./modules/cmp

    ./plugins/oil
    ./plugins/gitsigns
    ./plugins/lualine
    ./plugins/fidget
    ./plugins/conform
    ./plugins/comment
  ];

  lsp = {
    enable = true;
    servers = {
      rust.enable = true;
      nix.enable = true;
      lua.enable = true;
    };
  };

  cmp.enable = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = { flavour = "frappe"; };
  };
}
