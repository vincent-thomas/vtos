{ pkgs, ... }: {
  extraPlugins =  with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
  ];

  extraConfigLua = builtins.readFile ./treesitter.lua;
}
