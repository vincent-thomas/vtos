{ ... }: {
  imports = [
    ./core

    ./plugins/gitsigns
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

}
