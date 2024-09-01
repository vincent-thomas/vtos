{
  plugins.fzf-lua = { enable = true; };

  # Custom keymap lua functions
  extraConfigLua = builtins.readFile ./fzf.lua;
}
