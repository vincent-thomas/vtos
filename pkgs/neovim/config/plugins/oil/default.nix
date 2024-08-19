{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ oil-nvim nvim-web-devicons ];
  extraConfigLua = builtins.readFile ./oil.lua;

  keymaps = [{
    action = "<cmd>Oil<cr>";
    key = "-";
    mode = "n";
  }];
}
