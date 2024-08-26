{ lib, config, ... }: {
  options = {
    cmp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = {
    plugins.cmp-nvim-lsp.enable = config.cmp.enable;
    plugins.cmp-nvim-lua.enable = config.cmp.enable;
    plugins.cmp-path.enable = config.cmp.enable;

    plugins.cmp = {
      enable = config.cmp.enable;
      settings = {
        completion = {
          completeopt = "menu,menuone,preview,noselect";
        };
        mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
              })
          '';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lua"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };
  };

}
