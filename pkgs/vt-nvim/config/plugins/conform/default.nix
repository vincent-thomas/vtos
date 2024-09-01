{ pkgs, ... }: {

  extraPackages = with pkgs; [ rustfmt stylua prettierd nixfmt ];

  plugins.conform-nvim = { enable = true; };
  extraConfigLua = builtins.readFile ./conform.lua;
}
