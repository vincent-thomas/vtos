{
  plugins.conform-nvim = {enable = true;};

  extraConfigLua = builtins.readFile ./conform.lua;
}
