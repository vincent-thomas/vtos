{ pkgs, ... }: {
  extraConfigLua = builtins.readFile ./lualine.lua;
  extraPlugins = with pkgs.vimPlugins; [ lualine-nvim ];
}
