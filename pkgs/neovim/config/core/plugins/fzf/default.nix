{
  plugins.fzf-lua = {
    enable = true;
    iconsEnabled = true;
  };

  # Custom keymap lua functions
  extraConfigLua = builtins.readFile ./fzf.lua;
}
