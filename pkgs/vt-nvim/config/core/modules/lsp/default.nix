{ config, lib, ... }: {
  options = {
    lsp = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
      };
      servers = {
        nix.enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
        };
        lua.enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
        };
        rust.enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
        };
        typescript.enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
        };
      };
    };
  };

  config = {
    plugins = {
      lsp = {
        enable = config.lsp.enable;
        servers = {
          lua-ls = { enable = config.lsp.servers.lua.enable; };
          nixd = { enable = config.lsp.servers.nix.enable; };
          rust-analyzer = {
            enable = config.lsp.servers.rust.enable;
            installCargo = true;
            installRustc = true;
          };
          tsserver = { enable = config.lsp.servers.typescript.enable; };
        };
      };
    };
    keymaps = [
      {
        key = "[d";
        mode = ["n"];
        action = "<Cmd>lua vim.diagnostic.goto_prev()<CR>";
        options = {
          silent = true;
          desc = "Previous Diagnostic";
        };
      }
      {
        key = "]d";
        mode = ["n"];
        action = "<Cmd>lua vim.diagnostic.goto_next()<CR>";
        options = {
          silent = true;
          desc = "Next Diagnostic";
        };
      }
    ];
  };
}
